from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from api import user, video

app = FastAPI()

app.include_router(user.router)
app.include_router(video.router)

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
