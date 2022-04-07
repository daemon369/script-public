#!/bin/bash

VERSION="2.3a"

temp=`tmux -V`

installed=false
mapfile -td \  fields < <(printf "%s\0" "$temp")
fields_len=${#fields[@]}

if (( fields_len == 0 )); then
    installed=false
else
    if [[ "${fields[0]}" == "tmux" ]]; then
        current_version="${fields[1]}"
        installed=true
    else
        installed=false
    fi
fi

if [[ "$installed" = true ]]; then
    echo "tmux $current_version is already installed"
else
    # mkdir
    mkdir ~/bin
    cd ~/bin

    # download & unzip
    wget https://github.com/tmux/tmux/releases/download/3.2a/tmux-3.2a.tar.gz
    tar -zxvf tmux-3.2a.tar.gz
    cd tmux-3.2a

    # install dependencies
    sudo apt -y install libevent-dev ncurses-dev build-essential bison pkg-config

    # build
    ./configure && make

    # install
    sudo make install

    # check
    tmux -V
fi
