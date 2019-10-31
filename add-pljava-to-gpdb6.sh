#!/bin/bash
set -e

source scripts/gpdb6-environment.sh
source gpdb6-installation/greenplum_path.sh

# install jdk
sudo apt-get install -y default-jdk

# download and add PL/Java package
pivnet download-product-files -p pivotal-gpdb -r 6.0.1 -i 505633
gppkg -i pljava-2.0.2-gp6-ubuntu18.04_x86_64.gppkg

# add java to paths in greenplum_path.sh
echo "JAVA_HOME=/usr/lib/jvm/default-java" >> $HOME/gpdb6-installation/greenplum_path.sh
echo "export JAVA_HOME" >> $HOME/gpdb6-installation/greenplum_path.sh
echo "export LD_LIBRARY_PATH=$JAVA_HOME/lib/server:$LD_LIBRARY_PATH" >> $HOME/gpdb6-installation/greenplum_path.sh

# restart cluster to load settings
gpstop -u

# install PL/Java: NOTE install.sql is deprecated in 6X
psql -p 60000 -d postgres -c 'CREATE EXTENSION pljava;'
