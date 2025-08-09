#!/bin/bash

# File paths
CSV_FILE="users.csv"
ENCRYPTED_FILE="users.csv.enc"
SECRET_KEY="my_secret_key" # Replace with a secure key

# Create an empty CSV file if it doesn't exist
initialize_file() {
    if [[ ! -f "$ENCRYPTED_FILE" && ! -f "$CSV_FILE" ]]; then
        echo "username,password_hash" > "$CSV_FILE"
        encrypt_file
    fi
}

# Function to encrypt the CSV file
encrypt_file() {
    if [[ -f "$CSV_FILE" ]]; then
        openssl enc -aes-256-cbc -salt -pbkdf2 -in "$CSV_FILE" -out "$ENCRYPTED_FILE" -k "$SECRET_KEY"
        rm -f "$CSV_FILE"
    fi
}

# Function to decrypt the CSV file
decrypt_file() {
    if [[ -f "$ENCRYPTED_FILE" ]]; then
        openssl enc -aes-256-cbc -d -pbkdf2 -in "$ENCRYPTED_FILE" -out "$CSV_FILE" -k "$SECRET_KEY" 2>/dev/null
    fi
}

# Function to register a new user
register_user() {
    decrypt_file

    echo -e "\n-- Register --"
    read -p "Enter username: " USERNAME
    if grep -q "^$USERNAME," "$CSV_FILE"; then
        echo "Error: Username already exists. Try logging in."
        encrypt_file
        return
    fi

    read -sp "Enter password: " PASSWORD
    echo
    read -sp "Confirm password: " CONFIRM_PASSWORD
    echo

    if [[ "$PASSWORD" != "$CONFIRM_PASSWORD" ]]; then
        echo "Error: Passwords do not match."
        encrypt_file
        return
    fi

    # Append user data to CSV
    PASSWORD_HASH=$(echo -n "$PASSWORD" | sha256sum | awk '{print $1}')
    echo "$USERNAME,$PASSWORD_HASH" >> "$CSV_FILE"

    echo "Registration successful!"
    encrypt_file
}

# Function to log in a user
login_user() {
    decrypt_file

    echo -e "\n-- Login --"
    read -p "Enter username: " USERNAME
    read -sp "Enter password: " PASSWORD
    echo

    PASSWORD_HASH=$(echo -n "$PASSWORD" | sha256sum | awk '{print $1}')
    if grep -q "^$USERNAME,$PASSWORD_HASH$" "$CSV_FILE"; then
        echo "Login successful! Welcome, $USERNAME!"
    else
        echo "Error: Invalid username or password."
    fi

    encrypt_file
}

# Main menu
initialize_file
while true; do
    echo -e "\n--- User System ---"
    echo "1. Register"
    echo "2. Login"
    echo "3. Exit"
    read -p "Choose an option: " OPTION

    case $OPTION in
        1) register_user ;;
        2) login_user ;;
        3) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option. Please enter 1, 2, or 3." ;;
    esac
done
