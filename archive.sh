#! /bin/bash

TARGET=$1
NAME=$(basename $TARGET)

test -d $TARGET && tar cf - $TARGET | xz -9 > $NAME.tar.xz
