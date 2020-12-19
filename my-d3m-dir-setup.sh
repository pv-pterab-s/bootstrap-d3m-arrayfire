#!/bin/bash
# -*- compile-command: "D3M_DIR=~/my-d3m ./my-d3m-dir-setup.sh"; -*-
# usage: D3M_DIR=~/my-d3m ./my-d3m-dir-setup.sh
#        populates base dirs compatible w/ last working arrayfire primitives:
#          /primitives, /d3m
#        sets up minimal "baseball" datasets repo:
#          /datasets
#        develop with docker:
#          docker -it registry.gitlab.com/datadrivendiscovery/images/arrayfire-cpu:ubuntu-bionic-python36-v2020.1.9
set -e

if [ -z "$D3M_DIR" ]; then echo D3M not exported; exit 1; fi
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

mkdir -p $D3M_DIR

if ! [ -d "$D3M_DIR/datasets" ]; then
    if ! [ -f /tmp/datasets.baseball.tar.bz2 ]; then
        curl https://gpryor-arrayfire.s3.amazonaws.com/datasets.baseball.tar.bz2 > /tmp/datasets.baseball.tar.bz2
    fi
    (
        cd $D3M_DIR
        rm -f /tmp/datasets.baseball.tar
        pbzip2 -kd /tmp/datasets.baseball.tar.bz2
        cat /tmp/datasets.baseball.tar | pv -pterab -s $(stat -c '%s' /tmp/datasets.baseball.tar) | tar x
    )
fi

function clone-if-missing {
    local REPO_NAME=$(basename $1)
    if ! [ -d "$D3M_DIR/$REPO_NAME" ]; then
        git clone --recursive $1 $D3M_DIR/$REPO_NAME
    fi
}

clone-if-missing https://gitlab.com/datadrivendiscovery/primitives
clone-if-missing https://gitlab.com/datadrivendiscovery/d3m
clone-if-missing https://github.com/pv-pterab-s/d3m-arrayfire-primitives

(cd $D3M_DIR/primitives && git checkout v2020.1.24)
(cd $D3M_DIR/d3m-arrayfire-primitives && git checkout square-one)
mkdir -p $D3M_DIR/pipeline-outputs

cat <<EOF
1. prove d3m runs with:
  ./d3m-example.sh

2. prove arrayfire cpu runs with:
  ./af-example.sh

3. on success, both should end with a line matching /^F1_MACRO/
EOF
