#!/bin/bash
set -e

MASTER_DATA_DIRECTORY="$HOME/gpdb6-data/qddir/demoDataDir-1" gppkg -r plr-3.0.3

# drop PL/R:
psql -p 60000 -d postgres -c 'DROP EXTENSION plr;'
