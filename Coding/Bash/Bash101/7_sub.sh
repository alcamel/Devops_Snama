#!/bin/bash

# Welcome message
echo "Welcome $USER on $HOSTNAME"
echo "##########################"

# Collect system information
FREERAM=$(free -m | awk '/Mem/ {print $4}') # Free RAM in MB
LOAD=$(uptime | awk -F 'load average:' '{print $2}' | xargs) # System load averages
ROOTFREE=$(df -h / | awk '/\// {print $4}') # Free space on root partition

# Display the system information
echo "System Information:"
echo "-------------------"
echo "Free RAM: ${FREERAM} MB"
echo "Load Average: $LOAD"
echo "Free Space on Root Partition: $ROOTFREE"

# Additional Enhancements:
# - Display uptime
UPTIME=$(uptime -p)
echo "System Uptime: $UPTIME"

# - Check and display the number of logged-in users
LOGGED_USERS=$(who | wc -l)
echo "Number of Logged-in Users: $LOGGED_USERS"

# - Display the current date and time
CURRENT_DATE=$(date +"%Y-%m-%d %H:%M:%S")
echo "Current Date and Time: $CURRENT_DATE"

echo "##########################"
echo "Script Execution Completed Successfully!"

