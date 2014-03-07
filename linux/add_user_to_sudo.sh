#!/bin/bash

currentuser=$( whoami )

su -c "echo '$currentuser  ALL=(ALL:ALL) ALL' >> /etc/sudoers"
