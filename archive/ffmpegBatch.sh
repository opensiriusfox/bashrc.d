#!/bin/bash

function batchConvertFLAC() {
	IFS=$'\n'
	INPUT_EXT="${1:-.flac}"
	INPUT_DIR="${2:-./}"
	OUT_DIR="${3:-./output}"
	if [[ "${INPUT_DIR: -1}" != "/" ]]; then
		INPUT_DIR="$INPUT_DIR/"
	fi
	if [[ "${OUT_DIR: -1}" != "/" ]]; then
		OUT_DIR="$OUT_DIR/"
	fi

	if [[ ! -e "$OUT_DIR" ]]; then
		mkdir -pv "$OUT_DIR"
	fi
	
	jMax=${JOBS:-4};
	
	pids=()
	FROM="$(readlink -f "$INPUT_DIR")/"
	TO="$(readlink -f "$OUT_DIR")/"
	(
		cd "$FROM"
		for FLAC in *$INPUT_EXT; do
			echo "Converting '$INPUT_DIR$FLAC'..."
			while [[ "$(jobs -r | wc -l)" -ge $jMax ]]; do
				sleep 0.1
			done
			IN_FILE="$FLAC"
			OUT_FILE="$TO${FLAC/.flac/.m4a}"
			#echo "$OUT_FILE"
			ffmpeg -i "$IN_FILE" -n -ab 192k -vn "$OUT_FILE" &>/dev/null &
			pids[${i}]=$!
		done
		for PID in ${pids[@]}; do
			wait $PID
		done
		echo "done."
	)
}
#complete -F _minimal batchConvert
