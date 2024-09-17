#!/bin/bash
set -e

# Install dependencies
sudo apt install -y xdotool xbindkeys python3-venv

# Clone project

cd ~/
if ! [ -d "./.s2t" ]
then
    git clone https://github.com/XavierTolza/s2t.git ./.s2t
    cd .s2t
    chmod +x *.sh
fi

# Create venv
if ! [ -d "./venv" ]
then
    python3 -m venv venv
fi
./venv/bin/python -m pip install openai-whisper


# Configure key
cat << EOF > ~/.xbindkeysrc
"$HOME/.s2t/start_recording.sh"
    m:0x0 + c:75

"$HOME/.s2t/stop_and_process_recording.sh"
    Release + m:0x0 + c:75
EOF

# Download the model
touch /tmp/tmp.wav
set +e
./venv/bin/whisper /tmp/tmp.wav --model tiny
set -e
rm /tmp/tmp.wav

if ! (cat ~/.profile | grep "xset -r 75")
then
    echo "# Ignore F9 key repeat to record audio" >> ~/.profile
    echo "xset -r 75" >> ~/.profile
fi
xset -r 75

echo "Finished installation"