#!/bin/bash

check_err(){ error_state=$(echo $?)
if [[ "$error_state" != "0" ]];then
    echo $1
    exit
fi
}

test_for_ubuntu(){
    # source lsb-release (if this fails we aren't on an ubuntu system)
    . /etc/lsb-release > /dev/null 2>&1
    check_err "Error: We are not working on a proper Ubuntu system"

    stat /etc/apt/sources.list > /dev/null 2>&1
    check_err "Error: Someone has removed your apt sources.list!"
}

check_ubuntu_version(){
    meerkat=10.10

    if [ "$DISTRIB_RELEASE" == "$meerkat" ];then
        echo match meerkat
    else
        echo "Detected Ubuntu version [$DISTRIB_DESCRIPTION $DISTRIB_CODENAME]"
        echo "This script only works with [$meerkat]"
        exit
    fi
}

edit_source(){
    # edit using sed
    sudo sed -i.backup -e 's/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
}

update_source(){
    # update repo list
    sudo apt-get update && sudo apt-get upgrade
}

# Go!
test_for_ubuntu
check_ubuntu_version
edit_source
update_source

