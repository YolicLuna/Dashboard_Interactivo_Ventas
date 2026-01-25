import os

DEFAULT_DB_URL = 'mysql+pymysql://nombre de usuario:contraseña@localhost:3306/Nombre de la base de datos'
DATABASE_URL = os.getenv('DATABASE_URL', DEFAULT_DB_URL)

def get_database_url() -> str:
    return DATABASE_URL
