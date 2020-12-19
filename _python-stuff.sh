#!/bin/bash
# -*- compile-command: "mkdir -p out && ./_python-stuff.sh"; -*-
set -e

pip install python==3.6

pip install git+https://github.com/mitar/docker-py.git#egg=docker[tls]
pip install --upgrade setuptools
pip install frozendict==1.2
pip install --no-binary :all: PyYAML==5.1.2
pip install 'requests>=2.19.1,<=2.23.0'
