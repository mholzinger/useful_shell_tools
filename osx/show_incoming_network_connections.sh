#!/bin/bash

netstat -ntu -p tcp|sed /\[Aa\]ddress/d|awk '{print $5}'|sort|uniq -c|sort -n|tail


