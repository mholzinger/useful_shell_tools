#!/bin/bash

# Install latest header set
sudo apt-get install linux-headers-$(uname -r)

# Link header files
cd /lib/modules/$(uname -r)/build/include/linux
sudo ln -s ../generated/utsrelease.h
sudo ln -s ../generated/autoconf.h
sudo ln -s ../generated/uapi/linux/version.h 
