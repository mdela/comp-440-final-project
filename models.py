from sqlalchemy import create_engine, Column, Integer, String, MetaData, Table, select
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
# from . import db





# Create a declarative base for models
# Base = declarative_base()

# Define database connection details
DATABASE_URI = 'mysql+mysqlconnector://root:password@localhost/comp440'
# Create engine for database connection
engine = create_engine(DATABASE_URI, echo=True)
conn = engine.connect()
# Reflect existing tables from the database
metadata = MetaData()
users_table = Table('users', metadata, mysql_autoload=True, autoload_with=engine)
# Base.metadata.reflect(engine)

# Define User model class
class User:
    __table__ = users_table

    # Access columns based on their names in the table
    # id = Column(Integer, primary_key=True)
    # username = Column(String(255), unique=True, nullable=False)
    # password_hash = Column(String(255), nullable=False)

# Create session class for interacting with database
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
