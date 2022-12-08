#!/bin/bash
set -eux

THISDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Demo PostgreSQL Database initialisation
# psql postgres -c "CREATE USER testuser PASSWORD 'testpass'"
#The -O flag below sets the user: createdb -O DBUSER DBNAME
# createdb -O testuser testdb
# creates a db with the default name (name of current user)
createdb
psql -f $THISDIR/01_schema.sql
psql -f $THISDIR/02_inserts.sql
