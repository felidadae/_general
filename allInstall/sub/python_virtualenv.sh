#!/bin/bash -e

echo "Virtualenv will be installed for python of version" "$(python --version)" 
echo "Type any key to continue."
read 

echo "Install virtualenv systemwide (for all users with sudo)" 
sudo pip install virtualenv
sudo pip install virtualenvwrapper

SHOULD_MODIFY_BASHRC=0
if [ $SHOULD_MODIFY_BASHRC == 1 ]; then
cat <<EOF >> ~/.bashrc
export WORKON_HOME=~/Envs
export VIRTUALENVWRAPPER_PYTHON=$(which python3) #change to python in which virtualenv has been installed
mkdir -p $WORKON_HOME
source /usr/local/bin/virtualenvwrapper.sh
EOF
fi

echo "Use commands as \"mkvirtualenv -p \$PYTHON_EXEC_PATH \$ENV_NAME\""
echo "For example:"
echo "mkvirtualenv -p $(which python3) env35"
echo "pip install ipython ipdb numpy matplotlib"

# Example commands:
# mkvirtualenv -p $(which python3) env35
# pip install ipython ipdb numpy matplotlib
