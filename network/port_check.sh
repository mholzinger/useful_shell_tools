#!/bin/bash

port_to_test=80

# Check for null string passed (or no string)
if [ -z "$1" ]
  then 
    echo "Usage: port_check [ hostname / url / ip address ] [port]"
    echo " -- default port is 80"
  exit
fi

# Test for port being set 
if [ ! -z "$2" ]; then
	port_to_test=$2
fi

#Now let's use netcat : nc -zv google.com 22
nc -zv "$1" "$port_to_test"

