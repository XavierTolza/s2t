#!/bin/bash
set -e
set -x

# Start recording audio
tmp_folder=/tmp/.s2t/$UID
if ! [ -d "$tmp_folder"]
then
    rm -rf $tmp_folder
    mkdir -p $tmp_folder
    chmod 700 $tmp_folder
fi

notify-send "Starting record"

AUDIO_FILE="$tmp_folder/recording.wav"
arecord --format=cd $AUDIO_FILE &
echo $! > $tmp_folder/recording_pid

