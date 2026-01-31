import os

DEFAULT_DB_URL = 'mysql+pymysql://moondev:Dev321@localhost:3306/Aurelion_Dashboard'
DATABASE_URL = os.getenv('DATABASE_URL', DEFAULT_DB_URL)

def get_database_url() -> str:
    return DATABASE_URL
