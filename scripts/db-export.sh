#!/bin/bash
# =============================================================
# scripts/db-export.sh — Export local MariaDB to SQL file
# Usage: bash scripts/db-export.sh
# Output: scripts/petty_backup_<timestamp>.sql
# =============================================================
set -euo pipefail

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="scripts/petty_backup_${TIMESTAMP}.sql"

# Load local .env to read DB credentials
ENV_FILE="petty_BE/.env"
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Error: $ENV_FILE not found. Run from project root."
  exit 1
fi

# Parse .env for DB variables (skip comments and empty lines)
DB_HOST=$(grep -E "^DB_HOST=" "$ENV_FILE" | cut -d= -f2 | tr -d '"' | tr -d "'")
DB_PORT=$(grep -E "^DB_PORT=" "$ENV_FILE" | cut -d= -f2 | tr -d '"' | tr -d "'")
DB_DATABASE=$(grep -E "^DB_DATABASE=" "$ENV_FILE" | cut -d= -f2 | tr -d '"' | tr -d "'")
DB_USERNAME=$(grep -E "^DB_USERNAME=" "$ENV_FILE" | cut -d= -f2 | tr -d '"' | tr -d "'")
DB_PASSWORD=$(grep -E "^DB_PASSWORD=" "$ENV_FILE" | cut -d= -f2 | tr -d '"' | tr -d "'")

DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-3306}"

echo "==> Kiểm tra charset trước khi export..."
mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USERNAME" -p"$DB_PASSWORD" "$DB_DATABASE" \
  -e "SHOW VARIABLES LIKE 'character_set%'; SHOW VARIABLES LIKE 'collation%';" 2>/dev/null

echo ""
echo "==> Exporting database '$DB_DATABASE' → $OUTPUT_FILE ..."

# Export with explicit charset and all necessary options
mysqldump \
  -h "$DB_HOST" \
  -P "$DB_PORT" \
  -u "$DB_USERNAME" \
  -p"$DB_PASSWORD" \
  --default-character-set=utf8mb4 \
  --single-transaction \
  --routines \
  --triggers \
  --events \
  --set-gtid-purged=OFF \
  --no-tablespaces \
  "$DB_DATABASE" > "$OUTPUT_FILE"

FILE_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
echo "✅ Export thành công: $OUTPUT_FILE ($FILE_SIZE)"
echo ""
echo "==> Hướng dẫn import lên RDS:"
echo "  1. Copy file lên bastion: scp $OUTPUT_FILE ec2-user@<bastion-ip>:~/"
echo "  2. SSH vào bastion: ssh ec2-user@<bastion-ip>"
echo "  3. Import: mysql -h <rds-endpoint> -u admin -p petty < ~/$(basename $OUTPUT_FILE)"
