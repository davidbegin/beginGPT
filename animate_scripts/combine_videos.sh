#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
PARENT_DIR="$( cd "${SCRIPT_DIR}/.." && pwd )"
MEDIA_DIR="$PARENT_DIR/GoBeginGPT/static/media"

ffmpeg -f concat          \
  -safe 0                 \
  -i $SCRIPT_DIR/videos.txt \
  -c copy                 \
  $MEDIA_DIR/green.mp4 -y

# how can we make this dynamic
# We need to take in 
# ffmpeg -i $MEDIA_DIR/verse1.mp4                                                       \
#        -i $MEDIA_DIR/verse2.mp4                                                       \
#        -i $MEDIA_DIR/verse3.mp4                                                       \
#        -filter_complex "[0:v][0:a][1:v][1:a][2:v][2:a]concat=n=3:v=1:a=1[outv][outa]" \
#        -map "[outv]"                                                                  \
#        -map "[outa]"                                                                  \
#        $MEDIA_DIR/green.mp4 -y

# ffmpeg -i "concat:video1.mp4|video2.mp4|video3.mp4" -c copy output.mp4

# So how do we get thisworking
# ffmpeg -i "$MEDIA_DIR/verse1.mp4|$MEDIA_DIR/verse2.mp4|$MEDIA_DIR/verse3.mp4" -c copy $MEDIA_DIR/green.mp4 -y

ffmpeg -f concat -safe 0 -i $SCRIPT_DIR/list.txt -c copy merged.mp4

# ffmpeg -f concat \
#        -i $MEDIA_DIR/verse1.mp4                                                       \
#        -i $MEDIA_DIR/verse2.mp4                                                       \
#        -i $MEDIA_DIR/verse3.mp4                                                       \
#        -c copy \
#         $MEDIA_DIR/green.mp4 -y
# ffmpeg -i $MEDIA_DIR/verse1.mp4                                                       \
#        -i $MEDIA_DIR/verse2.mp4                                                       \
#        -i $MEDIA_DIR/verse3.mp4                                                       \
#        -filter_complex "[0:v][0:a][1:v][1:a][2:v][2:a]concat=n=3:v=1:a=1[outv][outa]" \
#        -map "[outv]"                                                                  \
#        -map "[outa]"                                                                  \
#        $MEDIA_DIR/green.mp4 -y
