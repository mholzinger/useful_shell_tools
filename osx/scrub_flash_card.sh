#!/bin/bash

# rm finder tags
find . -name ".DS_Store" -print0 | xargs -0 rm
find . -name "._*" -print0  | xargs -0 rm

# rm empty folders
find . -name ".Spotlight-V100" -print0  | xargs -0 rm -rf
find . -name ".Trashes" -print0  | xargs -0 rm -rf
find . -name ".fseventsd" -print0  | xargs -0 rm -rf
