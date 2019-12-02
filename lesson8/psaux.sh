#!/bin/bash

HGZ=$(cat /proc/cpuinfo | grep "cpu MHz" | awk '{print $4}' | awk '{printf("%d\n",$1 + 0.5)}')

echo "PID TTY STAT TIME COMMAND"

for i in $(ls /proc | grep ^[1-9]); do 

if [ -d /proc/$i ];then 


USERP=$(cat /proc/$i/loginuid 2>&1 | id -nu )

PTTY=$(ls -la /proc/$i/fd/ | awk '{print $11}' | uniq | tail -n1)

if [ -z $PTTY ];then 

PTTY="?"

fi


STATE=$(cat /proc/$i/status 2>&1 | grep State | awk '{print $2 }')

CMD=$(cat /proc/$i/cmdline 2>&1)

if [ -e /proc/$i/cmdline ]; then

CMD=$(cat /proc/$i/cmdline 2>&1)

else

CMD=$(cat /proc/$i/status | grep Name | awk '{print $2}')

fi

if [ -z $CMD ]; then

CMD=$(cat /proc/$i/status | grep Name | awk '{print $2}')

fi

UTIME=$(cat /proc/$i/stat | awk '{print $14}')
STIME=$(cat /proc/$i/stat | awk '{print $15}')

TOTALTIME=$((($UTIME + $STIME / $HGZ)))

TOTALTIMEMS=$(($TOTALTIME / $HGZ))

echo "$i $PTTY $USERP $STATE $TOTALTIMEMS $CMD"

#
fi

done