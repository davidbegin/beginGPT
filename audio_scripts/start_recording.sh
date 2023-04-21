#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

rec -d -c 1 "$SCRIPT_DIR"/../tmp/current/outfile.wav >/dev/null 2>&1

# I want to cp this file, name it as a timestamp.
