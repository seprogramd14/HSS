from pydantic import BaseModel, field_validator
from fastapi import HTTPException


class SignUpRequest(BaseModel):
    username: str
    password: str

    @field_validator('username', 'password')
    def check_empty(cls, v):
        if not v or v.isspace():
            raise HTTPException(status_code=422, detail="필수 항목을 입력하세요")
        return v