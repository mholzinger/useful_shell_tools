#!/bin/bash

HOST=$1

echo | openssl s_client -connect $HOST:443 >/dev/null 2>&1;

if [[ $? != 0 ]];
	then echo "UNKNOWN: $HOST timeout or connection error";

	else echo | openssl s_client -connect $HOST:443 -ssl3 2>&1 |\
		grep -qo "sslv3 alert handshake failure" && echo "OK: $HOST Not vulnerable" ||\
		echo "FAIL:  $HOST vulnerable; sslv3 connection accepted";
fi
