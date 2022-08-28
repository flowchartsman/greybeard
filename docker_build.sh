#!/bin/sh
docker run --rm -v `pwd`:/greybeard_build -w /greybeard_build -it flowchartsman/bitmap-font-vector-build:latest make release
