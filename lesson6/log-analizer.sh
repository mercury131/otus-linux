#!/bin/bash

lockfile=/tmp/lockfile

help () {
  echo -e "\n\n#### Help guide ####"
  echo -e "\nThis Script parse nginx access log and show this information:"
  echo -e "\nUnique IP count\nTop 10 IP by accessing server\nRequests count by CODE"
  echo -e "\n## How to use it ##"
  echo -e "\n./log-analiger.sh /path/to/logfile"
  echo -e "\n## Use delay parameter for waiting ##"
  echo -e "\n./log-analiger.sh /path/to/logfile delay"
}


analize_errors () {

  checkfile="cat $1"
  lastparceline=$(wc -l $1 | awk '{ print $1 }')
  
  if [ -e "./parse.tmp" ]; then 
  
  previusparceline=$(cat ./parse.tmp)
  echo "Last parsed line $previusparceline"
  
    if [ "$previusparceline" = "$lastparceline" ] ; then
  
  echo "Log file already parsed. (nothing to do)"
  echo "Run at $(date)"
  exit 2 
  
  else
  checkfile="tail --lines=+$previusparceline $1"
  fi
  
  
  
  else

  previusparceline=$null
 
  fi
  

  

  
  
  export lastparcestring=$($checkfile | tail -1)
  uniqip=$($checkfile | awk '{ print $1}' | sort -k1 -u)
  ipcount=$(echo "$uniqip" | wc -l)
  excepterrors=$($checkfile | awk '{ print $1, $6, $7, $9}' | grep -v 200 | grep -v 301)
  top10ip=$($checkfile | awk '{ print $1}' | sort -nr | uniq | head -n10)
  top10urls=$($checkfile | awk '{ print $1, $6, $7, $9}' | grep -v 200 | grep -v 301 | awk {'print $3'} | sort | uniq -c | sort -r | head -n 10)
  allcodes=$($checkfile | awk '{ print $9}' | sort -u | grep -v -)
  firstevent=$($checkfile | awk 'NR==1{ print $4}' | sed 's/\[//')
  lastevent=$($checkfile | awk 'END{ print $4}' | sed 's/\[//')
  

  #echo "command $checkfile"
  
  echo $lastparceline > ./parse.tmp
  echo $lastparcestring > ./parsestr.tmp

  echo -e "\n#### Result ####\n"
  echo -e "Requests count by CODE:\n"
  
  for i in $allcodes; 
  do 
  
  codecount=$($checkfile | awk '{ print $9}' | grep $i | wc -l; )
  echo "Code $i requests count - $codecount"
  
  done;

  
  echo -e "\nUnique IP - $ipcount\n"
  echo -e "Top 10 IP by accessing server:\n$top10ip\n"
  echo -e  "Top 10 URL by accessing URL:\n$top10urls\n"
  echo -e "Last parsed line in log - $lastparceline"
  echo -e "line:\n $lastparcestring"
  echo -e "\nLog analize events between $firstevent - $lastevent"
  echo -e "\nRun at $(date)"
}



if [ "$1" = "help" ] ; then

help

else

if [ -e "$lockfile" ]; then 
   
   echo "Failed to acquire lockfile: $lockfile."
   echo -e "Locked by:\n $(ps aux | grep log-analizer.sh)"
	
else
   echo 1 > $lockfile
   trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT

   if [ "$2" = "delay" ] ; then

	echo "Just waiting..."

	sleep 60

fi

   analize_errors $1
   rm -f "$lockfile"
   trap - INT TERM EXIT

fi




fi



