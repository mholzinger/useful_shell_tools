#!/bin/bash

# GOOGLE DNS
gdns1=8.8.8.8
gdns2=8.8.4.4

# OPENDNS
odns1=208.67.222.222
odns2=208.67.220.220

# INTERFACE
interface=Wi-Fi

initializeANSI()
{
#  esc="\033" # if this doesn't work, enter an ESC directly
  esc=""

  blackf="${esc}[30m";   redf="${esc}[31m";    greenf="${esc}[32m"
  yellowf="${esc}[33m"   bluef="${esc}[34m";   purplef="${esc}[35m"
  cyanf="${esc}[36m";    whitef="${esc}[37m"

  reset="${esc}[0m"
}

# evaluate passed parameters, if none display DNS and exit with help statement

print_usage()
{
    echo "Usage : ["$0"] [option]"
    echo "    g = set Google DNS entries"
    echo "    o = set OpenDNS entries"
    echo "    a = set autoconfig with DHCP"
    echo "    p = print out current DNS setting"
}

print_dns_entry()
{
    dns_value=$(networksetup -getdnsservers Wi-Fi)

    if [ "$dns_value" == "There aren't any DNS Servers set on Wi-Fi." ]; then
        dns_value="Wi-Fi DNS is set to autoassigned DHCP Values"
    fi

    echo "Current DNS server entries on this Mac :"
	echo ${yellowf}$dns_value${reset}

	#    scutil --dns | grep nameserver | cut -d : -f 2 | sort -u
}

edit_nameserver_interface()
{
	# USING NETWORKSETUP
	if [ "$1" == "empty" ]; then
		echo ${yellowf}"DHCP set"${reset}
    else
	    echo "New entries :" ${yellowf}$1 $2${reset}
    fi
    sudo networksetup -setdnsservers $interface $1 $2	
}

initializeANSI

# Test for passed parameters, if none, print out DNS entry and help text
if [ "$#" -lt 1 ]; then
    print_usage
fi

for arg in "$@" ; do
#echo "Evaluating parameter \"$arg\""
    if [ "$arg" == "g" ]; then
		echo "Setting" [$interface] "interface to Google DNS"
        edit_nameserver_interface $gdns1 $gdns2
		exit
    fi

    if [ "$arg" == "o" ]; then
		echo "Setting" [$interface] "interface to OpenDNS"
		edit_nameserver_interface $odns1 $odns2
		exit
    fi

    if [ "$arg" == "a" ]; then
        echo "Setting" [$interface] "interface to DNS autoassign from DHCP"
		edit_nameserver_interface empty
		exit
    fi

    if [ "$arg" == "p" ]; then
        print_dns_entry
		exit
    fi
    
    echo "Nothing can be done with parameter \"$arg\""
	print_usage
	exit
done
