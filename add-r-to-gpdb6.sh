#!/bin/bash
set -e

# install R
sudo apt-get install -y r-base

# download and add PL/R package
pivnet download-product-files -p pivotal-gpdb -r 6.0.1 -i 505630
MASTER_DATA_DIRECTORY="$HOME/gpdb6-data/qddir/demoDataDir-1" gppkg -i plr-3.0.3-gp6-ubuntu18-amd64.gppkg -d $HOME/gpdb6-data/qddir/demoDataDir-1

# restart cluster to load settings
gpstop -air

# install PL/R:
psql -p 60000 -d postgres -c 'CREATE EXTENSION plr;'
