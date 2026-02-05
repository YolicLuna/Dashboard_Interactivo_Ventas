import os

DEFAULT_DB_URL = 'mysql+pymysql://root:Moon712deV@localhost:3306/Aurelion_Dashboard?charset=utf8mb4'
DATABASE_URL = os.getenv('DATABASE_URL', DEFAULT_DB_URL)

def get_database_url() -> str:
    return DATABASE_URL
