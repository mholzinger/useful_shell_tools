#!/bin/bash

# declare array of valid image extensions
declare -a extn=( jpg jpeg JPG JPEG png )

cnt=${#extn[*]}
for (( idx = 0; idx < cnt; idx++ ))
do
    # Scrub EXIF data
    echo  "looking for -- *.${extn[idx]}"
    find . -name "*.${extn[idx]}" -print0 | xargs -0 exiftool -all=

    # Remove backups with EXIF info
	echo  "deleting copy -- *.${extn[idx]}_original"
    find . -name "*.${extn[idx]}_original" -print0 | xargs -0 rm -f

    # Finally
    rm -f .DS_Store
done

# From original commands
# exiftool -all= *.png *.jpg *.JPG *.jpeg
# rm -f *original
# rm -f .DS_Store

