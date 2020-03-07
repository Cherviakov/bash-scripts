#!/bin/bash

BACKUP_DIR=/home/user/db-backups
DB_NAME=db
MAX_BACKUPS_NUMBER=100

if [[ ! -d "$BACKUP_DIR" ]]; then
  mkdir "$BACKUP_DIR"
fi

NEXT_BACKUP_NAME=$(date "+%Y-%m-%d_%H-%M-%S")
mysqldump --single-transaction $DB_NAME > "$BACKUP_DIR"/"$NEXT_BACKUP_NAME".sql
xz -9 "$BACKUP_DIR"/"$NEXT_BACKUP_NAME".sql

LAST_PWD="$PWD"

cd "$BACKUP_DIR"
NUMBER_OF_FILES=$(ls -1 | wc -l)
if [ "$NUMBER_OF_FILES" -gt "$MAX_BACKUPS_NUMBER" ];then
  DELETE_NUMBER="$(($NUMBER_OF_FILES - $MAX_BACKUPS_NUMBER))"
  ls -t | tail -$DELETE_NUMBER | xargs rm
fi
cd "$LAST_PWD"
