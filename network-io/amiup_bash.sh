#!/bin/bash

# This script checks internet connectivity using TCP instead of ICMP, 
# as many service providers block ICMP (ping) packets. It attempts to 
# connect to a well-known host (google.com) on port 80 (HTTP). If the 
# connection succeeds, a success message is displayed. Otherwise, an 
# error message is shown, and the script exits with a non-zero status.
# Usage: ./amiup.sh

ping_internets() {
    host="google.com"
    port=80

    # Test connectivity using /dev/tcp
    (echo >/dev/tcp/${host}/${port}) &>/dev/null && \
	  echo "Yay! ${host} is reachable. You're online!" ||\
	  check_err "Nope - ${host} is not reachable. No internets for you :["
}

check_err() {
    echo "$1"
    exit 1
}

ping_internets
