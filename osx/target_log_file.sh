#!/bin/bash

# Todo:
# Check for sudo
# Check missing string parameter
# Check for valid process

target="$1"


# Use target to stream verbose log info to desktop
sudo log stream \
  --level debug \
  --color none \
  --style syslog \
  --predicate "process contains \""$target"\"" > ~/Desktop/"$target".log

