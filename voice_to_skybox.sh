#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

$SCRIPT_DIR/stop_recording.sh

# Convert Audio-to-Text
python $SCRIPT_DIR/openai_scripts/speech_to_text.py

skybox_prompt=$(cat $SCRIPT_DIR/tmp/transcription.txt)

beginbot "Generating Background For Prompt"
# beginbot "Generating Background For Prompt: $skybox_prompt"

# Send transcribed request to Skybox to generate
# This also generates HTML to be shown in OBS
$SCRIPT_DIR/skybox_generator/skybox_generator -prompt_file $SCRIPT_DIR/tmp/transcription.txt

# Print to Twitch Chat to Reload the page
# This is not working for some reason
beginbot "Reload Page!"
# beginbot "Reload Page! $skybox_prompt"