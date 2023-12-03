import uuid, os
from fastapi import APIRouter, Depends, HTTPException, UploadFile

from database.orm import User
from schema.request import SignUpRequest
from database.repository import UserRepository
from schema.respone import UserSchema, JWTResponse
from service.user import UserService
from security import get_access_token

router = APIRouter(prefix="/user")

# db 사용

# user-sign-up : 유저 회원가입 api
# user-log-in : 유저 로그인 api
# user-image : 유저 얼굴 사진 저장 api


@router.post('/sign-up', status_code=201)
def user_sign_up(
    # 1. request body
    request: SignUpRequest,
    user_repo: UserRepository = Depends(),
    user_service: UserService = Depends(),
):
    # 2. username, password 검증
    username: User | None = user_repo.get_username(request.username)
    if username is not None:
        raise HTTPException(status_code=422, detail="이미 존재하는 사용자 이름입니다.")
    user_service.check_password(request.password)

    # 3. password
    hashed_password: str = user_service.hash_password(
        plain_password=request.password
    )

    # 4. User(username, password)
    user: User = User.create(
        username=request.username,
        hashed_password=hashed_password
    )

    # 5. user -> db
    user: User = user_repo.save_user(user=user)

    # 6. return user(id, username)
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


# 1. 로그인 -> 2. 이미지 선택 -> 3. 이미지 저장 (url을 db에 저장) -> 4. 끝
@router.post('/image', status_code=201)
async def user_image(
    file: UploadFile,
    access_token: str = Depends(get_access_token),
    user_service: UserService = Depends(),
    user_repo: UserRepository = Depends()
):
    UPLOAD_URL = "./image"

    content = await file.read()
    filename = f"{str(uuid.uuid4())}.jpg"
    username: User | None = user_service.decode_jwt(access_token)
    username, image_path = user_repo.save_user_image(username, UPLOAD_URL+'/'+filename)

    with open(os.path.join(UPLOAD_URL, filename), "wb") as f:
        f.write(content)

    return {"username": username, "image_path": image_path}
