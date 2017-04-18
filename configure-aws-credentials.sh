#!/usr/bin/env bash

kubectl create secret generic aws-creds \
    --from-file=${HOME}/.aws/credentials \
    --from-file=${HOME}/.aws/config \
    --namespace=jenkins
