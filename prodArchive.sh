#! /bin/bash

TARGET=${1%/}
NAME=$(basename $TARGET)

test -d $TARGET && tar --exclude=node_modules --exclude=coverage --exclude=tests --exclude-vcs -c -C ${TARGET%/*} $NAME | xz -9 > $NAME.tar.xz
# echo $(du -h "$NAME".tar.xz | cut -f1)
