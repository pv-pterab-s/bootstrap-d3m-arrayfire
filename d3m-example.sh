#!/bin/bash
# -*- compile-command: "./docker-example.sh"; -*-
set -e


DATA=/mnt/datasets/training_datasets/seed_datasets_archive
SET=185_baseball
PRIM=d3m.primitives.classification.logistic_regression.SKlearn
PIPELINE=862df0a2-2f87-450d-a6bd-24e9269a8ba6.json
PIPEPATH=/mnt/primitives/v2020.1.9/JPL/$PRIM/2019.11.13/pipelines/$PIPELINE

set -x
mkdir -p $D3M_DIR/pipeline-outputs
docker run \
       --rm \
       -v $D3M_DIR:/mnt \
       registry.gitlab.com/datadrivendiscovery/images/arrayfire-cpu:ubuntu-bionic-python36-v2020.1.9 \
       python3.6 -m d3m \
       runtime \
       fit-score \
       --problem $DATA/$SET/${SET}_problem/problemDoc.json \
       --input $DATA/$SET/TRAIN/dataset_TRAIN/datasetDoc.json \
       --test-input $DATA/$SET/TEST/dataset_TEST/datasetDoc.json \
       --score-input $DATA/$SET/SCORE/dataset_TEST/datasetDoc.json \
       --pipeline $PIPEPATH \
       --output /mnt/pipeline-outputs/predictions.csv \
       --output-run /mnt/pipeline-outputs/run.yml
