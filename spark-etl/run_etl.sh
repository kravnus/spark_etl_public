#!/bin/bash

# run using chmod +x run_etl.sh
# ./run_etl.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/.env" ]; then
  set -a
  # shellcheck disable=SC1090
  source "$SCRIPT_DIR/.env"
  set +a
fi

MYSQL_HOST="${MYSQL_HOST:-127.0.0.1}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
MYSQL_USER="${MYSQL_USER:-root}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-}"
MYSQL_DATABASE="${MYSQL_DATABASE:-arms}"

BACKEND_DIR="/Users/dev2/Desktop/Amier Workspace/ARMS/ARMS/Backend/Management-System-Backend"

echo "========================================="
echo " Reset ARMS Local Database + ETL Metadata"
echo "========================================="

#########################################
# 1. Drop & Recreate Database
#########################################

echo "Dropping and recreating ARMS database..."

MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" <<EOF
DROP DATABASE IF EXISTS $MYSQL_DATABASE;
CREATE DATABASE $MYSQL_DATABASE;
EOF

#########################################
# 2. Laravel Migration + Seeder
#########################################

echo "Running Laravel migrations..."

cd "$BACKEND_DIR" || exit

php artisan migrate --seed

#########################################
# 3. Add legacy_ids column
#########################################

echo "Adding legacy_ids column..."

MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" "$MYSQL_DATABASE" <<EOF

ALTER TABLE users
ADD COLUMN legacy_ids JSON NULL AFTER username;

EOF

#########################################
# 4. Spark ETL Project
#########################################

echo "Moving to Spark ETL project..."

cd "$SCRIPT_DIR" || exit

#########################################
# 5. Create Metadata Tables
#########################################

echo "Creating metadata tables..."

MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" "$MYSQL_DATABASE" < control-table/ddl/ddl

#########################################
# 6. Seed Metadata
#########################################

echo "Importing metadata..."

sed 's/target_analytics\.//g' control-table/ddl/migration_control_202607030018.sql \
| MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" "$MYSQL_DATABASE"

sed 's/target_analytics\.//g' control-table/ddl/migration_source_tables_202607030018.sql \
| MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" "$MYSQL_DATABASE"

sed 's/target_analytics\.//g' control-table/ddl/migration_joins_202607030018.sql \
| MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" "$MYSQL_DATABASE"

sed 's/target_analytics\.//g' control-table/ddl/migration_column_mapping_202607030018.sql \
| MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" "$MYSQL_DATABASE"

#########################################
# 7. Drop email unique constraint (allow duplicate/empty emails during ETL)
#########################################

echo "Dropping email unique constraint and NOT NULL requirement..."

MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" "$MYSQL_DATABASE" <<EOF
ALTER TABLE users DROP INDEX users_email_unique;
ALTER TABLE users MODIFY COLUMN email VARCHAR(255) NULL;
EOF

#########################################
# 8. Run Spark ETL
#########################################

echo "Running Spark ETL..."

spark-submit \
  --packages com.mysql:mysql-connector-j:8.3.0,com.microsoft.sqlserver:mssql-jdbc:12.6.1.jre11 \
  control-table/spark-control-etl.py

#########################################
# 9. Re-add email unique constraint
#########################################

echo "Re-adding email unique constraint (column stays nullable to allow legacy users with no email)..."

MYSQL_PWD="$MYSQL_PASSWORD" mysql -u "$MYSQL_USER" -h "$MYSQL_HOST" -P "$MYSQL_PORT" "$MYSQL_DATABASE" <<EOF
ALTER TABLE users ADD UNIQUE INDEX users_email_unique (email);
EOF

echo ""
echo "========================================="
echo " ETL Completed"
echo "========================================="
