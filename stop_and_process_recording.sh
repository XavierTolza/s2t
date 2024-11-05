#!/bin/bash
notify-send "Stopping recording"
# Stop recording
tmp_folder=/tmp/.s2t/$UID
kill $(cat $tmp_folder/recording_pid)
set -e

# Transcribe audio
source $HOME/.s2t/venv/bin/activate
whisper $tmp_folder/recording.wav --model medium --output_dir="$tmp_folder" --output_format="txt" --language fr
deactivate

# Temporary file for transcription
TRANSCRIPTION_FILE="$tmp_folder/recording.txt"

content=$(cat $TRANSCRIPTION_FILE)

xdotool type "$content"

# Clean up
#rm -rf $tmp_folder
rm $tmp_folder/recording_pid