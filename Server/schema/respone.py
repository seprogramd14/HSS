from typing import List
from pydantic import BaseModel, ConfigDict


class UserSchema(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: int
    username: str


class JWTResponse(BaseModel):
    access_token: str
