#!/usr/bin/env bash

set -ex

autoreconf --install --force
./configure
$MAKE # Parallel make fails occasionally, see OS#3970.
$MAKE distcheck
$MAKE maintainer-clean
