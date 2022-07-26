#!/bin/bash

if [ -f "$HOME/.bash_profile" ]
then
    source $HOME/.bash_profile
elif [ -f "$HOME/.bash_login" ]
then
    source $HOME/.bash_login
elif [ -f "$HOME/.profile" ]
then
    source $HOME/.profile
fi

if [ -f "$HOME/.bashrc" ]
then
    source $HOME/.bashrc
fi

source .bashrc_local
