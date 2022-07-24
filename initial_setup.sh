#!/bin/bash

# NVM
if ! command -v nvm &> /dev/null
then
    echo -n "Installing NVM... "
    (curl -o- https://gitcdn.link/cdn/nvm-sh/nvm/master/install.sh | $SHELL) > /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "OK!"
    else
        exit 1
    fi
fi

# Node.js
nvm use --silent
if [[ $? -eq 3 ]] # required node version is not installed
then
    echo -n "Installing Node.js v"
    cat .nvmrc
    echo -n "... "
    nvm install > /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "OK!"
    else
        exit 1
    fi
fi

# Microsoft/Git
if ! command -v scalar &> /dev/null
then
    if [[ $OSTYPE == 'darwin'* ]]
    then
        echo -n "Microsoft offers a Git fork that is "
        echo "better equipped to handle large monorepos."
        echo "Would you like to install it now? (y/n)"
        select yn in "Yes" "No"; do
            case $yn in
                Yes )
                    brew tap microsoft/git;
                    brew install --cask microsoft-git;
                    scalar register;;
                No )
                    break;;
            esac
        done
    fi
fi

# Rush
if ! command -v rush &> /dev/null
then
    echo -n "Installing Rush... "
    local RUSH_VERSION=$(node -p "require('./rush.json').rushVersion")
    npm install -g rush@"${RUSH_VERSION}" > /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "OK!"
    else
        exit 1
    fi
fi

# Dependencies
if ! [[ -d "$(dirname $(readlink -f $0))/common/temp/node_modules" ]]
then
    echo -n "Installing dependencies... "
    rush install > /dev/null
    if [[ $? -eq 0 ]]
    then
        echo "OK!"
    else
        exit 1
    fi
fi