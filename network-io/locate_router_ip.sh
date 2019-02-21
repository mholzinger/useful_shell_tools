#!/bin/bash

RouterIP=$(netstat -rn google.com | \
	grep default | \
	awk 'NR < 2' | \
	awk '{print $2}')
                                                                                 
echo $RouterIP


