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
    docker build -t chrome-screenshot .
    #docker run -it -v "$(pwd):/workdir" chrome-screenshot bash
    docker run -v "$(pwd):/workdir" chrome-screenshot node screenshot.js --url "${url}"
    #docker run -v "$(pwd):/workdir" chrome-screenshot env


popd