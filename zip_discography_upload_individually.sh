#!/bin/bash

receipt=transfer_list.txt

the_path='*/'

if [ ! -z "$1" ]; then
    IFS= the_path=$1
fi

# Upload to transfer.sh
transfer()
{
    tmpfile=$( mktemp -t transferXXX ); 

    if tty -s; then 
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
        curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
    else 
        curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
    fi

    cat $tmpfile
    cat $tmpfile >> $receipt
    rm -f $tmpfile
}

# Clean house first
find . -name ".DS_Store" -print0 | xargs -0 rm
find . -name "._*" -print0  | xargs -0 rm

# Clean up transfer list
if [ -f $receipt ]; then
  :> $receipt
  echo "List of zipped and transferred files" >> $receipt
fi

# Find directories with albums, then zip them
for dir in "$the_path"
do
    echo zipping $dir
    output_name=$( basename "$dir" | sed -e 's/ /\_/g' -e 's/\//\.zip/g')

    zip -r -X "$output_name"  "$dir"
 
    # Upload to transfer.sh
    if [ -f $output_name ]; then
        transfer ./"$output_name"
    fi

    # Clean up
    rm -f ./"$output_name"
done

echo
cat $receipt

