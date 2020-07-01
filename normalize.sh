#!/bin/bash

# to convert unicode range use command: printf '\u0300' | od -An -to1

uconv -x any-nfd | LC_ALL=C.UTF-8 sed -e 's/[\o314\o200-\o315\o257]//g'
