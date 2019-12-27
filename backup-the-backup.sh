#!/usr/bin/env bash

# Get the Current Working DIRectory (CWDIR) of this file
CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TODAYS_DATE=$(date +'%Y-%m-%d-%H-%M-%S')

mkdir -p ${CWDIR}/../backups

tar czf ${CWDIR}/../backups/gpdb5-cluster-backup.$TODAYS_DATE.tar.gz -C ${CWDIR}/../backups/gpdb5-data-backup/ .
tar czf ${CWDIR}/../backups/gpdb6-cluster-backup.$TODAYS_DATE.tar.gz -C ${CWDIR}/../backups/gpdb6-data-backup/ .
