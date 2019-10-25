#!/usr/bin/env bash

main() {
    source scripts/gpdb5-environment.sh

    gpstop -a

    rsync -a --delete gpdb5-data/ gpdb5-data-backup

    ./scripts/backup-the-backup.sh

    gpstart -a
}

main
