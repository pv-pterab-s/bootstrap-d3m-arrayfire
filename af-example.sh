#!/bin/bash
# -*- compile-command: "./af-example.sh"; -*-
set -e

DATA=/mnt/datasets/training_datasets/seed_datasets_archive
SET=185_baseball
PRIM=classification.logistic_regression.ArrayFire
PIPELINE=d1523250-1597-4f71-bebf-738cb6e58217.json
PIPEPATH=/mnt/d3m-arrayfire-primitives/pipelines/$PRIM/$PIPELINE

if [ "$1" = "-it" ]; then   # from inside a docker
    set -x
    export LD_LIBRARY_PATH=/opt/arrayfire/lib64:$LD_LIBRARY_PATH
    export LD_PRELOAD=/usr/local/lib/libmkl_core.so:/usr/local/lib/libmkl_sequential.so:$LD_PRELOAD
    python3 -m d3m \
            runtime \
            fit-score \
            --problem $DATA/$SET/${SET}_problem/problemDoc.json \
            --input $DATA/$SET/TRAIN/dataset_TRAIN/datasetDoc.json \
            --test-input $DATA/$SET/TEST/dataset_TEST/datasetDoc.json \
            --score-input $DATA/$SET/SCORE/dataset_TEST/datasetDoc.json \
            --pipeline $PIPEPATH \
            --output /mnt/pipeline-outputs/predictions.csv \
            --output-run /mnt/pipeline-outputs/run.yml
else
    set -x
    docker run \
           --rm \
           -v $D3M_DIR:/mnt \
           registry.gitlab.com/datadrivendiscovery/images/arrayfire-cpu:ubuntu-bionic-python36-v2020.1.9 \
           /bin/bash -c \
           "LD_LIBRARY_PATH=/opt/arrayfire/lib64:$LD_LIBRARY_PATH \
            LD_PRELOAD=/usr/local/lib/libmkl_core.so:/usr/local/lib/libmkl_sequential.so \
            python3.6 -m d3m \
                         runtime \
                         fit-score \
                         --problem $DATA/$SET/${SET}_problem/problemDoc.json \
                         --input $DATA/$SET/TRAIN/dataset_TRAIN/datasetDoc.json \
                         --test-input $DATA/$SET/TEST/dataset_TEST/datasetDoc.json \
                         --score-input $DATA/$SET/SCORE/dataset_TEST/datasetDoc.json \
                         --pipeline $PIPEPATH \
                         --output /mnt/pipeline-outputs/predictions.csv \
                         --output-run /mnt/pipeline-outputs/run.yml"
fi
