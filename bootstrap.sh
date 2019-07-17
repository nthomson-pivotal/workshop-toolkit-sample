#!/bin/bash

set -e

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl

chmod +x ./kubectl

./kubectl get pods
