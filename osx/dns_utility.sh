#!/bin/bash

# GOOGLE DNS
gdns1=8.8.8.8
gdns2=8.8.4.4

# OPENDNS
odns1=208.67.222.222
odns2=208.67.220.220

# evaluate passed parameters, if none display DNS and exit with help statement

print_usage()
{
    echo "Usage : [dns_utility] [option]"
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
	echo $dns_value

	#    scutil --dns | grep nameserver | cut -d : -f 2 | sort -u
}

edit_nameserver_wifi()
{
	# USING NETWORKSETUP
	echo "New entries" $1 $2
    sudo networksetup -setdnsservers Wi-Fi $1 $2	
}

# Test for passed parameters, if none, print out DNS entry and help text
if [ "$#" -lt 1 ]; then
    print_usage
fi

for arg in "$@" ; do
echo "Evaluating parameter \"$arg\""
    if [ "$arg" == "g" ]; then
		echo "Setting DNS server entry to use Google entries"
        edit_nameserver_wifi $gdns1 $gdns2
		exit
    fi

    if [ "$arg" == "o" ]; then
		echo "Setting DNS server entry to use OpenDNS entries"
		edit_nameserver_wifi $odns1 $odns2
		exit
    fi

    if [ "$arg" == "a" ]; then
        echo "Setting DNS server entry to autoassign from DHCP"
		edit_nameserver_wifi empty
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
