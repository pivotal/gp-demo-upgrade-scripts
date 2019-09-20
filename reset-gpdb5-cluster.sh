#!/usr/bin/env bash

source ./scripts/gpdb5-environment.sh
gpstop -a
rsync -a --delete gpdb5-data-backup/ gpdb5-data
