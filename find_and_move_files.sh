#!/bin/bash

find . -name '*name in file*'| while IFS= read -r file_array; do mv "$file_array" target_path; done
