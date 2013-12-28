#!/bin/bash

find . -name ".DS_Store" -print0 | xargs -0 rm
find . -name "._*" -print0  | xargs -0 rm


