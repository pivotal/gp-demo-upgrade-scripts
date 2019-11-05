#!/bin/bash
set -e

source scripts/gpdb6-environment.sh
source gpdb6-installation/greenplum_path.sh

# install jdk
sudo apt-get install -y default-jdk

# setup JAVA_HOME
# echo "export JAVA_HOME=/usr/lib/jvm/default-java" >> ~/.bashrc && source ~/.bashrc

# download and add PL/Java package
pivnet download-product-files -p pivotal-gpdb -r 6.0.1 -i 505633
gppkg -i pljava-2.0.2-gp6-ubuntu18.04_x86_64.gppkg

source $HOME/gpdb6-installation/greenplum_path.sh

# restart cluster to load settings
gpstop -air

# install PL/Java: NOTE install.sql is deprecated in 6X
psql -p 60000 -d postgres -c 'CREATE EXTENSION pljava;'
