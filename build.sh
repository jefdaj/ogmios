#!/usr/bin/env bash

set -x
set -e

nix build
./patch-binary-for-docker.sh
docker build .
