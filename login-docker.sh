#!/bin/bash
# -*- compile-command: "./login-docker.sh"; -*-
# login to private aws ecr to push docker images
set -e

cat passwd-docker.txt | sudo docker login --username AWS --password-stdin 074785606929.dkr.ecr.us-east-1.amazonaws.com
# sudo docker push 074785606929.dkr.ecr.us-east-1.amazonaws.com/arrayfire:0.1
