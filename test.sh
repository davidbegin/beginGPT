#!/usr/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

beginbot "hello"

# so how do we print this out
cat $SCRIPT_DIR/tmp/chatgpt_response.txt
# So do we divide it up
beginbot $(cat $SCRIPT_DIR/tmp/chatgpt_response.txt)
