#!/bin/bash

# If coreaudio is hung after switching from DAC, airpods or other bluetooth and airplay device

sudo kill -9 `ps aux | grep 'coreaudiod' | grep 'sbin'|awk '{print $2}'`

