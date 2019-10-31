#!/bin/bash
set -e

source scripts/gpdb5-environment.sh
source gpdb5-installation/greenplum_path.sh

# install jdk
sudo apt-get install -y default-jdk

# download and add PL/Java package
pivnet download-product-files -p pivotal-gpdb -r 5.22.0 -i 504930
gppkg -i pljava-1.4.4-gp5-rhel7-x86_64.gppkg

# add java to paths in greenplum_path.sh
echo "JAVA_HOME=/usr/lib/jvm/default-java" >> $HOME/gpdb5-installation/greenplum_path.sh
echo "export JAVA_HOME" >> $HOME/gpdb5-installation/greenplum_path.sh
echo "export LD_LIBRARY_PATH=$JAVA_HOME/lib/server:$LD_LIBRARY_PATH" >> $HOME/gpdb5-installation/greenplum_path.sh

# install PL/Java
psql -p 50000 -f $HOME/gpdb5-installation/share/postgresql/pljava/install.sql postgres

# restart cluster to load settings
gpstop -ar
