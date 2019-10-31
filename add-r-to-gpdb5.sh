#!/bin/bash
set -e

# install R
sudo apt-get install -y r-base

# download and add PL/R package
pivnet download-product-files -p pivotal-gpdb -r 5.22.0 -i 504927
MASTER_DATA_DIRECTORY="$HOME/gpdb5-data/qddir/demoDataDir-1" gppkg -i plr-2.3.4-gp5-rhel7-x86_64.gppkg -d $HOME/gpdb5-data/qddir/demoDataDir-1
