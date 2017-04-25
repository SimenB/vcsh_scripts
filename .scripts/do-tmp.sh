#!/bin/sh

# Usage:
#  - do-tmp.sh npm i @google-cloud/storage\; npm ls retry-request

set -e

if [ $# -eq 0 ]; then
  echo 'provide command to run'
  exit 1
fi

curr_pwd=$(pwd)
mytmpdir=$(mktemp -d 2>/dev/null || mktemp -d -t mytmpdir)

cd "$mytmpdir"

eval "$@"

cd "$curr_pwd"

rm -rf "$mytmpdir"
