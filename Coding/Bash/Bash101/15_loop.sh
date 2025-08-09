#!/bin/bash

# ============================================
# Script: Create User Directories from user.csv
# Description: Reads usernames from a `user.csv` file,
#              creates a `home` directory in the current
#              directory, and creates subdirectories for
#              each username.
# ============================================

# [1] Define the path to the `user.csv` file
CSV_FILE="./user.csv"

# [2] Define the path to the `home` directory
HOME_DIR="./home"

# ============================================
# [3] Check if `user.csv` file exists
# ============================================
if [ ! -f "$CSV_FILE" ]; then
    echo "❌ The file '$CSV_FILE' does not exist. Please provide the file and try again."
    exit 1
fi
echo "✅ Found the file '$CSV_FILE'."

# ============================================
# [4] Create the `home` directory
# ============================================
if [ ! -d "$HOME_DIR" ]; then
    echo "Creating 'home' directory at $HOME_DIR..."
    mkdir -p "$HOME_DIR"
    echo "✅ Directory 'home' has been created."
else
    echo "✅ The directory 'home' already exists."
fi

# ============================================
# [5] Read usernames from `user.csv` and create directories
# ============================================
echo "Starting to create user directories..."

while IFS=',' read -r username; do
    # Skip empty lines or whitespace-only usernames
    if [[ -z "$username" || "$username" =~ ^[[:space:]]*$ ]]; then
        echo "⚠️ Skipping an empty username entry."
        continue
    fi

    # Create the directory for the user
    user_dir="$HOME_DIR/$username"
    mkdir -p "$user_dir"
    echo "Created: $user_dir"
done < "$CSV_FILE"

# ============================================
# [6] Completion Message
# ============================================
echo "🎉 All user directories have been created successfully!"
