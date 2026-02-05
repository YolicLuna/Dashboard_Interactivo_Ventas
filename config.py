import os

DEFAULT_DB_URL = 'mysql+pymysql://root:TuContraseña@localhost:3306/NombreBaseDatos?charset=utf8mb4'
DATABASE_URL = os.getenv('DATABASE_URL', DEFAULT_DB_URL)

def get_database_url() -> str:
    return DATABASE_URL
