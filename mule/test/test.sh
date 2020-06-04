#!/usr/bin/env bash

set -ex

export WORKDIR="$1"

if [ -z "$WORKDIR" ]
then
    echo "WORKDIR must be defined."
    exit 1
fi

FULLVERSION=${VERSION:-$("$WORKDIR/scripts/compute_build_number.sh")}
export FULLVERSION

if ! $USE_CACHE
then
    mule -f mule.yaml "package-setup-deb"
fi

"$WORKDIR/mule/test/util/test_package.sh"

