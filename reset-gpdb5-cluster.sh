#!/usr/bin/env bash

# Get the Current Working DIRectory (CWDIR) of this file
CWDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

GP_RELEASE=5

source ${CWDIR}/../gpdb${GP_RELEASE}-src/.envrc

gpstop -a

rsync -a \
      --delete \
      ${CWDIR}/../gpdb-backups/gpdb${GP_RELEASE}-data-backup/ \
      ${CWDIR}/../gpdb${GP_RELEASE}-datadirs

diff -r \
     ${CWDIR}/../gpdb-backups/gpdb${GP_RELEASE}-data-backup \
     ${CWDIR}/../gpdb${GP_RELEASE}-datadirs

gpstart -a
