#!/bin/bash -e
curl https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh > Miniconda3-latest-Linux-x86_64.sh;
chmod +x Miniconda3*.sh
./Miniconda3-latest-Linux-x86_64.sh
conda create --name deeplearning python=3.5 theano
