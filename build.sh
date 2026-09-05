#!/usr/bin/env bash

set -x
set -e

TAG='jefdaj/ogmios-tmp-for-pycardano'

nix build
./patch-binary-for-docker.sh
docker build -t "$TAG" .
docker image ls "${TAG}:latest"
