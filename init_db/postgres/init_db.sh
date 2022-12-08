#!/bin/bash
set -eux

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Demo PostgreSQL Database initialisation
psql postgres -c "CREATE USER testuser PASSWORD 'testpass'"
#The -O flag below sets the user: createdb -O DBUSER DBNAME
createdb -O testuser testdb

psql -d testdb -U testuser -f $THISDIR/01_schema.sql
psql -d testdb -U testuser -f $THISDIR/02_inserts.sql
