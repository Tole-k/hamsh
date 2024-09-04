#!/bin/bash

rcFile="$HOME/.bashrc"

if grep -q "source $PWD/ham.sh" $rcFile; then
    echo "ham.sh is already installed"
else
    echo "Installing ham.sh"
    echo "source $PWD/ham.sh" >> $rcFile
fi

