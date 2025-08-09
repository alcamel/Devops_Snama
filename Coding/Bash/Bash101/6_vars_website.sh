#!/bin/bash 

# Variable Declaration 
PACKAGE="httpd wget unzip"
SVC="httpd"
TEMPDIR="/tmp/webfiles"

echo "Starting the setup process for the Apache web server and website deployment..."

# Check if the URL argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <URL-to-website-template>"
    exit 1
fi

# Install required packages
echo "Installing required packages: wget, unzip, and httpd (Apache)..."
if ! sudo yum install -y $PACKAGE > /dev/null; then
    echo "Failed to install required packages. Exiting."
    exit 1
fi

# Start and enable the Apache web server
echo "Starting and enabling the Apache web server..."
if ! sudo systemctl start $SVC; then
    echo "Failed to start Apache. Exiting."
    exit 1
fi
sudo systemctl enable $SVC

# Check if port 80 is free
if lsof -i :80 > /dev/null 2>&1; then
    echo "Port 80 is in use. Ensure no other service is running on this port."
    exit 1
fi

# Create a temporary directory for web files
echo "Creating a temporary directory to store web files..."
mkdir -p $TEMPDIR
cd $TEMPDIR || exit 1

# Download the website template
echo "Downloading the website template..."
if ! wget -q $1; then
    echo "Failed to download the website template. Exiting."
    exit 1
fi

# Ensure the file is a .zip archive
if [[ "$(basename $1)" != *.zip ]]; then
    echo "Error: The downloaded file is not a .zip archive. Exiting."
    exit 1
fi

# Extract the downloaded template
echo "Extracting the downloaded template..."
if ! unzip -q "$(basename $1)"; then
    echo "Failed to extract the website template. Exiting."
    exit 1
fi

# Copy the extracted files to the Apache web server's root directory
echo "Copying the template files to the Apache web server's root directory..."
if ! sudo cp -r . /var/www/html/; then
    echo "Failed to copy files to /var/www/html/. Exiting."
    exit 1
fi

# Set proper SELinux permissions (if enabled)
if selinuxenabled; then
    echo "Setting SELinux permissions for Apache..."
    sudo chcon -R -t httpd_sys_content_t /var/www/html/
fi

# Restart the Apache web server
echo "Restarting the Apache web server to apply changes..."
if ! sudo systemctl restart $SVC; then
    echo "Failed to restart Apache. Exiting."
    exit 1
fi

# Clean up by removing the temporary directory
echo "Cleaning up temporary files..."
rm -rf $TEMPDIR

echo "Setup completed successfully! Access your website at: http://$(hostname -I | awk '{print $1}')/"
