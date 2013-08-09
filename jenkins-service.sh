#!/bin/bash

# Jenkins service commands
echo_usage() {
    echo "Usage: [ start | stop ]"
}

startjenkins() {
    sudo launchctl load /Library/LaunchDaemons/org.jenkins-ci.plist
}

stopjenkins() {
    sudo launchctl unload /Library/LaunchDaemons/org.jenkins-ci.plist
}

# Check for null string passed (or no string)
if [ -z "$1" ]
  then
    echo_usage
fi

case "$1" in

    start )
    	echo "Starting jenkins ..."
    	startjenkins ;;

    stop )
        echo "Stopping jenkins ..."
	    stopjenkins ;;
	
	* )
		echo "Error:" '"'$1'"' "not a valid paramater"
		echo_usage ;;
esac
