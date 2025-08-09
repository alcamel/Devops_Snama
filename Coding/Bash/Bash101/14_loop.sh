#!/bin/bash

# ============================================
# Script: Create Subdirectories in `dirs`
# Description: Checks for the existence of the `dirs` folder.
#              If it doesn't exist, the script creates it.
#              Then, it creates subdirectories named dira1 to dirz9.
# Author: Gamal Moussa
# ============================================

# [1] Define the path to the `dirs` folder
TARGET_PATH="./dirs"

# ============================================
# [2] Check if the `dirs` directory exists
# ============================================
if [ -d "$TARGET_PATH" ]; then
    echo "✅ The folder '$TARGET_PATH' exists."
else
    echo "⚠️ The folder 'dirs' does not exist at $TARGET_PATH."
    echo "Creating the folder '$TARGET_PATH'..."
    mkdir -p "$TARGET_PATH"
    echo "✅ Folder '$TARGET_PATH' has been created."
fi

# ============================================
# [3] Create subdirectories dira1 to dirz9
# ============================================
echo "Starting to create subdirectories..."

for letter in {a..z}; do
    for number in {1..9}; do
        # Define the subdirectory path
        subdir="$TARGET_PATH/dir${letter}${number}"
        
        # Create the subdirectory
        mkdir -p "$subdir"
        
        # Output progress
        echo "Created: $subdir"
    done
    echo "----------------------"  # Separator for each letter batch
done

# ============================================
# [4] Completion Message
# ============================================
echo "🎉 All subdirectories have been created successfully!"
