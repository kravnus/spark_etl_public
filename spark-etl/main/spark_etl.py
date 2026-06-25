from pyspark.sql import SparkSession
from pyspark.sql.functions import col, when, initcap, current_timestamp

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
    # 2. EXTRACT (Read data from Source Database - PostgreSQL)
    # ----------------------------------------------------
    # Define connection properties for the source database
    src_url = "jdbc:postgresql://localhost:5432/warehouse_db"
    src_properties = {
        "user": "postgres",
        "password": "mysecretpassword",
        "driver": "org.postgresql.Driver"
    }
    
    print(">>> Extracting data from PostgreSQL source table...")
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
    target_url = "jdbc:mysql://localhost:3306/target_analytics"
    target_properties = {
        "user": "mysql_user",
        "password": "another_secure_password",
        "driver": "com.mysql.cj.jdbc.Driver"
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