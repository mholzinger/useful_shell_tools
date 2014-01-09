#!/bin/bash

check_err(){ error_state=$(echo $?)
if [[ "$error_state" != "0" ]];then
    echo $1
    exit
fi
}

check_ubuntu_version(){
    meerkat=10.10

    stat /etc/lsb-release
    check_err "Error: We are not working on a proper Ubuntu system"

    ubuntu_ver=$( cat /etc/lsb-release  | grep DISTRIB_RELEASE | cut -d '=' -f 2)

    if [ "$ubuntu_ver" == "$mav" ];then
        echo match maverick
    else
        echo "Detected Ubuntu version [$ubuntu_ver]"
        echo "This script only works with [$meerkat]"
        exit
    fi
}

backup_source(){
    # backup sources.list file
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
}

edit_source(){
    # edit using sed
    sudo sed -i -e 's/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
}

update_source(){
    # update repo list
    sudo apt-get update && sudo apt-get dist-upgrade
}

# Go!
check_ubuntu_version
backup_source
edit_source
update_source

