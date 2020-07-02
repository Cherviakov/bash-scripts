#!/bin/bash

FILE_PATH=$1
CONTENT_TYPE=$2
TARGET_URL=$3

function usage {
  echo "Usage:"
  echo "upload-file /path/to/file.json application/json http://127.1:3000/upload"
}

if [[ ! -f $FILE_PATH ]];then
  echo "$FILE_PATH is not a file"
  usage
  exit 1
fi

if [[ -z $CONTENT_TYPE ]];then
  CONTENT_TYPE="text/plain"
fi

if [[ -z $TARGET_URL ]];then
  usage
  exit 1
fi

FILE_NAME=$(basename -- $FILE_PATH)
NORMALIZED_NAME=$(echo -n $FILE_NAME | uconv -x any-nfd | LC_ALL=C.UTF-8 sed -e 's/[\o314\o200-\o315\o257]//g')
FILE_SIZE=$(du -b "$FILE_PATH" | cut -f1)
curl -H "Content-Type:$CONTENT_TYPE" -H "Content-Length:$FILE_SIZE" -H "X-FILE-NAME:$NORMALIZED_NAME" --data-binary @$FILE_PATH $TARGET_URL
