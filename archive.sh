#! /bin/bash

TARGET=$1
NAME=$(basename $TARGET)

if [[ ! -d "$TARGET" ]]
then
  echo "target is not a folder"
  exit 1
fi

tar -cf $NAME.tar $TARGET
xz -9 $NAME.tar
ls -lh $NAME.tar.xz
