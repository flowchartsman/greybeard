#!/bin/sh
set -e
pushd `git rev-parse --show-toplevel`
docker run --rm -v `pwd`:/greybeard_build -w /greybeard_build -it flowchartsman/bitmap-font-vector-build:latest make release
popd
