#!/bin/bash

# Check for null string passed (or no string)
if [ -z "$1" ]
  then
    LINES=5;
  else
    LINES=$1
fi

cd ~

# now with color!
for i in $(find `pwd` -name *log |sed /dovecot/d); do echo -e "\e[31m" **LAST $LINES LINES LOG FILE**: $i;echo -n -e "\e[39m";stat $i 2>&1 >/dev/null && tail -$LINES $i;echo;echo; done

# no color :(
#for i in $(find `pwd` -name *log |sed /dovecot/d); do echo **PRINTING $LINES LINES LOG FILE**: $i;stat $i 2>&1 >/dev/null && tail -$LINES $i;echo; echo; done
