#!/bin/bash
set -e

MASTER_DATA_DIRECTORY="$HOME/gpdb5-data/qddir/demoDataDir-1" gppkg -r plr-2.3.4

# drop PL/R:
psql -p 50000 -d postgres -c 'DROP EXTENSION plr;'
