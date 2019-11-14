#!/bin/bash

source="$1"
destination="$2"

rsync -av -f"+ */" -f"- *" "$source"/ "$destination"/
