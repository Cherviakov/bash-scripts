#! /bin/bash

TARGET=$1
NAME=$(basename $TARGET)
DIRNAME=$PWD

if [[ ! -d "$TARGET" ]]
then
  echo "target is not a folder"
  exit 1
fi

cp -ra $1 /tmp
if [[ -d /tmp/$NAME/node_modules ]];then
  rm -rf /tmp/$NAME/node_modules
fi

if [[ -d /tmp/$NAME/.git ]];then
  rm -rf /tmp/$NAME/.git
fi

if [[ -d /tmp/$NAME/coverage ]];then
  rm -rf /tmp/$NAME/coverage
fi

if [[ -d /tmp/$NAME/dist ]];then
  rm -rf /tmp/$NAME/dist/*.js
fi

if [[ -d /tmp/$NAME/tests ]];then
  rm -rf /tmp/$NAME/tests
fi

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
