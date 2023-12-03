from fastapi import FastAPI
from api import user, video

app = FastAPI()

app.include_router(user.router)
app.include_router(video.router)
# video : 카메라 활성 api


# db 사용

# user-sign-up : 유저 회원가입 api
# user-log-in : 유저 로그인 api
# user-image : 유저 얼굴 사진 저장 api
# log : 로그 확인 api


@app.get('/log')
def get_log():
    return
