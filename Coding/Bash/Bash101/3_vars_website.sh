#!/bin/bash 

# Variable Declaration 
PACKAGE="httpd wget unzip"
SVC="httpd"
URL="https://templatemo.com/tm-zip-files-2020/templatemo_589_lugx_gaming.zip"
ART_NAME="Luyx_Games"
TEMPDIR="/tmp/webfiles"

echo "Starting the setup process for the Apache web server and website deployment..."

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

# Create a temporary directory for web files
echo "Creating a temporary directory to store web files..."
mkdir -p $TEMPDIR
cd $TEMPDIR || exit 1

# Download the website template
echo "Downloading the website template..."
if ! wget -q $URL; then
    echo "Failed to download the website template. Exiting."
    exit 1
fi

# Extract the downloaded template
echo "Extracting the downloaded template..."
if ! unzip -q "$(basename $URL)" -d extracted_files; then
    echo "Failed to extract the website template. Exiting."
    exit 1
fi

# Copy the extracted files to the Apache web server's root directory
echo "Copying the template files to the Apache web server's root directory..."
if ! sudo cp -r extracted_files/* /var/www/html/; then
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

echo "Setup completed successfully! You can now access your website via the server's IP address."
