#!/usr/bin/env bash

# Check if a note title was provided
if [ $# -eq 0 ]; then
    echo "Please provide a note title"
    exit 1
fi

# Directory where notes are stored (change this to your preferred directory)
NOTE_DIR="content/blog"

# Replace spaces with hyphens in the note title
note_title=$(echo "$1" | sed 's/ /-/g')

# Find the highest existing number prefix
# This checks both files and directories starting with a number
highest_num=$(find "$NOTE_DIR" -maxdepth 1 \( -type f -o -type d \) -name "[0-9]*_*" | 
    sed -n 's/.*\([0-9]\{3\}\)_.*/\1/p' | 
    sort -n | 
    tail -1)

# If no existing numbered files/folders, start at 001
if [ -z "$highest_num" ]; then
    highest_num=000
fi

# Increment the number
printf -v next_num "%03d" $((10#$highest_num + 1))

# Create the filename
filename="${next_num}_${note_title}.md"

# Create the file
hugo new content -k blog "$NOTE_DIR/$filename/index.md"

# Optional: Open the file in default editor
# Uncomment the line below if you want to open the file after creation
# ${EDITOR:-nano} "$NOTE_DIR/$filename"

echo "Created note: $filename"
