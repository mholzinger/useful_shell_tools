#!/bin/bash

# Edit this script to meet your needs.
# Always test first with '--dry-run' (remove --dry-run to run the commands) 

REMOTE_IP=192.168.0.1
SOURCE=/tmp/my_folder
DESTINATION=/tmp/
SSH_USER=admin


# Copy a File from a Local Server to a Remote Server with SSH
rsync -avzh $SOURCE $SSH_USER@$REMOTE_IP:$DESTINATION --dry-run

# Copy a File from a Remote Server to a Local Server with SSH
rsync -avzh $SSH_USER@$REMOTE_IP:$DESTINATION $SOURCE --dry-run

# Copy/Sync a File on a Local Computer (creates directory is one isn't there)
rsync -azvh $SOURCE $DESTINATION --dry-run

# RaspberryPi crashing when you use rsync? Try these command parameters to throttle the output
/usr/bin/rsync --delay-updates --bwlimit=1000 -avz $SOURCE SSH_USER@$REMOTE_IP:$DESTINATION
