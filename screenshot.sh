#!/usr/bin/env bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

url=

die() {
  >&2 echo "ERROR: $1"
  exit 1
}

while (( $# > 0 )); do
    case "$1" in
      --url)
        shift
        url="$1"
        shift
        ;;
      *)
        die "Unrecognized argument: $1"
        ;;
    esac
done

[[ "${url}" ]] || die "url not set"

pushd "${SCRIPTDIR}"
    make dep

    NODE_DIR="$(pwd)/target/node"
    export PATH="${NODE_DIR}/bin:${PATH}"
    export NODE_PATH="${NODE_DIR}/lib/node_modules"

    node screenshot.js --url "${url}"
popd