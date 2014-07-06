#!/bin/bash

NUMRESULTS=20;

# Check for null string passed (or no string)
if [ -z "$1" ]
  then
    FS='/';
  else 
    FS=$1
fi

# Clear terminal
resize;
clear;

# Print header
date;
df -h $FS;

echo "Largest Directories:";
du -x $FS 2>/dev/null| sort -rnk1 |\
  head -n $NUMRESULTS |\
  awk '{printf "%d MB %s\n", $1/1024,$2}';

echo "Largest Files:";
nice -n 19 find $FS \
  -mount \
  -type f \
  -ls 2>/dev/null |\
  sort -rnk7 |\
  head -n $NUMRESULTS |\
  awk '{printf "%d MB\t%s\n", ($7/1024)/1024,$NF}'
