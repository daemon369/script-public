#!/bin/bash

VERSION="2.1.1"
MD5="a22e65eae47b34ccd42055725573bbb9"
DIR_NAME="terminator-$VERSION"
TAR_FILE_NAME="$DIR_NAME.tar.gz"
DOWNLOAD_URL="https://github.com/gnome-terminator/terminator/releases/download/v$VERSION/$FILE_NAME"
LOCAL_DIR_PREFIX="$HOME/bin"
LOCAL_DIR_PATH="$LOCAL_DIR_PREFIX/$DIR_NAME"
LOCAL_TAR_FILE_PATH="$LOCAL_DIR_PREFIX/$TAR_FILE_NAME"

echo "$LOCAL_DIR_PATH"
echo "$LOCAL_TAR_FILE_PATH"

if [[ -f "$LOCAL_TAR_FILE_PATH" ]]; then
    echo "file exists"
    md5sum $LOCAL_TAR_FILE_PATH
else
    echo "file not exists"
fi

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
    wget $DOWNLOAD_URL
    tar -zxvf $FILE_NAME
    cd terminator-$VERSION

    # install dependencies
    sudo apt -y install python3-gi python3-gi-cairo python3-psutil python3-configobj gir1.2-keybinder-3.0 gir1.2-vte-2.91 gettext intltool dbus-x11 python3-setuptools python3-pip

    # build
    python3 setup.py build

    # install
    sudo python3 setup.py install --single-version-externally-managed --record=install-files.txt

    # check
    terminator --version
fi
