#!/bin/bash

# Declare array of valid image extensions
declare -a extn=( jpg jpeg JPG JPEG png gif GIF pict tiff )

cnt=${#extn[*]}
for (( idx = 0; idx < cnt; idx++ ))
do
    # If no files of type *.* found, then continue
    numfiles=$( find . -name "*.${extn[idx]}" -print | xargs -0 echo -n | wc -l )
    if [ $numfiles -eq 0 ]; then
        continue
    fi

    # Formatted output between loops
    if [ $idx -lt $( echo $cnt - 1 | bc ) ] && [ $idx -ne 0 ]; then echo 
    fi

    # Scrub EXIF data
    echo  " Found [$numfiles] .${extn[idx]} files for EXIF removal"
    find . -name "*.${extn[idx]}" -print0 | xargs -0 exiftool -all=

    # Remove backups with EXIF info
	echo  " Deleting original copies  marked [*.${extn[idx]}_original]"
    find . -name "*.${extn[idx]}_original" -print0 | xargs -0 rm -f
done

# Remove common trash
rm -f .DS_Store ._* .Thumbs.db


# From original commands
# exiftool -all= *.jpg
# rm -f *original
# rm -f .DS_Store

