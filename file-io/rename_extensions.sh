#!/bin/bash

# THIS SCRIPT
prog=${0##*/}

if [ "$#" -lt 2 ]; then
    echo $prog": Rename all file extensions in path to new extension"
    echo "Usage: "$prog" bin wav"
    exit
fi

EXTN1="$1"
EXTN2="$2"

files=(*."$EXTN1")

for file in "${files[@]}"
do
  if [[ "$file" == "*.$EXTN1" ]]; then 
    continue
  fi

  mv "$file" "${file%.*}"."$EXTN2"
done

echo "Renamed ["${#files[@]}"] files with extension [."$EXTN1"] to [."$EXTN2"]"
