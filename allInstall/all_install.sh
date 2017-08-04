#!/bin/bash -e

# to install only some part comment unneeded code

cd sub
source __config__.sh
source boostrap.sh

./essentials.sh

# zsh vim tmux
./zsh.sh
./oh_my_zsh.sh
./sub/vim_from_source.sh
./sub/tmux_from_source.sh
./sub/vim_tmux.sh
$general/dotfiles/install.sh
