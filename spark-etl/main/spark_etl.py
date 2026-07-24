import os
from pathlib import Path
import sys

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, when, initcap, current_timestamp


ROOT_DIR = Path(__file__).resolve().parents[1]
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))


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


def _env(name: str, default: str) -> str:
    return os.getenv(name, default)

def main():
    

    # ----------------------------------------------------
    # 1. INITIALIZATION (Create Spark Session)
    # ----------------------------------------------------
    spark = SparkSession.builder \
        .appName("DatabaseToDatabaseETL") \
        .getOrCreate()

  
    
    print(">>> Spark Session started successfully.")

    spark.sparkContext.setLogLevel("INFO")  

    # ----------------------------------------------------
    # 2. EXTRACT (Read data from Source Database - SQL Server)
    # ----------------------------------------------------
    source_database = _env("SQLSERVER_SOURCE_DATABASE", "source_warehouse")
    src_url = (
        f"jdbc:sqlserver://{_env('SQLSERVER_HOST', 'localhost')}:{_env('SQLSERVER_PORT', '1433')}"
        f";databaseName={source_database}"
        f";encrypt={_env('SQLSERVER_ENCRYPT', 'true')}"
        f";trustServerCertificate={_env('SQLSERVER_TRUST_SERVER_CERTIFICATE', 'true')};"
    )
    src_properties = {
        "user": _env("SQLSERVER_USER", "sa"),
        "password": _env("SQLSERVER_PASSWORD", "P@ssw0rd"),
        "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver",
    }
    
    print(">>> Extracting data from SQL Server source table...")
    # Load raw data from a source table into a Spark DataFrame
    raw_users_df = spark.read.jdbc(
        url=src_url, 
        table="source_warehouse.raw_customer", 
        properties=src_properties
    )

    # ----------------------------------------------------
    # 3. TRANSFORM (Clean, filter, and enrich data)
    # ----------------------------------------------------
    print(">>> Transforming data...")
    transformed_df = raw_users_df \
        .filter(col("email").contains("@")) \
        .withColumn("first_name", initcap(col("first_name"))) \
        .withColumn("processed_at", current_timestamp())

    # ----------------------------------------------------
    # 4. LOAD (Write data to Target Database - MySQL)
    # ----------------------------------------------------
    # Define connection properties for the destination database
    target_url = f"jdbc:mysql://{_env('MYSQL_HOST', 'localhost')}:{_env('MYSQL_PORT', '3306')}/{_env('MYSQL_DATABASE', 'target_analytics')}"
    target_properties = {
        "user": _env("MYSQL_USER", "mysql_user"),
        "password": _env("MYSQL_PASSWORD", "another_secure_password"),
        "driver": "com.mysql.cj.jdbc.Driver",
    }

    print(">>> Loading transformed data into MySQL target table...")
    # Modes: "append" (add rows), "overwrite" (replace table), "ignore", "errorifexists"
    transformed_df.write.jdbc(
        url=target_url, 
        table="clean_transactions", 
        mode="overwrite", 
        properties=target_properties
    )

    print(">>> ETL Pipeline completed successfully!")
    
    # Stop the session to free cluster resources
    spark.stop()

if __name__ == "__main__":
    main()
