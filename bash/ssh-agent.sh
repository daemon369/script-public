#!/bin/sh

eval `ssh-agent -s`
chmod 600 $HOME/.ssh/id_*
ssh-add $HOME/.ssh/id_*
