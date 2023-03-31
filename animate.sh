#!/bin/bash

VOICE="$1"
DIALOGUE="$2"

echo "Generating Animation Voice: $VOICE"

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
LOG_FILE=$SCRIPT_DIR/tmp/animation.log

find /home/begin/code/BeginGPT/tmp/animations -type l -delete

echo "Starting Lip Sync" >> $LOG_FILE

# Pass in Soundfile instead of voice
$SCRIPT_DIR/lip_sync.sh $VOICE $DIALOGUE

echo "Finished Lip Sync" >> $LOG_FILE

awk 'NR!=1 {print int(($1*24)-1)}' $SCRIPT_DIR/tmp/animations/output.txt > $SCRIPT_DIR/tmp/animations/output2.txt

# # add last record
awk 'END{print int($1*24)}' $SCRIPT_DIR/tmp/animations/output.txt >> $SCRIPT_DIR/tmp/animations/output2.txt

# # combine the 2 files
awk 'NR==FNR{a[NR]=$0;next}{print a [FNR],$0}' $SCRIPT_DIR/tmp/animations/output2.txt $SCRIPT_DIR/tmp/animations/output.txt > $SCRIPT_DIR/tmp/animations/output3.txt


# echo "#!/bin/bash" >

# This copies the images
awk '{print "for ((i="int($2*24)"; i<="$1"; i++)); do cp /home/begin/code/BeginGPT/mouths/"$3".png /home/begin/code/BeginGPT/tmp/animations/output_$(printf %05d $i).png ; done "}' $SCRIPT_DIR/tmp/animations/output3.txt > $SCRIPT_DIR/tmp/animations/output.sh

# This creates symlinks
# awk '{print "for ((i="int($2*24)"; i<="$1"; i++)); do ln -sf ./mouths/"$3".png /home/begin/code/BeginGPT/tmp/animations/output_$(printf %05d $i).png ; done "}' $SCRIPT_DIR/tmp/animations/output3.txt > $SCRIPT_DIR/tmp/animations/output.sh
 
# # # add #! /bin/bash to output.sh
chmod +x $SCRIPT_DIR/tmp/animations/output.sh

# Delete all previous output mouth files
rm $SCRIPT_DIR/tmp/animations/output_*.png

echo "Started Symlinking" >> $LOG_FILE
$SCRIPT_DIR/tmp/animations/output.sh
echo "Finished Symlinking" >> $LOG_FILE

## add any optional commands see after "combine video and audio" commands
## concatenate images
## I was using the commented out command but I found a new one below that
## the new command is good with .png that have transparency and making a .mov
## will keep the transparent parts in the video and then you can overlay the video

##cat *.png | ffmpeg -framerate 24 -f image2pipe -i - output.MOV

# This ain't keeping transparency
echo "STARTING FFMPEG 1" >> $LOG_FILE
ffmpeg -y -framerate 24 -i $SCRIPT_DIR/tmp/animations/output_%05d.png -vcodec png $SCRIPT_DIR/tmp/animations/output.mov
echo "Finished FFMPEG 1" >> $LOG_FILE

# We don't have the h264_amf encoder
# ffmpeg -i final.mp4 -c:v h264_amf -c:a copy -b:v 4M green.mp4
# B

# ffmpeg -x -framerate 24                                                             \
#   -i output_%05d.png                                                             \
#   -vcodec png                                                                    \
#   -f lavfi                                                                       \
#   -i color=green:s=WxH:r=30                                                      \
#   -filter_complex "[1][0]scale2ref[bg][v];[bg][v]overlay=format=auto,setsar=1:1" \
#   output.mp4
  # $SCRIPT_DIR/sky_generator/static/media/output.mp4

# -f lavfi -i color=green:s=WxH:r=30 -filter_complex "[1][0]scale2ref[bg][v];[bg][v]overlay=format=auto,setsar=1:1"

# ffmpeg -f concat -safe 0 -i video_list.txt -f lavfi -i color=green:s=WxH:r=30 -filter_complex "[1][0]scale2ref[bg][v];[bg][v]overlay=format=auto,setsar=1:1" output_video.mp4
#
# ffmpeg -f lavfi -i color=c=green:s=1280x720 -i final.mp4 -shortest -filter_complex "[1:v]chromakey=0x70de77:0.1:0.2[ckout];[0:v][ckout]overlay[out]" -map "[out]" output.mkv


### combine video and audio
##
soundfile="$SCRIPT_DIR"/tmp/"$VOICE".wav

echo "STARTING FFMPEG 2" >> $LOG_FILE
ffmpeg -y -i $SCRIPT_DIR/tmp/animations/output.mov -i $soundfile -map 1:0 -map 0:0 $SCRIPT_DIR/skybox_generator/static/media/green.mp4
echo "Finishing FFMPEG 2" >> $LOG_FILE

# beginbot "!reload_rapper"

## thanks for watching

##-----------------------------------------------------------
##-----------OPTIONAl--------BEGIN---------------------------
## for these examples I had image files called
## output_00000.png to output_20465.png
## quarterhead.png, quarterhair.png, 
## quartereyesclosed.png and quartereyesonly.png

##if you have different images with head, mouth, hair
##---------------------------------------adding mouth to head
##make sure head image in in correct folder
##if you want your new output to be in a new folder
##you need to create the folder and state the address to
##the folder

#mkdir newdir

#for VAR in $(ls output_*); do echo $VAR; composite $VAR quarterhead.png newdir/$VAR; done

##----------------------------------------add hair
## make sure hair image is in the folder
## if you want to replace the image with the new image
## then you don't need to make a new folder

#cd newdir/
#for VAR in $(ls output_*); do echo $VAR; composite quarterhair.png  $VAR $VAR; done

##------------------------adding multiple layer images
#for VAR in $(ls output_*); do echo $VAR; 
#composite $VAR quarterhead.png newdir/$VAR
#composite quartereyesclosed.png newdir/$VAR newdir/$VAR
#composite quarterhair.png newdir/$VAR newdir/$VAR; done

##------------------------------------------------------------
##-----------------adding blinking by using nested for loop
##--------breaking up the incremental number of the 
## output image file so every 200 image frames are
## thirteen closed eyes frames.

#for i in $(seq -w 000 2 204)
#do
#	for j in $(seq -w 00 1 13 )
#	do
#	echo $i$j
	
#	composite newdir/newdir/output_$i$j.png quarterhead.png newdir/newdir/output_$i$j.png
#	composite quartereyesclosed.png newdir/newdir/output_$i$j.png newdir/newdir/output_$i$j.png
#	composite quarterhair.png newdir/newdir/output_$i$j.png newdir/newdir/output_$i$j.png
#	done
#done

##----------------making a set of images transparent

#for i in {05079..11796}
#do 
#echo $i
#convert output_$i.png -matte -channel A +level 0,50% +channel transprnt/output_$i.png
#done

##--------------adding images to bottom right of background image

#for i in {11797..20465}
#do 
#echo $i
#composite -gravity SouthEast newdir/output_$i.png slideframes/out$i.png newdir/finished/final_$i.png
#done
##------------OPTIONAL--------END-----------------------------
