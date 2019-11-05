#!/bin/bash
set -e

#source scripts/gpdb5-environment.sh
#source gpdb5-installation/greenplum_path.sh

# install jdk
sudo apt-get install -y default-jdk rpm

# download and add PL/Java package
pivnet download-product-files -p pivotal-gpdb -r 5.22.0 -i 504930
MASTER_DATA_DIRECTORY="$HOME/gpdb5-data/qddir/demoDataDir-1" gppkg -i pljava-1.4.4-gp5-rhel7-x86_64.gppkg

# add java to paths in greenplum_path.sh
echo "export LD_LIBRARY_PATH=$JAVA_HOME/lib/server:$LD_LIBRARY_PATH" >> $HOME/gpdb5-installation/greenplum_path.sh

source $HOME/gpdb5-installation/greenplum_path.sh

# restart cluster to load settings
$HOME/gpdb5-installation/bin/gpstop -ra

java --version

# install PL/Java
$HOME/gpdb5-installation/bin/psql -p 50000 testdb -c 'CREATE EXTENSION pljava;'
