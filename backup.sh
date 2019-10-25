#!/usr/bin/env bash

main() {
    source scripts/gpdb5-environment.sh

    gpstop -a

    ./scripts/backup-the-backup.sh

    gpstart -a
}

main
