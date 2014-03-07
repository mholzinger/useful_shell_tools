#!/bin/bash

# After OS update, Terminal reports: 
# Agreeing to the Xcode/iOS license requires admin privileges, please re-run as root via sudo
xcode-select —install
sudo xcrun cc 

# Brings up the cli version of the Xcode license agreement 
# Another option is to open Xcode.app and agree in the GUI
sudo xcodebuild -license
