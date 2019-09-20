export MASTER_PORT=60000
export STANDBY_PORT=60001
export PORT_BASE=60002
export PGPORT=60000

export WITH_MIRRORS=false
export WITH_STANDBY=false

export DATADIRS="$HOME/gpdb6-data"
export MASTER_DATA_DIRECTORY="$DATADIRS/qddir/demoDataDir-1"

. $HOME/gpdb6-installation/greenplum_path.sh
