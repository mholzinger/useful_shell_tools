#!/bin/bash

# THIS SCRIPT
prog=${0##*/}

if [ "$EUID" -ne 0 ]; then
  echo "Please run '"$prog"' as sudo user"
  echo "eg: sudo $0"
    exit
fi

osx=""
osx_minor=""
high_sierra=13
mojave=14
catalina=15

determine_osx_release()
{
    osx=$( sw_vers -productVersion )
    osx_minor=$( sw_vers -productVersion | awk -F \. {'print $2}' )
}

gui_select(){
  # Brings up the cli version of the Xcode license agreement
  # Another option is to open Xcode.app and agree in the GUI
  sudo xcodebuild -license
}

determine_osx_release

# After OS update, Terminal reports:
#   Agreeing to the Xcode/iOS license requires admin privileges, please re-run
#   as root via sudo
if (( osx_minor <= high_sierra )); then
  xcode-select --install
  sudo xcrun cc
fi

# 10.14 through current
if (( osx_minor >= catalina )); then

  sudo xcode-select --switch /Applications/Xcode.app

  # Currently this brings no CLI tools form the store and fails.
  xcode-select --install

  echo
  echo "1) Sign into apple for newest command line tools:"
  echo "Sign in: https://developer.apple.com/download/more/?=for%20Xcode"
  echo
  echo "2) Download link(s):"
  if (( osx_minor == mojave )); then
    echo "Download [Mojave]: https://download.developer.apple.com/Developer_Tools/Command_Line_Tools_macOS_10.14_for_Xcode_10.1/Command_Line_Tools_macOS_10.14_for_Xcode_10.1.dmg"
  fi
  if (( osx_minor == catalina ));then
    echo "Download [Catalina]: https://download.developer.apple.com/Developer_Tools/Command_Line_Tools_for_Xcode_11.2_beta/Command_Line_Tools_for_Xcode_11.2_beta.dmg"
  fi
  echo
  echo "3) Install new tools and then run:"
  echo "sudo xcode-select --switch /Library/Developer/CommandLineTools/"
  #sudo xcode-select --switch /Library/Developer/CommandLineTools/
fi
