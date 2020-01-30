#!/bin/bash

# Look for wifi.log files, grep for todays date
# show the last two '_processDHCPChanges' entries
find  2>&1 /private/var/log/ \
  -type f \
  -iname "wifi*log*" |\
    while read -r foo
      do
        grep -s `date +%a" "%b" "%d` "$foo" |\
        grep _processDHCPChanges
      done |\
  tail -4

