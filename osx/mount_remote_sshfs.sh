#!/bin/bash

# Source post for commands in this script:
# https://susanqq.github.io/jekyll/pixyll/2017/09/05/remotefiles/

# Dependencies required for command to work:

# 1. Homebrew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 2. FUSE and SSHFS
# brew cask install osxfuse
# brew install sshfs

REMOTE_HOST=
TARGET_FS=
LOCAL_FS=

sudo sshfs -o allow_other,defer_permissions,IdentityFile=~/.ssh/id_rsa \
  `whoami`@"$REMOTE_HOST":/"$TARGET_FS"/ \
   /"$LOCAL_FS"
