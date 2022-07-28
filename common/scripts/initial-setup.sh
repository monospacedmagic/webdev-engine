#!/bin/bash

shell_name="${SHELL##*/}"
SCRIPTS_DIR="$(dirname $(readlink -f $0))"
MONOREPO_ROOT="${SCRIPTS_DIR}/../.."

if [ $shell_name = "zsh" ]
then
    source $MONOREPO_ROOT/.zshrc
elif [ $shell_name = "bash" ]
then
    source $MONOREPO_ROOT/.bashrc
fi

# NVM
if ! command -v nvm &> /dev/null
then
    echo -n "Installing NVM... "
    (curl -s -o- https://gitcdn.link/cdn/nvm-sh/nvm/master/install.sh | bash) > /dev/null
    if [ $? -eq 0 ]
    then
        echo "OK!"
    else
        exit 1
    fi
fi

# Node.js
nvm use --silent
if [ $? -eq 3 ] # required node version is not installed
then
    echo -n "Installing Node.js v"
    cat .nvmrc
    echo -n "... "
    nvm install > /dev/null
    if [ $? -eq 0 ]
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

# Git LFS
git lfs &> /dev/null
if [ $? -eq 1 ] # Git LFS is not installed
then
    echo -n "Installing Git LFS... "
    brew install git-lfs > /dev/null
    git lfs install > /dev/null
    if [ $? -eq 0 ]
    then
        echo "OK!"
    else
        exit 1
    fi
fi

# Rush
if ! command -v rush &> /dev/null
then
    echo -n "Installing Rush... "
    local rushversion=$(node -p "require(\"${SCRIPTS_DIR}/get-rush-version.js\").rushVersion")
    npm install -g @microsoft/rush@"${rushversion}" &> /dev/null
    if [ $? -eq 0 ]
    then
        echo "OK!"
    else
        exit 1
    fi
fi

# Dependencies
if ! [ -d "${MONOREPO_ROOT}/common/temp/node_modules" ]
then
    echo -n "Installing dependencies... "
    rush install > /dev/null
    if [ $? -eq 0 ]
    then
        echo "OK!"
    else
        exit 1
    fi
fi
