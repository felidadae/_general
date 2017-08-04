#!/bin/bash -e
#
# @TODO documentation
#

echo "Installed python is" "$(python --version)" 
echo "Type any key to continue."
read 

echo "Install virtualenv for python2.7"
sudo pip install virtualenv
sudo pip install virtualenvwrapper

cat <<EOF >> ~/.bashrc
export WORKON_HOME=~/Envs
export VIRTUALENVWRAPPER_PYTHON=$(which python3) #change to python in which virtualenv has been installed
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
EOF

echo <<EOF
Use commands as "mkvirtualenv -p $PYTHON_PATH env35"
EOF
