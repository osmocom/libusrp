#!/usr/bin/env bash

set -ex

autoreconf --install --force
./configure
$MAKE $PARALLEL_MAKE
