#!/bin/bash

find -type f -printf '%T+ %p\n' | sort | head -n 1

