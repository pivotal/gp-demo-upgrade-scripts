export MASTER_PORT=50000
export STANDBY_PORT=50001
export PORT_BASE=50002
export NUM_PRIMARY_MIRROR_PAIRS=3
export DATADIRS="$HOME/gpdb5-data"
export PGPORT=50000
export GPHOME="$HOME/gpdb5-installation"
export PATH="$PATH:$HOME/gpdb5-installation/bin"
export MASTER_DATA_DIRECTORY="$HOME/gpdb5-data/qddir/demoDataDir-1"

source gpdb5-installation/greenplum_path.sh
