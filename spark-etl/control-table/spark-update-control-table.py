import os

import pymysql
from datetime import datetime

from pathlib import Path

ROOT_DIR = Path(__file__).resolve().parents[1]


def _load_env_file() -> None:
    env_file = ROOT_DIR / ".env"
    if not env_file.exists():
        return

    with env_file.open("r", encoding="utf-8") as handle:
        for raw_line in handle:
            line = raw_line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, value = line.split("=", 1)
            os.environ.setdefault(key.strip(), value.strip().strip("'").strip('"'))


_load_env_file()

MYSQL_HOST = os.getenv("MYSQL_HOST", "localhost")
MYSQL_PORT = int(os.getenv("MYSQL_PORT", "3306"))
MYSQL_DB = os.getenv("MYSQL_DATABASE", "target_analytics")
MYSQL_USER = os.getenv("MYSQL_USER", "mysql_user")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD", "another_secure_password")


def update_last_successful_load(
        migration_id):

    conn = pymysql.connect(
        host=MYSQL_HOST,
        port=MYSQL_PORT,
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        database=MYSQL_DB
    )

    try:

        with conn.cursor() as cursor:

            sql = """
            UPDATE migration_control
            SET
                last_successful_load = now()
            WHERE migration_id = %s
            """

            cursor.execute(
                sql,
                (
                    migration_id
                )
            )

        conn.commit()

    finally:
        conn.close()



update_last_successful_load(
    migration_id=1
)
