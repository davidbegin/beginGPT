#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

rec -d -c 1 "$SCRIPT_DIR"/../tmp/outfile.wav >/dev/null 2>&1