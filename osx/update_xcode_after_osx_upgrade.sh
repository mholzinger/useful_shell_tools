#!/bin/bash

# THIS SCRIPT
prog=${0##*/}

if [ "$EUID" -ne 0 ]; then
  echo "Please run '"$prog"' as sudo user"
  echo "eg: sudo $0"
    exit
fi

# Major Revs
osx=""
big_sur=11
osx_legacy=10

# Minor revs
osx_minor=""
high_sierra=13
mojave=14
catalina=15

determine_osx_release()
{
    osx=$( sw_vers -productVersion | awk -F \. {'print $1}' )
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
if (( osx_minor <= high_sierra )) && (( osx == osx_legacy )); then
  xcode-select --install
  sudo xcrun cc
fi

# 10.14 through current
if (( osx_minor >= catalina )) || (( osx >= big_sur )); then

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
  if (( osx_minor == catalina )) || (( osx >= big_sur )); then
    echo "Download [Catalina / Big Sur]: https://download.developer.apple.com/Developer_Tools/Command_Line_Tools_for_Xcode_12.2/Command_Line_Tools_for_Xcode_12.2.dmg"
  fi

  echo
  echo "3) Install new tools and then run:"
  echo "sudo xcode-select --switch /Library/Developer/CommandLineTools/"
  #sudo xcode-select --switch /Library/Developer/CommandLineTools/
fi
