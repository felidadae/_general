#!/bin/bash -e
scriptPath_felidadae_tools="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$scriptPath_felidadae_tools"
cd ~
ln -s $scriptPath_felidadae_tools/home_bin ~/bin
