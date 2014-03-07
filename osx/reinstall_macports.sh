#!/bin/bash

# All suggestions from - http://trac.macports.org/wiki/Migration

# To reinstall your ports:

#Save the list of installed ports:
port -qv installed > ~/myports.txt

# Uninstall all installed ports:
sudo port -f uninstall installed

# Clean any partially-completed builds:
sudo port clean all

# Step 4
# Browse myports.txt and install the ports that you actually want to use (as opposed to those that are only needed as dependencies) one by one, remembering to specify the appropriate variants:
# sudo port install portname +variant1 +variant2 …
# Note that if you have specified variants which are not the default, you may need to install ports in an order other than the alphabetical order recorded in myports.txt.


# Automatically reinstall ports

# A script has been written to automate Step 4 above, though it has some caveats. If it fails, you will just have to do it manually. (But see workaround for conflicting ports below.)
# To use it, you will first need to run steps 1-3 as described above. Then:
# Run these commands to download and execute the restore_ports script. (If you installed MacPorts from source and put its Tcl package somewhere other than /Library/Tcl, then you'll need to use the -t option when you run restore_ports.tcl; see ./restore_ports.tcl -h.)

# uncomment to run
#curl -O https://svn.macports.org/repository/macports/contrib/restore_ports/restore_ports.tcl
#chmod +x restore_ports.tcl
#sudo ./restore_ports.tcl myports.txt
