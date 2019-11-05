#!/bin/bash
set -e

source ./scripts/gpdb6-environment.sh
source ./gpdb6-installation/greenplum_path.sh

# uninstall PL/Java: NOTE uninstall.sql is deprecated in 6X
psql -p 60000 -d postgres -c 'DROP EXTENSION pljava;'

# remove the PL/Java package
gppkg -r pljava-2.0.2
