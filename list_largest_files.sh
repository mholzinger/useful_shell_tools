#!/bin/bash

FS='/';NUMRESULTS=20;resize;clear;date;df -h $FS; echo "Largest Directories:"; du -x $FS 2>/dev/null| sort -rnk1| head -n $NUMRESULTS| awk '{printf "%d MB %s\n", $1/1024,$2}';echo "Largest Files:"; nice -n 19 find $FS -mount -type f -ls 2>/dev/null| sort -rnk7| head -n $NUMRESULTS|awk '{printf "%d MB\t%s\n", ($7/1024)/1024,$NF}'
