from fastapi import FastAPI
from api import user, video

app = FastAPI()

app.include_router(user.router)
app.include_router(video.router)
