from pyspark.sql import SparkSession

# Initialize Spark Session
spark = SparkSession.builder \
    .appName("SQL Server Read Example") \
    .getOrCreate()

# Define connection properties
jdbc_url = "jdbc:sqlserver://localhost:1433;databaseName=mStudioBilling;encrypt=true;trustServerCertificate=true;"
table_name = "dbo.MI_Common_Users"
username = "sa"
password = "StrongP@ssword"

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