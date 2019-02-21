#!/bin/bash

# One liner:
while true; do ps aux >>res.txt ; echo "----" >>res.txt; sleep 2; done

# Two liner :
# 1: Capture log
while true; do ps -A -o pid -o comm >> pids.txt; sleep 0.25; done

# 2: Sort log by process execution count
egrep -v '(ps|sort|grep|cat|perl|uniq|watch)' pids.txt|perl -nae 'print $F[0], "\n"'|sort|uniq -c|sort -r

# Example - Look for process by id
# cat pids.txt  | grep -w 3876
