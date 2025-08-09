#!/bin/bash

# Log file
log_file="while.log"

# Check if the log file exists
if [ -f "$log_file" ]; then
    # Clear the log file if it exists
    > "$log_file"
else
    # Create the log file if it doesn't exist
    touch "$log_file"
fi

# Counting
counter=0
echo "#####################"
while [ $counter -lt 10 ]; do
    # Handle Message
    message="Value of Counter is $counter"
    
    # Print message to the screen
    echo "Looping....."
    echo "$message"
    
    # Append message to the log file
    echo "$message" >> "$log_file"
    
    # Increment counter
    counter=$((counter + 1))
    
    # Wait 1 second
    sleep 1
done
echo "#####################"
