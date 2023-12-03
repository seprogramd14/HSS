from sqlalchemy import select, update
from sqlalchemy.orm import Session
from fastapi import Depends

from database.connection import get_db
from database.orm import User


class UserRepository:
    def __init__(self, session: Session = Depends(get_db)):
        self.session = session

    def get_username(self, username: str) -> User:
        return self.session.scalar(select(User).where(User.username == username))

    def save_user(self, user: User):  # 유저 정보 저장
        self.session.add(instance=user)
        self.session.commit()
        self.session.refresh(instance=user)
        return user

    def save_user_image(self, username: str, image_path: str):
        self.session.execute(update(User).where(User.username == username).values(img_url=image_path))
        self.session.commit()
        return username, image_path
