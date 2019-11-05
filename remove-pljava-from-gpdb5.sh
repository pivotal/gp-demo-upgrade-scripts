#!/bin/bash
set -e

source ./scripts/gpdb5-environment.sh
source ./gpdb5-installation/greenplum_path.sh

# uninstall PL/Java
$HOME/gpdb5-installation/bin/psql -p 50000 testdb -c 'DROP EXTENSION pljava;'

# remove the PL/Java package
gppkg -r pljava-1.4.4

# remove java paths from greenplum_path.sh
sed --in-place '/JAVA_HOME/d' $HOME/gpdb5-installation/greenplum_path.sh
sed --in-place '/export LD_LIBRARY_PATH=.*default-java/d' $HOME/gpdb5-installation/greenplum_path.sh
