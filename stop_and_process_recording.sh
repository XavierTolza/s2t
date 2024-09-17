#!/bin/bash

# Stop recording
tmp_folder=/tmp/.s2t/$UID
kill $(cat $tmp_folder/recording_pid)
set -e

# Transcribe audio
source $HOME/.s2t/venv/bin/activate
whisper $tmp_folder/recording.wav --model base --output_dir="$tmp_folder" --output_format="txt" --language fr
deactivate

notify-send "Transcription Complete"

# Temporary file for transcription
TRANSCRIPTION_FILE="$tmp_folder/recording.txt"

content=$(cat $TRANSCRIPTION_FILE)

xdotool type "$content"

# Clean up
#rm -rf $tmp_folder