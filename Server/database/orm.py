from sqlalchemy import String, Column, Integer
from sqlalchemy.orm import declarative_base

Base = declarative_base()


class User(Base):
    __tablename__ = "user"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(256), nullable=False, unique=True)
    password = Column(String(256), nullable=False)
    img_url = Column(String(256), nullable=True)
    # email, phone

    @classmethod
    def create(cls, username: str, hashed_password: str) -> "User":
        return cls(
            username=username,
            password=hashed_password
        )