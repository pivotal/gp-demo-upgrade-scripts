#!/usr/bin/env bash

TODAYS_DATE=$(date +'%Y-%m-%d-%H-%M-%S')

tar cvzf backups/gpdb5-cluster-backup.$TODAYS_DATE.tar.gz gpdb5-data-backup/
