#!/bin/bash -e

# to install only some part comment unneeded code

all_install_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$all_install_path"
cd sub
source __config__.sh

mkdir -p $_sources
./essentials.sh

# zsh vim tmux
./zsh.sh
./oh_my_zsh.sh
./vim_from_source.sh
./tmux_from_source.sh
./vim_tmux.sh
./python_virtualenv.sh
$general/dotfiles/install.sh
$general/tools/install.sh
$general/felidadaeTools/install.sh
