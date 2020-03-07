#!/bin/bash

SOURCE_ARCHIVE=$1
TARGET_FOLDER=/var/www/server
PORT=3000

if [[ ! -d "$TARGET_FOLDER" ]]; then
  echo "Target folder does not exists. Please deploy manually first time."
  exit 1
fi

if [[ ! -f "$SOURCE_ARCHIVE" ]]; then
  echo "First argument must be project archive .zip/.tar.bz2/gz/xz"
  exit 1
fi

FILENAME=$(basename -- "$SOURCE_ARCHIVE")
EXTENTION="${FILENAME##*.}"

echo "$FILENAME"
echo "$EXTENTION"

if [[ "$EXTENTION" == "zip" ]]; then
  unzip "$SOURCE_ARCHIVE"
  FILENAME="${FILENAME%.*}"
else
  tar -xf "$SOURCE_ARCHIVE"
  FILENAME="${FILENAME%.*}"
  FILENAME="${FILENAME%.*}"
fi

cd "$FILENAME"
npm i
if [[ -d ".git" ]]; then
  rm -rf .git
fi
if [[ -f ".env" ]]; then
  rm .env
fi
cp "$TARGET_FOLDER/.env" .
cp "$TARGET_FOLDER/server.log" .
rm -rf "$TARGET_FOLDER"
cp -r . "$TARGET_FOLDER"
cd ../
if [[ -d "$PWD/$FILENAME" ]];then
  rm -rf "$PWD/$FILENAME"
fi
cd "$TARGET_FOLDER"
fuser -k "$PORT"/tcp
npm run start-prod >> server.log 2>&1 &
