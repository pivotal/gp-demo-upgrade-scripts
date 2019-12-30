#!/bin/bash

# Get the Current Working DIRectory (CWDIR) of this file
CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${CWDIR}/../gpdb5-src/.envrc

set +e
gpstop -a
set -e

## rsync -a --delete gpdb5-data/ gpdb5-data-backup

source ${CWDIR}/../gpdb6-src/.envrc

${CWDIR}/reset-gpdb6-cluster.sh

gpstop -a

psql --version
postgres --gp-version

cat <<-EOF
	######################################################################
	Upgrade Master
	######################################################################
EOF

pg_upgrade --link \
           --old-gp-dbid=1 \
           --new-gp-dbid=1 \
	       --old-bindir=/data/workspace/gpdb5-install/bin \
	       --new-bindir=/data/workspace/gpdb6-install/bin \
	       --old-datadir=/data/workspace/gpdb5-datadirs/qddir/demoDataDir-1 \
	       --new-datadir=/data/workspace/gpdb6-datadirs/qddir/demoDataDir-1 \
	       --mode=dispatcher

cat <<-EOF
	######################################################################
	Rsync
	######################################################################
EOF

rsync_excludes="--exclude=internal.auto.conf
                --exclude=postgresql.conf
                --exclude=pg_hba.conf
                --exclude=postmaster.opts
                --exclude=postgresql.auto.conf"

rsync -a --delete $rsync_excludes \
      /data/workspace/gpdb6-datadirs/qddir/demoDataDir-1/ \
      /data/workspace/gpdb6-datadirs/dbfast1/demoDataDir0

rsync -a --delete $rsync_excludes \
      /data/workspace/gpdb6-datadirs/qddir/demoDataDir-1/ \
      /data/workspace/gpdb6-datadirs/dbfast2/demoDataDir1
rsync -a --delete $rsync_excludes \
      /data/workspace/gpdb6-datadirs/qddir/demoDataDir-1/ \
      /data/workspace/gpdb6-datadirs/dbfast3/demoDataDir2

cat <<-EOF

	######################################################################
	Upgrade Segment 1
	######################################################################

EOF

pg_upgrade --link \
           --old-gp-dbid=2 \
           --new-gp-dbid=2 \
	       --old-bindir=/data/workspace/gpdb5-install/bin \
	       --new-bindir=/data/workspace/gpdb6-install/bin \
	       --old-datadir=/data/workspace/gpdb5-datadirs/dbfast1/demoDataDir0 \
	       --new-datadir=/data/workspace/gpdb6-datadirs/dbfast1/demoDataDir0 \
	       --mode=segment

cat <<-EOF

	######################################################################
	Upgrade Segment 2
	######################################################################

EOF

pg_upgrade --link \
           --old-gp-dbid=3 \
           --new-gp-dbid=3 \
	       --old-bindir=/data/workspace/gpdb5-install/bin \
	       --new-bindir=/data/workspace/gpdb6-install/bin \
	       --old-datadir=/data/workspace/gpdb5-datadirs/dbfast2/demoDataDir1 \
	       --new-datadir=/data/workspace/gpdb6-datadirs/dbfast2/demoDataDir1 \
	       --mode=segment

cat <<-EOF

	######################################################################
	Upgrade Segment 3
	######################################################################

EOF

pg_upgrade  --link \
            --old-gp-dbid=4 \
            --new-gp-dbid=4 \
	        --old-bindir=/data/workspace/gpdb5-install/bin \
	        --new-bindir=/data/workspace/gpdb6-install/bin \
	        --old-datadir=/data/workspace/gpdb5-datadirs/dbfast3/demoDataDir2 \
	        --new-datadir=/data/workspace/gpdb6-datadirs/dbfast3/demoDataDir2 \
	        --mode=segment
