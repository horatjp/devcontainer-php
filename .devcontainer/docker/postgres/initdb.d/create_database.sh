#!/bin/bash
set -eu

DATABASE="${POSTGRES_DB}_test"

echo " Creating database '$DATABASE'"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE DATABASE $DATABASE;
  GRANT ALL PRIVILEGES ON DATABASE $DATABASE TO $POSTGRES_USER;
EOSQL
