#!/bin/bash
# -*- compile-command: "mkdir -p out && ./af-install.sh"; -*-
set -e

# install anaconda, arrayfire default local dirs

# assume anaconda installed
conda create --name af
conda activate af
pip install git@git@github.com/arrayfire/arrayfire-python.git@dev
export LD_LIBRARY_PATH=$HOME/arrayfire/lib64:$LD_LIBRARY_PATH
export LD_PRELOAD=$HOME/anaconda3/lib/lib_mkl_core.so:$HOME/anaconda3/lib/libmkl_sequential.so
python -m arrayfire.tests
