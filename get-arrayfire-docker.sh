#!/bin/bash
# -*- compile-command: "./get-docker.sh"; -*-
# login to private aws ecr and pull arrayfire
set -e

cat passwd-docker.txt | sudo docker login --username AWS --password-stdin 074785606929.dkr.ecr.us-east-1.amazonaws.com
sudo docker pull 074785606929.dkr.ecr.us-east-1.amazonaws.com/arrayfire:0.1
