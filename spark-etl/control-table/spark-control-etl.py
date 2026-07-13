import os
from pathlib import Path
import sys

from pyspark.sql import SparkSession
from pyspark.sql.functions import expr
from datetime import datetime

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

# ----------------------------------------------------
# 1. INITIALIZATION (Create Spark Session)
# ----------------------------------------------------
#

spark = SparkSession.builder \
    .appName("MetadataMigration") \
    .getOrCreate()

print(">>> Spark Session started successfully.")
spark.sparkContext.setLogLevel("ERROR")  

# ----------------------------------------------------
# 2. EXTRACT (Read data from Source Database - PostgreSQL)
# ----------------------------------------------------
# Define connection properties for the source database

# change this to sql server at the end.
src_url = f"jdbc:postgresql://{_env('POSTGRES_HOST', 'localhost')}:{_env('POSTGRES_PORT', '5432')}/{_env('POSTGRES_DATABASE', 'warehouse_db')}"
src_properties = {
    "user": _env("POSTGRES_USER", "postgres"),
    "password": _env("POSTGRES_PASSWORD", "mysecretpassword"),
    "driver": "org.postgresql.Driver",
}

sql_common_url = (
    f"jdbc:sqlserver://{_env('SQLSERVER_HOST', 'localhost')}:{_env('SQLSERVER_PORT', '1433')}"
    f";databaseName={_env('SQLSERVER_COMMON_DATABASE', 'mStudioCommon')}"
    f";encrypt={_env('SQLSERVER_ENCRYPT', 'true')}"
    f";trustServerCertificate={_env('SQLSERVER_TRUST_SERVER_CERTIFICATE', 'true')};"
)
src_common_properties = {
    "user": _env("SQLSERVER_USER", "sa"),
    "password": _env("SQLSERVER_PASSWORD", "StrongP@ssword"),
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver",
}



# ----------------------------------------------------
# 3. WRITE (Write data to target Database - MYSQL)
# ----------------------------------------------------
# Define connection properties for the target database

target_url = f"jdbc:mysql://{_env('MYSQL_HOST', 'localhost')}:{_env('MYSQL_PORT', '3306')}/{_env('MYSQL_DATABASE', 'target_analytics')}"
target_properties = {
    "user": _env("MYSQL_USER", "mysql_user"),
    "password": _env("MYSQL_PASSWORD", "another_secure_password"),
    "driver": "com.mysql.cj.jdbc.Driver",
}

def main():

    
    print(">>> Extracting data from PostgreSQL source table...")
    # Load raw data from a source table into a Spark DataFrame
    raw_users_df = load_source_table("source_warehouse", "raw_customer");
