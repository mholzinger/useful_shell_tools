#!/bin/bash

array=(*/); for dir in "${array[@]}"; do du -sh "$dir"; done


