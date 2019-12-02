#!/bin/bash

COUNTER=0

dd if=/dev/zero of=/root/test1.img bs=512 count=1000 oflag=dsync &
dd if=/dev/zero of=/root/test2.img bs=512 count=1000 oflag=dsync &

for i in $(ps aux | grep dsync | awk '{print $2}' | tail -2) ; do

COUNTER=$[COUNTER + 1]

if [ $COUNTER = 1 ]; then

echo $i

ionice -c2 -n7 -p $i

else

echo $i
ionice -c1 -n1 -p $i

fi

done

iotop -aoP

