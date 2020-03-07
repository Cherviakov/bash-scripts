#!/bin/bash

PROJECT="my-project"
COPY="$PROJECT\-copy"
SERVER="server"

if [[ ! -d "$PWD/$PROJECT" ]];then
  echo "cannot find $PROJECT folder"
  exit 1
fi

if [[ -d "$PWD/$COPY" ]];then
  rm -rf "$PWD/$COPY"
fi
cp -r $PROJECT $COPY
if [[ -d "$PWD/$COPY/node_modules" ]];then
  rm -rf "$PWD/$COPY/node_modules"
fi
if [[ -d "$PWD/$COPY/.git" ]];then
  rm -rf "$PWD/$COPY/.git"
fi
tar --xz -cf "$COPY".tar.xz "$COPY"
scp "$COPY".tar.xz "$SERVER":~/
if [[ -d "$PWD/$COPY" ]];then
  rm -rf "$COPY"
fi
if [[ -f "$PWD/$COPY.tar.xz" ]];then
  rm "$COPY".tar.xz
fi
