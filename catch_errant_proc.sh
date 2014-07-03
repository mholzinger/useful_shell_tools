#!/bin/bash


# One liner:
while true; do ps aux >>res.txt ; echo "----" >>res.txt; sleep 2; done

# Two liner :
egrep -v '(ps|sort|grep|cat|perl|uniq|watch)' pids.txt|perl -nae 'print $F[0], "\n"'|sort|uniq -c|sort -r

cat pids.txt  | grep -w 3876
