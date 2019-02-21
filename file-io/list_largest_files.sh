#!/bin/bash

NUMRESULTS=20

# Check for null string passed (or no string)
if [ -z "$1" ]
  then
    FS='/';
  else 
    FS="$1"
fi

# Clear terminal
resize;
clear;

# Print header
date;
df -h "$FS";

echo && echo "Largest Directories:"
du -x "$FS" 2>/dev/null| sort -rnk1 |\
  head -n $NUMRESULTS |\
  awk '{printf "%d MB - ", $1/1024; $1="";print}'
  
echo && echo "Largest Files:"
nice -n 19 find "$FS" \
  -mount \
  -type f \
  -ls 2>/dev/null |\
  sort -rnk7 |\
  head -n $NUMRESULTS |\
  awk '{printf "%d MB - ", ($7/1024)/1024; for (i=11; i<=NF; i++) printf "%s ",$i;printf "\n"}'
#  awk '{printf "%d MB - ", ($7/1024)/1024; $1="";$2="";$3="";$4="";$5="";$6="";$7="";$8="";$9="";$10="";print}'
