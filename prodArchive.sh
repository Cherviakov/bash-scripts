#! /bin/bash

TARGET=$1
NAME=$(basename $TARGET)
DIRNAME=$PWD
FOLDERS_TO_REMOVE="node_modules .git coverage dist tests"
FILES_TO_REMOVE=""

if [[ ! -d "$TARGET" ]]
then
  echo "target is not a folder"
  exit 1
fi

cp -ra $1 /tmp
for item in $FOLDERS_TO_REMOVE;do
  if [[ -d /tmp/$NAME/$item ]];then
    rm -rf /tmp/$NAME/$item
  fi
done

for item in $FILES_TO_REMOVE;do
  if [[ -f /tmp/$NAME/$item ]];then
    rm -rf /tmp/$NAME/$item
  fi
done

cd /tmp
tar -cf $NAME.tar $NAME
xz -9 $NAME.tar
cp $NAME.tar.xz $DIRNAME
if [[ -f $NAME.tar.xz ]];then
  rm $NAME.tar.xz
fi
cd $DIRNAME
if [[ -d /tmp/$NAME ]];then
  rm -rf tmp/$NAME
fi
echo $(du -h "$NAME".tar.xz | cut -f1)
