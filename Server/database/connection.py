# 데이터베이스 연결

from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine

DATABASE_URL = "mysql+pymysql://root:hss@127.0.0.1:3306/hss"

engine = create_engine(DATABASE_URL)
SessionFactory = sessionmaker(autocommit=False, autoflush=False, bind=engine)


def get_db():
    session = SessionFactory()
    try:
        yield session
    finally:
        session.close()

# from sqlalchemy.schema import CreateTable
# from database.orm import ToDo
# from database.connection import engine
# print(CreateTable(ToDo.__table__).compile(engine))


# docker exec -it hss bash
# mysql -u root -p
# docker 접속 후 use (테이블 이름) 쓰기

# ALTER TABLE [테이블명] AUTO_INCREMENT=1;
# id 숫자 변경
# SET @COUNT = 0;
# UPDATE [테이블명] SET [AUTO_INCREMENT 열 이름] = @COUNT:=@COUNT+1;
