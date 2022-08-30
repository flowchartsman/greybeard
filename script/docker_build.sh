#!/bin/sh
set -e
if [ $# -eq 0 ]
then
    targets="ttfs"
else targets="$@"
fi
pushd `git rev-parse --show-toplevel`
docker run --rm -v `pwd`:/greybeard_build -w /greybeard_build -it flowchartsman/bitmap-font-vector-build:latest make $targets
popd
