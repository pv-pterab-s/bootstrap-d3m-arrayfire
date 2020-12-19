#!/bin/bash
# -*- compile-command: "mkdir -p out && ./go.sh"; -*-
# start interactive shell in d3m docker to build custom images
set -e

IMAGE=074785606929.dkr.ecr.us-east-1.amazonaws.com/arrayfire:0.1
if [ "$1" = "-base" ]; then
    IMAGE=registry.gitlab.com/datadrivendiscovery/images/primitives:ubuntu-bionic-python36-v2020.1.9
    shift
fi

sudo docker run -it $* \
     -v $HOME:/mnt/d3m \
     $IMAGE \
     /bin/bash
