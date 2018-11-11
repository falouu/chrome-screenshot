#!/usr/bin/env bash

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ -f "${SCRIPTDIR}/config.sh" ]]; then
    source "${SCRIPTDIR}/config.sh"
fi

url=

# Bug in headless mode in chromium: https://github.com/GoogleChrome/puppeteer/issues/921
#  - cannot see all cookies from used user profile

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

if [[ "${CHROME_PATH}" ]]; then
    chromePath="${CHROME_PATH}"
else
    chromePath="$(which google-chrome)"
    if [[ $? != 0 ]] || [[ ! "${chromePath}" ]]; then
        die "Cannot determine google-chrome path"
    fi
fi

userDir="${HOME}/.config/chromium"

[[ -d "${userDir}" ]] || die "Default chromium user profile not found (dir not found: ${userDir})"

outputDir="$(pwd)"
pushd "${SCRIPTDIR}"
    make dep

    NODE_DIR="$(pwd)/target/node"
    export PATH="${NODE_DIR}/bin:${PATH}"
    export NODE_PATH="${NODE_DIR}/lib/node_modules"

    node screenshot.js --url "${url}" --chromePath "${chromePath}" --outputDir "${outputDir}" --userDir "${userDir}"
popd