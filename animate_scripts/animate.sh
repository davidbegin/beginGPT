#!/bin/bash

# Example
# ./animate voice_file dialogue_file namespace

VOICE_FILE="$1"
DIALOGUE_FILE="$2"
NAMESPACE="$3"

MOV_FILE="${VOICE_FILE}.mov"
FINAL_VIDEO="${VOICE_FILE}.mp4"

echo "Generating Animation for: $VOICE_FILE | $DIALOGUE_FILE | $NAMESPACE"

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
PARENT_DIR="$( cd "${SCRIPT_DIR}/.." && pwd )"

LOG_FILE=$PARENT_DIR/tmp/animation.log

VOICES_DIR="${PARENT_DIR}/tmp/voices/${NAMESPACE}"
ANIMATIONS_DIR="${PARENT_DIR}/tmp/animations/${NAMESPACE}/${VOICE_FILE}"
SOUND_FILE="${VOICES_DIR}/${VOICE_FILE}.wav"

mkdir -p $ANIMATIONS_DIR

echo "Paths: $MOV_FILE | $SOUND_FILE | $FINAL_VIDEO"

# ===========================================

echo "Starting Lip Sync" >> $LOG_FILE

echo "$SCRIPT_DIR/lip_sync.sh $VOICE_FILE $DIALOGUE_FILE"
$SCRIPT_DIR/lip_sync.sh $VOICE_FILE $DIALOGUE_FILE $VOICES_DIR $ANIMATIONS_DIR

echo "Finished Lip Sync" >> $LOG_FILE

awk 'NR!=1 {print int(($1*24)-1)}' \
  $ANIMATIONS_DIR/output.txt > $ANIMATIONS_DIR/output2.txt

# # add last record
awk 'END{print int($1*24)}' $ANIMATIONS_DIR/output.txt >> $ANIMATIONS_DIR/output2.txt

# # combine the 2 files
awk 'NR==FNR{a[NR]=$0;next}{print a [FNR],$0}' $ANIMATIONS_DIR/output2.txt $ANIMATIONS_DIR/output.txt > $ANIMATIONS_DIR/output3.txt

awk -v tmp_folder="$ANIMATIONS_DIR" '{print "for ((i="int($2*24)"; i<="$1"; i++)); do cp /home/begin/code/BeginGPT/mouths/"$3".png "tmp_folder"/output_$(printf %05d $i).png ; done "}' "$ANIMATIONS_DIR/output3.txt" > "$ANIMATIONS_DIR/output.sh"

# # add #! /bin/bash to output.sh
chmod +x $ANIMATIONS_DIR/output.sh

$ANIMATIONS_DIR/output.sh

echo "STARTING FFMPEG 1" >> $LOG_FILE
ffmpeg -y -framerate 24                     \
  -i $ANIMATIONS_DIR/output_%05d.png \
  -vcodec png                               \
  $ANIMATIONS_DIR/$MOV_FILE
echo "Finished FFMPEG 1" >> $LOG_FILE


echo "STARTING FFMPEG 2" >> $LOG_FILE
ffmpeg -y \
  -i $ANIMATIONS_DIR/$MOV_FILE \
  -i $SOUND_FILE                             \
  -map 1:0                                   \
  -map 0:0                                   \
  $PARENT_DIR/GoBeginGPT/static/media/$FINAL_VIDEO
echo "Finishing FFMPEG 2" >> $LOG_FILE

# Delete all previous output mouth files
# rm $ANIMATIONS_DIR/output_*.png

# beginbot "!reload_rapper"
