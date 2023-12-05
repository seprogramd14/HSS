import bcrypt
from datetime import datetime, timedelta
from jose import jwt
import cv2
from fastapi import HTTPException


class UserService:
    message: str = "비밀번호는 8자리 이상 영문과 숫자를 포함해서 작성해주세요"
    encoding: str = "UTF-8"
    secret_key = "3a3r340tjas3jfj3jaj30jfjjeu3uey2"
    jwt_algorithm = "HS256"

    def check_password(self, password, check_password):
        if len(password) < 8:
            raise HTTPException(status_code=422, detail=self.message)

        if not any(char.isdigit() for char in password):
            raise HTTPException(status_code=422, detail=self.message)

        if not any(char.isalpha() for char in password):
            raise HTTPException(status_code=422, detail=self.message)

        if password != check_password:
            raise HTTPException(status_code=422, detail="비밀번호가 일치하지 않습니다.")

    def hash_password(self, plain_password: str) -> str:
        hashed_password: bytes = bcrypt.hashpw(
            plain_password.encode(self.encoding),
            salt=bcrypt.gensalt()
        )
        return hashed_password.decode(self.encoding)

    def verify_password(self, plain_password: str, hashed_password: str) -> bool:
        return bcrypt.checkpw(
            plain_password.encode(self.encoding),
            hashed_password.encode(self.encoding)
        )

    def create_jwt(self, username: str) -> str:
        return jwt.encode(
            {
                "sub": username,
                "exp": datetime.now() + timedelta(days=1)
            },
            self.secret_key,
            algorithm=self.jwt_algorithm,
        )

    def decode_jwt(self, access_token: str):
        payload = jwt.decode(
            access_token, self.secret_key, algorithms=[self.jwt_algorithm]
        )

        return payload['sub']  # username의 정보가 있음
