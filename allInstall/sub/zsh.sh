#!/bin/bash -e
sudo apt-get install -y curl
sudo apt-get install -y zsh
chsh -s $(which zsh)
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/s.bugaj/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/s.bugaj/.oh-my-zsh/custom/plugins/zsh-autosuggestions
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
