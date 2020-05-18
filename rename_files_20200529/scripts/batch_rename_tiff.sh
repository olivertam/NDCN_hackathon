#!/bin/sh

if [ -z "$1" ]; then
    echo "Usage: batch_rename_tiff.sh [prefix] [files to be renamed]" >&2
    exit 1
fi

PREFIX="$1"
shift 1

NUMBER_OF_FILES=$#
COUNTER=($(seq -w ${NUMBER_OF_FILES}))

while [ $# -gt 0 ]
do
    FILE="$1"
    shift 1
    mv "${FILE}" "${PREFIX}_${COUNTER}.tiff"
    COUNTER=("${COUNTER[@]:1}")    
done

