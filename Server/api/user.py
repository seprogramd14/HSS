import uuid, os
from fastapi import APIRouter, Depends, HTTPException, UploadFile
from database.orm import User
from schema.request import SignUpRequest
from database.repository import UserRepository
from schema.respone import UserSchema, JWTResponse
from service.user import UserService
from security import get_access_token

router = APIRouter(prefix="/user")
UPLOAD_URL = "./image"

# user-sign-up : 유저 회원가입 api
# user-log-in : 유저 로그인 api
# user-image : 유저 얼굴 사진 저장 api
# user-delete : 유저 정보 삭제 api


@router.post('/sign-up', status_code=201)
def user_sign_up(
    request: SignUpRequest,
    user_repo: UserRepository = Depends(),
    user_service: UserService = Depends(),
):
    username: User | None = user_repo.get_username(request.username)
    if username is not None:
        raise HTTPException(status_code=422, detail="이미 존재하는 사용자 이름입니다.")
    user_service.check_password(request.password)

    hashed_password: str = user_service.hash_password(
        plain_password=request.password
    )

    user: User = User.create(
        username=request.username,
        hashed_password=hashed_password
    )

    user: User = user_repo.save_user(user=user)

    return UserSchema.model_validate(user)


@router.post('/log-in', status_code=201)
async def user_log_in(
    request: SignUpRequest,
    user_repo: UserRepository = Depends(),
    user_service: UserService = Depends(),
):
    user: User | None = user_repo.get_username(request.username)
    if user is None:
        raise HTTPException(status_code=404, detail="user를 찾지 못했습니다. (User Not Found)")

    verifyed: bool = user_service.verify_password(
        plain_password=request.password,
        hashed_password=user.password,
    )

    if not verifyed:
        raise HTTPException(status_code=401, detail="승인되지 않았습니다. (Not Authorized)")

    access_token: str = user_service.create_jwt(username=user.username)
    return JWTResponse(access_token=access_token)


# 1. 로그인 -> 2. 이미지 선택 -> 3. 이미지 저장 (url을 db에 저장)
@router.post('/image', status_code=201)
async def user_image(
    file: UploadFile,
    access_token: str = Depends(get_access_token),
    user_service: UserService = Depends(),
    user_repo: UserRepository = Depends()
):
    content = await file.read()
    filename = f"{str(uuid.uuid4())}.jpg"
    username: User | None = user_service.decode_jwt(access_token)
    username, image_path = user_repo.save_user_image(username, UPLOAD_URL+'/'+filename)

    with open(os.path.join(UPLOAD_URL, filename), "wb") as f:
        f.write(content)

    return {"username": username, "image_path": image_path}


@router.delete('/delete', status_code=204)
async def user_delete(
    access_token: str = Depends(get_access_token),
    user_repo: UserRepository = Depends(),
    user_service: UserService = Depends(),
):
    username: User | None = user_service.decode_jwt(access_token)
    image_url = user_repo.get_user_image(username)
    user_repo.delete_user(username)

    URL = UPLOAD_URL + image_url
    if os.path.isfile(URL):
        os.remove(URL)

    return {'deleted_username': username}
