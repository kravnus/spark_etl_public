import pymysql
from datetime import datetime

MYSQL_HOST = 'localhost'
MYSQL_PORT = 3306
MYSQL_DB = 'target_analytics'
MYSQL_USER = 'mysql_user'
MYSQL_PASSWORD = 'another_secure_password'


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
