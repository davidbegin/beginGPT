#!/bin/bash

# Example
# ./animate voice_file dialogue_file namespace

VOICE_FILE="$1"
DIALOGUE_FILE="$2"
NAMESPACE="$3"

echo "Generating Animation for: $VOICE_FILE | $DIALOGUE_FILE | $NAMESPACE"

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
LOG_FILE=$SCRIPT_DIR/../tmp/animation.log
TMP_ANIMATIONS_FOLDER=$SCRIPT_DIR/../tmp/animations/$NAMESPACE

MOV_FILE=$(echo $VOICE_FILE | sed "s/.wav/.mov/")
SOUND_FILE="$SCRIPT_DIR"/../tmp/voices/"$VOICE_FILE"
FINAL_VIDEO="$NAMESPACE.mp4"

# Paths: verse1.mov | /home/begin/code/BeginGPT/tmp/verse1.wav | verse1.mp4
echo "Paths: $MOV_FILE | $SOUND_FILE | $FINAL_VIDEO"

echo $TMP_ANIMATIONS_FOLDER

mkdir -p $TMP_ANIMATIONS_FOLDER

echo "Starting Lip Sync" >> $LOG_FILE

$SCRIPT_DIR/lip_sync.sh $VOICE_FILE $DIALOGUE_FILE

echo "Finished Lip Sync" >> $LOG_FILE

awk 'NR!=1 {print int(($1*24)-1)}' \
  $TMP_ANIMATIONS_FOLDER/output.txt > $TMP_ANIMATIONS_FOLDER/output2.txt

# # add last record
awk 'END{print int($1*24)}' $TMP_ANIMATIONS_FOLDER/output.txt >> $TMP_ANIMATIONS_FOLDER/output2.txt

# # combine the 2 files
awk 'NR==FNR{a[NR]=$0;next}{print a [FNR],$0}' $TMP_ANIMATIONS_FOLDER/output2.txt $TMP_ANIMATIONS_FOLDER/output.txt > $TMP_ANIMATIONS_FOLDER/output3.txt

awk -v tmp_folder="$TMP_ANIMATIONS_FOLDER" '{print "for ((i="int($2*24)"; i<="$1"; i++)); do cp /home/begin/code/BeginGPT/mouths/"$3".png "tmp_folder"/output_$(printf %05d $i).png ; done "}' "$TMP_ANIMATIONS_FOLDER/output3.txt" > "$TMP_ANIMATIONS_FOLDER/output.sh"

# # add #! /bin/bash to output.sh
chmod +x $TMP_ANIMATIONS_FOLDER/output.sh

$TMP_ANIMATIONS_FOLDER/output.sh



echo "STARTING FFMPEG 1" >> $LOG_FILE
ffmpeg -y -framerate 24                     \
  -i $TMP_ANIMATIONS_FOLDER/output_%05d.png \
  -vcodec png                               \
  $TMP_ANIMATIONS_FOLDER/$MOV_FILE
echo "Finished FFMPEG 1" >> $LOG_FILE



echo "STARTING FFMPEG 2" >> $LOG_FILE
ffmpeg -y \
  -i $TMP_ANIMATIONS_FOLDER/$MOV_FILE \
  -i $SOUND_FILE                             \
  -map 1:0                                   \
  -map 0:0                                   \
  $SCRIPT_DIR/../GoBeginGPT/static/media/$FINAL_VIDEO
echo "Finishing FFMPEG 2" >> $LOG_FILE

# Delete all previous output mouth files
# rm $TMP_ANIMATIONS_FOLDER/output_*.png

# beginbot "!reload_rapper"
