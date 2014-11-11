#!/bin/bash

# Set the path for the kickstart app
KICKSTART=/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/

set_passwd()
{
    echo "Enter new Remote Desktop/VNC password :" && read NEW_PASS
    sudo $KICKSTART/kickstart \
        -configure -access -clientopts -setvncpw -vncpw $NEW_PASS
}

enable()
{
    sudo $KICKSTART/kickstart \
        -configure -access -on -clientopts -setvnclegacy -vnclegacy yes \
        -clientopts -restart -agent -privs -all
}

start()
{
    sudo $KICKSTART/kickstart \
        -activate -configure -access -on \
        -clientopts -setvnclegacy -vnclegacy yes -clientopts \
        -restart -agent -privs -all
}

stop()
{
    sudo $KICKSTART/kickstart \
        -deactivate -stop
}

disable_vnc()
{
    sudo $KICKSTART/kickstart \
        -deactivate -configure -access -off
}

# This script name
prog=$( echo $0 | sed 's|^\./||' | awk '{gsub(/\/.*\//,"",$1); print}' )

# See how we were called.
case "$1" in
  enable)
    set_passwd
    enable
    ;;
  start)
    start
    ;;
  stop)
    stop
    ;;
  pass)
    set_passwd
    ;;
  disable)
    disable_vnc
    ;;
  *)
    echo $"usage: "$prog" [enable] [disable] [start] [stop] [pass ]"
    exit 2
esac

exit $?
