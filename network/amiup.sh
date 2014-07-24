#!/bin/bash

ping_internets() {
	ping -c 2 google.com > /dev/null 2>&1

	check_err "Nope - google.com is not reachable. No internets for you :["

	# if we have a 0 exit status for ping we report this
	echo "Yay! google.com is reachable. You're online!"
}

check_err(){ error_state=$(echo $?)
if [[ "$error_state" != "0" ]];then
    echo $1
    exit
fi
}

ping_internets
