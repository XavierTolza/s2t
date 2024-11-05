#!/bin/bash
set -e

# Install dependencies
sudo apt install -y xdotool python3-venv

# Clone project

cd ~/
if ! [ -d "./.s2t" ]
then
    git clone --branch install_script https://github.com/XavierTolza/s2t.git ./.s2t
    cd .s2t
    chmod +x *.sh
fi

# Create venv
if ! [ -d "./venv" ]
then
    python3 -m venv venv
fi
./venv/bin/python -m pip install openai-whisper

# Download the model
touch /tmp/tmp.wav
set +e
./venv/bin/whisper /tmp/tmp.wav --model tiny
set -e
rm /tmp/tmp.wav

echo "Finished installation"