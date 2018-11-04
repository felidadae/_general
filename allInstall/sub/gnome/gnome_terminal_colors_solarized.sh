#!/bin/bash -e
scriptPath_install_tool="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$scriptPath_install_tool"

[ ! -d gnome-terminal-colors-solarized ] && git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
