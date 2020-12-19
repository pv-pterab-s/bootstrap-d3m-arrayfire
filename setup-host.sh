#!/bin/bash
set -ex
export GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"


sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed git git-lfs docker pbzip2 pv man-db man-pages
(
    cd $HOME
    git lfs install
)
sudo systemctl enable docker
sudo systemctl start docker
sudo docker pull registry.gitlab.com/datadrivendiscovery/images/primitives:ubuntu-bionic-python36-v2020.1.9
echo the following should be a list of all the d3m primitives
sudo docker run --rm registry.gitlab.com/datadrivendiscovery/images/primitives:ubuntu-bionic-python36-v2020.1.9 python3 -m d3m index search | head -n 4

if ! [ -f $HOME/ArrayFire-v3.6.2_Linux_x86_64.sh ]; then
    curl https://arrayfire.s3.amazonaws.com/3.6.2/ArrayFire-v3.6.2_Linux_x86_64.sh > $HOME/ArrayFire-v3.6.2_Linux_x86_64.sh
fi

if ! [ -d "$HOME/datasets" ]; then
    if ! [ -f /tmp/datasets.baseball.tar.bz2 ]; then
        curl https://gpryor-arrayfire.s3.amazonaws.com/datasets.baseball.tar.bz2 > /tmp/datasets.baseball.tar.bz2
    fi
    (
        cd $HOME
        rm -f /tmp/datasets.baseball.tar
        pbzip2 -kd /tmp/datasets.baseball.tar.bz2
        cat /tmp/datasets.baseball.tar | pv -pterab -s $(stat -c '%s' /tmp/datasets.baseball.tar) | tar x
    )
    # clean clone if pre-built data missing or new data needed
    # git lfs clone git@datasets.datadrivendiscovery.org:d3m/datasets.git -X "*"
    # (
    #     cd $HOME/datasets
    #     git lfs pull -I training_datasets/seed_datasets_archive/185_baseball
    # )
fi

function clone-if-missing {
    if ! [ -d "$HOME/$1" ]; then
        git clone --recursive https://gitlab.com/datadrivendiscovery/$1 $HOME/$1
    fi
}
clone-if-missing primitives
(
    cd $HOME/primitives
    git checkout v2020.1.24
)
clone-if-missing common-primitives
clone-if-missing d3m
if ! [ -d "$HOME/d3m-arrayfire-primitives" ]; then
    git clone git@github.com:gpryor/d3m-arrayfire-primitives $HOME/d3m-arrayfire-primitives
    (
        cd $HOME/d3m-arrayfire-primitives
        git checkout square-one
    )
fi
mkdir -p $HOME/pipeline-outputs

./docker-example.sh
