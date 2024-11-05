set -x
set -e

tmp_folder="/tmp/.s2t/$UID"
pid_file="$tmp_folder/recording_pid"
S2T_FOLDER=$HOME/.s2t

if [ -f "$tmp_folder/recording_pid" ]; then
    echo "Recording is already running."
    bash $S2T_FOLDER/stop_and_process_recording.sh
else
    echo "Starting recording"
    bash $S2T_FOLDER/start_recording.sh
fi