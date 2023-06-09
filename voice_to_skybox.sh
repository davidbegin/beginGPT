#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_DIR/audio_scripts/stop_recording.sh

prompt=$(cat $SCRIPT_DIR/tmp/current/transcription.txt)

beginbot "!skybox $prompt"

# # Send transcribed request to Skybox to generate
# # This also generates HTML to be shown in OBS
# $SCRIPT_DIR/GoBeginGPT/bin/GoBeginGPT -prompt_file $SCRIPT_DIR/tmp/current/transcription.txt

# # Print to Twitch Chat to Reload the page
# beginbot "Reload Page!"
