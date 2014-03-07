#!/bin/bash

check_err(){ error_state=$(echo $?)
if [[ "$error_state" != "0" ]];then
    echo $1
    exit
fi
}

echo_usage() {
    echo "Usage: [ enter the unix command to preview ]"
    echo "eg: $ preview_man sed"
}

test_man_entry() {
	man $1 > /dev/null  2>&1
	check_err "No manual entry for '$1'"
}

send_man_to_preview() {
    man -t $1 | open -f -a Preview
}

# Check for null string passed (or no string)
if [ -z "$1" ]
  then
    echo_usage
    exit
fi

# Check valid man page entry
test_man_entry $1

# Open man page in Preview
send_man_to_preview $1

# You could skip all the testing and just type this:
# man -t $1 | open -f -a Preview
