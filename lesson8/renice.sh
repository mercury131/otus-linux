#!/bin/bash

COUNTER=0

dd if=/dev/zero bs=1M count=10k | md5sum &
dd if=/dev/zero bs=1M count=10k | md5sum &

for i in $(ps aux | grep md5 | awk '{print $2}' | tail -2) ; do

COUNTER=$[COUNTER + 1]

if [ $COUNTER = 1 ]; then

echo $i

renice -n 19 $i

else

echo $i
renice -n -20 $i

fi

done

PID=$(ps aux | grep md5 | awk '{print $2}' | head -n1)

while kill -0 $PID 2> /dev/null; do
    echo " "
	echo "#### Result ###############"
	echo "USER PID CPU% STAT COMMAND"
	ps aux | grep md5 | awk '{print $1,$2,$3,"%",$8,$11}'
	echo "###########################"
    sleep 3
done

