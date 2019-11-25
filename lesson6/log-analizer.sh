#!/bin/bash


help () {
  echo "Show help guide"
}


analize_errors () {


  cat $1 | awk '{ print $1, $6, $7, $9}'
  cat $1 | awk '{ print $1, $6, $7, $9}' | sort -k1 -u
}

help

analize_errors $1
