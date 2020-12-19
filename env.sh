#!/bin/bash
# -*- compile-command: "mkdir -p out && ./af-env.sh"; -*-
# switch to arrayfire environment; see setup.sh to setup machine

export LD_LIBRARY_PATH=$HOME/arrayfire/lib64:$LD_LIBRARY_PATH
export LD_PRELOAD=$HOME/anaconda3/lib/libmkl_core.so:$HOME/anaconda3/lib/libmkl_sequential.so
