#!/bin/bash

# Clear screen, print header
resize; clear; echo; date;

# Print Top 10 processes by CPU
echo "Top 10 Processes by CPU %"; echo "";
ps -eo user,%cpu,%mem,rsz,args,pid,lstart |\
  sort -rnk2 |\
    awk 'BEGIN {printf "%s\t%s\t%s\t%s\t%s\n","USER","%CPU","%MEM","RSZ","COMMAND","PID","Started"}\
      {printf "%s\t%g'%'\t%g'%'\t%d MB\t%-10s\n",$1,$2,$3,$4/1024,$5}' |\
        head -n10;

# Print last half hour
echo; echo "== Last Half Hour =="; echo;
sar | head -n3; sar -u | tail -n4; echo;
sar -q | head -n3; sar -q | tail -n4;

# Print 2 second intervals
echo; echo "== Current 2 Second Intervals =="; echo;
sar -u 2 5; echo; sar -q 2 5
