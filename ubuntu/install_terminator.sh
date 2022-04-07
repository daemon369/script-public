#!/bin/bash

VERSION="2.1.1"

temp=`terminator --version`

installed=false
mapfile -td \  fields < <(printf "%s\0" "$temp")
fields_len=${#fields[@]}

if (( fields_len == 0 )); then
    installed=false
else
    if [[ "${fields[0]}" == "terminator" ]]; then
        current_version="${fields[1]}"
        installed=true
    else
        installed=false
    fi
fi

if [[ "$installed" = true ]]; then
    echo "terminator $current_version is already installed"
else
    # mkdir
    mkdir -p $HOME/bin
    cd $HOME/bin

    # download & unzip
    wget https://github.com/gnome-terminator/terminator/releases/download/v2.1.1/terminator-2.1.1.tar.gz
    tar -zxvf terminator-2.1.1.tar.gz
    cd terminator-2.1.1

    # install dependencies
    sudo apt -y install python3-gi python3-gi-cairo python3-psutil python3-configobj gir1.2-keybinder-3.0 gir1.2-vte-2.91 gettext intltool dbus-x11 python3-setuptools python3-pip

    # build
    python3 setup.py build

    # install
    sudo python3 setup.py install --single-version-externally-managed --record=install-files.txt

    # check
    terminator --version
fi
