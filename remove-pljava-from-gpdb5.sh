#!/bin/bash
set -e

source ./scripts/gpdb5-environment.sh
source ./gpdb5-installation/greenplum_path.sh

# uninstall PL/Java
psql -p 50000 -f $HOME/gpdb5-installation/share/postgresql/pljava/uninstall.sql postgres

# remove the PL/Java package
gppkg -r pljava-1.4.4

# remove java paths from greenplum_path.sh
sed --in-place '/JAVA_HOME/d' $HOME/gpdb5-installation/greenplum_path.sh
sed --in-place '/LD_LIBRARY_PATH/d' $HOME/gpdb5-installation/greenplum_path.sh
