from pydantic import BaseModel, field_validator, ConfigDict
from fastapi import HTTPException


class SignUpRequest(BaseModel):
    username: str
    password: str
    password_check: str
    model_config = ConfigDict(from_attributes=True)

    @field_validator('username', 'password', 'password_check')
    def check_empty(cls, v):
        if not v or v.isspace():
            raise HTTPException(status_code=422, detail="필수 항목을 입력하세요")
        return v


class LogInRequest(BaseModel):
    username: str
    password: str
    model_config = ConfigDict(from_attributes=True)

    @field_validator('username', 'password')
    def check_empty(cls, v):
        if not v or v.isspace():
            raise HTTPException(status_code=422, detail="필수 항목을 입력하세요")
        return v
