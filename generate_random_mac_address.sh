#!/bin/bash

h="0123456789ABCDEF";for i in {1..12} ; do echo -n ${h:$(( $RANDOM % 16 
)):1} ; done | sed -e 's/\(..\)/:\1/g'|cut -c2-

