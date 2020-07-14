#!/bin/bash

URL=$1
TIMEOUT=$2

if [[ -z $URL ]];then
  echo "Usage: waitAvailable.sh http://127.1:3000 [5]"
  exit 1
fi

if [[ ! -z $TIMEOUT ]];then
  NUMBER_REGEX="^[0-9]+$"
  if ! [[ $TIMEOUT =~ $NUMBER_REGEX ]];then
    echo "Usage: waitAvailable.sh http://127.1:3000 [5]"
    exit 1
  fi
fi

COUNTER=0

while [[ $(curl -s $URL) != "Ok" ]];
do
  COUNTER=$COUNTER+1
  sleep 1
  if [[ ! -z $TIMEOUT ]];then
    if [[ $COUNTER -gt $TIMEOUT ]];then
      echo "Operation timed out"
      exit 1
    fi
  fi
done
