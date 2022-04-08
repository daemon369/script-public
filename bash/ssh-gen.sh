#!/bin/bash

email=`git config user.email`
echo "email=$email"

# generate ssh keys
ssh-keygen -q -t ed25519 -b 4096 -C "$email" -f $HOME/.ssh/id_ed25519_for_github -N ""

# copy public key to clipboard
xclip_installed=true
command -v xclip &> /dev/null || xclip_installed=false
if [[ "$xclip_installed" = false ]]; then
    sudo apt update
    sudo apt install -y xclip
fi

xclip -selection clipboard -i < $HOME/.ssh/id_ed25519_for_github.pub
