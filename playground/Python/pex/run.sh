#!/bin/bash -x

cd /home/felidadae/Programming/_General/playground/Python/pex

sudo rm -rf ~/.pex build dist_ dist .pex-build wca.egg-info .pytest_cache __tmp__
read

# pex . -D workloads -v -o __tmp__/sample.pex -e hello:hello
# pex . -D workloads -v -o __tmp__/sample.pex -e workloads_parser:hello
pex . -D sub_workloads -v -o __tmp__/sample.pex -e workloads.workloads_parser:hello
read

cd __tmp__
unzip sample.pex
ranger .deps
read

./sample.pex
