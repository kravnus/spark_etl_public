import os
from pathlib import Path
import sys

from pyspark.sql import SparkSession

# Initialize Spark Session
spark = SparkSession.builder \
    .appName("SQL Server Read Example") \
    .getOrCreate()

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

# Define connection properties
jdbc_url = (
    f"jdbc:sqlserver://{os.getenv('SQLSERVER_HOST', 'localhost')}:{os.getenv('SQLSERVER_PORT', '1433')}"
    f";databaseName={os.getenv('SQLSERVER_BILLING_DATABASE', 'mStudioBilling')}"
    f";encrypt={os.getenv('SQLSERVER_ENCRYPT', 'true')}"
    f";trustServerCertificate={os.getenv('SQLSERVER_TRUST_SERVER_CERTIFICATE', 'true')};"
)
table_name = "dbo.MI_Common_Users"
username = os.getenv("SQLSERVER_USER", "sa")
password = os.getenv("SQLSERVER_PASSWORD", "StrongP@ssword")

# Read data from the SQL Server table into a DataFrame
df = spark.read \
    .format("jdbc") \
    .option("url", jdbc_url) \
    .option("dbtable", table_name) \
    .option("user", username) \
    .option("password", password) \
    .option("driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver") \
    .load()

# Show the schema and first few rows of data
df.printSchema()

text= "number of rows: "
dfResult = df.select(["UserName"])
print(f"{text }{dfResult.count()}")
