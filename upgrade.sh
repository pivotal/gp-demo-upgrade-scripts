source ./scripts/gpdb5-environment.sh
source ./gpdb5-installation/greenplum_path.sh

gpstop -a

rsync -a --delete gpdb5-data/ gpdb5-data-backup

source ./scripts/gpdb6-environment.sh
source ./gpdb6-installation/greenplum_path.sh
./scripts/reset-gpdb6-cluster.sh
gpstop -a

psql --version


pg_upgrade --link \
	   --old-bindir=./gpdb5-installation/bin \
	   --new-bindir=./gpdb6-installation/bin \
	   --old-datadir=./gpdb5-data/qddir/demoDataDir-1 \
	   --new-datadir=./gpdb6-data/qddir/demoDataDir-1 \
	   --mode=dispatcher

rsync_excludes="--exclude=internal.auto.conf --exclude=postgresql.conf --exclude=pg_hba.conf --exclude=postmaster.opts --exclude=postgresql.auto.conf"

rsync -a --delete $rsync_excludes gpdb6-data/qddir/demoDataDir-1/ gpdb6-data/dbfast1/demoDataDir0
rsync -a --delete $rsync_excludes gpdb6-data/qddir/demoDataDir-1/ gpdb6-data/dbfast2/demoDataDir1
rsync -a --delete $rsync_excludes gpdb6-data/qddir/demoDataDir-1/ gpdb6-data/dbfast3/demoDataDir2

pg_upgrade --link \
	   --old-bindir=./gpdb5-installation/bin \
	   --new-bindir=./gpdb6-installation/bin \
	   --old-datadir=./gpdb5-data/dbfast1/demoDataDir0 \
	   --new-datadir=./gpdb6-data/dbfast1/demoDataDir0 \
	   --mode=segment

pg_upgrade --link \
	   --old-bindir=./gpdb5-installation/bin \
	   --new-bindir=./gpdb6-installation/bin \
	   --old-datadir=./gpdb5-data/dbfast2/demoDataDir1 \
	   --new-datadir=./gpdb6-data/dbfast2/demoDataDir1 \
	   --mode=segment

pg_upgrade  --link \
	   --old-bindir=./gpdb5-installation/bin \
	   --new-bindir=./gpdb6-installation/bin \
	   --old-datadir=./gpdb5-data/dbfast3/demoDataDir2 \
	   --new-datadir=./gpdb6-data/dbfast3/demoDataDir2 \
	   --mode=segment

