#!/bin/bash
# -*- compile-command: "mkdir -p out && ./example.sh"; -*-
set -e

. $HOME/d3m_venv/bin/activate
# python -m d3m primitive search
# python -m d3m index describe d3m.primitives.data_transformation.dataset_to_dataframe.Common
# python3 -m d3m primitive describe d3m.primitives.data_transformation.dataset_to_dataframe.Common | jq .source.uris

DATA=~stef/coding/d3m_master/datasets/training_datasets/seed_datasets_archive
SET=185_baseball
PRIM=d3m.primitives.classification.logistic_regression.SKlearn
PIPELINE=554fe13d-a822-4141-8f53-83307a5b21d7.json
PIPEPATH=$HOME/primitives/primitives/JPL/$PRIM/2020.12.1/pipelines/$PIPELINE

# \TODO put this command in the quickstart at the first `runtime` example
python -m d3m \
       runtime \
       fit-score \
       --problem $DATA/$SET/185_baseball_problem/problemDoc.json \
       --input $DATA/$SET/TRAIN/dataset_TRAIN/datasetDoc.json \
       --test-input $DATA/$SET/TEST/dataset_TEST/datasetDoc.json \
       --score-input $DATA/$SET/SCORE/dataset_TEST/datasetDoc.json \
       --pipeline $PIPEPATH \
       --output $HOME/out/predictions.csv \
       --output-run $HOME/out/run.yml