#    raw_users_df.show()


    # print(">>> Extracting data from sql server source table...")
    # Load raw data from a source table into a Spark DataFrame
    # raw_users_df = load_sql_source_table("dbo", "banks");
    # raw_users_df.show()

    # exit()

    print("Display all the control tables.")

    migration_control = load_control_table(
        "migration_control"
    ).filter("enabled = true")
    migration_control.show()

    source_tables_cfg = load_control_table(
        "migration_source_tables"
    )
    source_tables_cfg.show()

    joins_cfg = load_control_table(
        "migration_joins"
    )
    joins_cfg.show()

    mapping_cfg = load_control_table(
        "migration_column_mapping"
    )
    mapping_cfg.show()

    #only fetch enabled jobs.
    migration_control = migration_control.filter(migration_control['enabled'])
    jobs = migration_control.collect()

    #loop through each job that is enabled.
    for job in jobs:
        migration_id = job["migration_id"]
        target_table = job["target_table"]
        load_type = job["load_type"]
        watermark_column = job["watermark_column"]
        last_load = job["last_successful_load"]
        
        print(job)

        sources = source_tables_cfg \
            .filter(
                source_tables_cfg.migration_id == migration_id
            ) \
            .orderBy("join_order") \
            .collect()
        
        print(*sources)

        
        source_dfs = {}
        #load all the source tables into an array of dataframes
        for src in sources:

            alias = src["table_alias"]

            # ----------------------------------------------------
            # 4. Load all the source tables.
            # ----------------------------------------------------
            # Define connection properties for the target database

            # df = load_sql_source_table(
                # src["source_schema"],
                # src["source_table"]
            # )

            df = load_sql_generic_source_table(src["source_schema"],src["source_schema"], src["source_table"])

            df.show()
            
            source_dfs[alias] = df
            #disable this first.
            #df = df.filter(df['deleted'] == False)
            print("%%%%%%%%%%%%%%%%%%%%%%%")
            if src['filter'] :
                df = df.filter(src['filter'])
            
            source_dfs[alias] = df
            
            

        root_alias = sources[0]["table_alias"]
        result_df = source_dfs[root_alias].alias(root_alias)

        join_rows = joins_cfg \
                .filter(
                    joins_cfg.migration_id == migration_id
                ) \
                .collect()

        #for each join configuration
        for join_cfg in join_rows:

                right_alias = join_cfg["right_alias"]

                result_df = result_df.join(
                    source_dfs[right_alias].alias(right_alias),
                    expr(join_cfg["join_condition"]),
                    join_cfg["join_type"].lower()
                )
        
        #used for incremental loading.
        if load_type == "INCREMENTAL":
                watermark = (
                    "1900-01-01 00:00:00"
                    if last_load is None
                    else str(last_load)
                )
                result_df = result_df.filter(
                    expr(
                        f"{watermark_column} > "
                        f"TIMESTAMP('{watermark}')"
                    )
                )
            
        #fetch all the column mapping for the active migration_id
        mappings = mapping_cfg \
                .filter(
                    mapping_cfg.migration_id == migration_id
                ) \
                .orderBy("sequence_no") \
                .collect()

        target_columns = []

        for mapping in mappings:

                source_expr = mapping["source_expression"]
                transform_expr = mapping["transformation_expression"]
                target_column = mapping["target_column"]

                if transform_expr:
                    target_columns.append(
                        expr(transform_expr).alias(target_column)
                    )

                else:
                    target_columns.append(
                        expr(source_expr).alias(target_column)
                    )

        print(target_columns)
        
        final_df = result_df.select(*target_columns)



        print("final_df")
        final_df.show(n=df.count(), truncate=False)
        print(target_url)
        print(target_table)
        print(target_properties)
        final_df.write \
                .jdbc(
                    url=target_url,
                    table=target_table,
                    mode=job["write_mode"],
                    properties=target_properties
                )

        update_time = datetime.now()

        print(
                f"Migrated {migration_id} "
                f"Rows={final_df.count()}"
        )
            
#   Update migration_control.last_successful_load
#    Typically implemented using a JDBC UPDATE
#   code written in spark-update-control-table.py

    spark.stop()
    
    

def load_control_table(table_name):
    return spark.read.jdbc(
        url=target_url,
        table=table_name,
        properties=target_properties
    )


def load_source_table(schema_name, table_name):
    return spark.read.jdbc(
        url=src_url,
        table=f"{schema_name}.{table_name}",
        properties=src_properties
    )

# def load_sql_source_table(schema_name, table_name):
    # return spark.read.jdbc(
        # url=sql_common_url,
        # table=f"{schema_name}.{table_name}",
        # properties=src_common_properties
    # )

def load_sql_generic_source_table(generic,schema_name, table_name):
    
    sql_generic_url = (
        f"jdbc:sqlserver://{_env('SQLSERVER_HOST', 'localhost')}:{_env('SQLSERVER_PORT', '1433')}"
        f";databaseName={generic}"
        f";encrypt={_env('SQLSERVER_ENCRYPT', 'true')}"
        f";trustServerCertificate={_env('SQLSERVER_TRUST_SERVER_CERTIFICATE', 'true')};"
    )
    print(f"{sql_generic_url}")

    return spark.read.jdbc(
        url=f"{sql_generic_url}",
        table=f"{schema_name}.{table_name}",
        properties=src_common_properties
    )


if __name__ == "__main__":
    main()
