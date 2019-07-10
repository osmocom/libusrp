#!/usr/bin/env bash

set -ex

autoreconf --install --force
./configure
$MAKE $PARALLEL_MAKE
$MAKE distcheck
$MAKE maintainer-clean
