#!/bin/bash

WORD=$1
LOG=$2
DATE=`date`

if grep -q $WORD $LOG; then
    echo "WORD $WORD found in $LOG - $DATE"
else
    echo "WORD $WORD NOT found in $LOG - $DATE"
fi


