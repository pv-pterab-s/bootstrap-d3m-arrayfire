#!/bin/bash
# -*- compile-command: "./install-on-host.sh"; -*-
set -ex

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed git git-lfs pbzip2 pv man-db man-pages

# install conda for python 3.6
if ! which conda; then
    curl https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh > $HOME/conda.sh
    chmod +x $HOME/conda.sh
    (cd $HOME && ./conda.sh -b -f -p $HOME/anaconda3)
fi
set +x
eval "$($HOME/anaconda3/bin/conda shell.bash hook)"
conda init
conda create -y -n af python=3.6
conda activate af
set -x

pip install 'git+https://github.com/mitar/docker-py.git#egg=docker[tls]'
pip install --upgrade setuptools
pip install frozendict==1.2
pip install --no-binary :all: PyYAML==5.1.2
pip install 'requests>=2.19.1,<=2.23.0'


function clone-if-missing {
    if ! [ -d "$HOME/$1" ]; then
        git clone --recursive https://gitlab.com/datadrivendiscovery/$1 $HOME/$1
    fi
}
clone-if-missing primitives
(cd $HOME/primitives && git checkout v2020.12.1)
clone-if-missing images
cp $HOME/images/primitives/install-primitives.py $HOME

python $HOME/install-primitives.py --annotations $HOME/primitives/primitives
