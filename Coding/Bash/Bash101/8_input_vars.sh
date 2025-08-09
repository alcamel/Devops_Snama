#!/bin/bash

# Clear the terminal for a clean start
clear

# Welcome message
echo "Welcome to the Skill & Login System!"
echo "------------------------------------"

# Prompt user to enter their skills
echo -n "Enter your primary skill: "
read SKILL

# Inform the user about the demand for their skill
echo -e "\nYour skill in '$SKILL' is highly valued in the IT industry!"

# Get username and password securely
echo "Please log in to continue."
read -p "Username: " USERNAME
read -sp "Password: " PASSWORD
echo # Add a blank line for formatting

# Simulate login validation (basic logic for demonstration)
if [[ -n "$USERNAME" && -n "$PASSWORD" ]]; then
    # Successful login message
    echo -e "\nLogin Successful! Welcome, $USERNAME!"
else
    # Error message for empty input
    echo -e "\nError: Username or password cannot be empty. Please try again."
    exit 1
fi

# Display a goodbye message
echo -e "\nThank you for using the system. Have a great day!"
