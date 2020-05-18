#!/bin/sh

if [ -z "$1" ]; then
    echo "Usage: batch_rename_tiff.sh [prefix] [files to be renamed]" >&2
    exit 1
fi

# Assume first argument is the prefix
PREFIX="$1"

# Remove the first argument, so arguments now only have the list of files
shift 1

# Obtain number of files based on the number of arguments provided
#  from special variable, $#
NUMBER_OF_FILES=$#

# Generate a series of numbers based on the number of files
#  using seq, with equal digit width (-w).
#  E.g. 9 = 09 if there are 10 or more files,
#       9 = 009 if there are 100 or more files.
COUNTER=($(seq -w ${NUMBER_OF_FILES}))

# Loop through all the arguments (list of files)
while [ $# -gt 0 ]    # While there are still files in the list
do
    FILE="$1"  # Select the first file from the list
    shift 1    # Remove the file from the list

    # Move/rename the file to use the prefix and the first value of the counter
    mv "${FILE}" "${PREFIX}_${COUNTER}.tiff"

    # Remove the first value of the counter (since it's used)
    COUNTER=("${COUNTER[@]:1}")    
done
