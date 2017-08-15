#!/bin/bash -e
scriptPath_install_tool="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$scriptPath_install_tool"

[ ! -d gnome-terminal-colors-solarized ] && git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
[ ! -d gnome-terminal-colors-monokai ] && git clone git://github.com/pricco/gnome-terminal-colors-monokai.git
[ ! -d osx-terminal.app-colors-solarized ] && git clone https://github.com/tomislav/osx-terminal.app-colors-solarized.git
[ ! -d monokai.terminal ] && git clone git://github.com/stephenway/monokai.terminal.git
[ ! -d fonts ] && git clone git://github.com/powerline/fonts.git && bash fonts/install.sh


if [[ ! -d Komodo-PerlRemoteDebugging* ]]; then
	curl http://downloads.activestate.com/Komodo/releases/archive/8.x/8.0.2/remotedebugging/Komodo-PerlRemoteDebugging-8.0.2-78971-linux-x86_64.tar.gz \
		> Komodo-PerlRemoteDebugging-8.0.2-78971-linux-x86_64.tar.gz
	tar -xvzf Komodo-PerlRemoteDebugging-8.0.2-78971-linux-x86_64.tar.gz
	rm Komodo-PerlRemoteDebugging-8.0.2-78971-linux-x86_64.tar.gz

	export PERL5LIB="$general"/tools/Komodo-PerlRemoteDebugging-8.0.2-78971-linux-x86_64/
	export PERL5DB="BEGIN { require q($PERL5LIB/perl5db.pl)}"
	export PERLDB_OPTS="RemotePort=localhost:9000"
	export DBGP_IDEKEY="whatever"
fi
