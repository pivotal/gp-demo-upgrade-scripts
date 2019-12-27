#!/usr/bin/env bash

# Get the Current Working DIRectory (CWDIR) of this file
CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TODAYS_DATE=$(date +'%Y-%m-%d-%H-%M-%S')


for GP_RELEASE in 5 6; do
    mkdir -p ${CWDIR}/../gpdb-backups

    source ${CWDIR}/../gpdb${GP_RELEASE}-src/.envrc

    gpstop -a

    rsync -a \
          --delete \
          ${CWDIR}/../gpdb${GP_RELEASE}-datadirs/ \
          ${CWDIR}/../gpdb-backups/gpdb${GP_RELEASE}-data-backup

    tar czf ${CWDIR}/../gpdb-backups/gpdb${GP_RELEASE}-cluster-backup.$TODAYS_DATE.tar.gz -C ${CWDIR}/../gpdb-backups/gpdb${GP_RELEASE}-data-backup/ .

    gpstart -a
done
