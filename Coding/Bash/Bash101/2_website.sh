#!/bin/bash 

echo "Starting the setup process for the Apache web server and website deployment..."

# Install required packages
echo "Installing required packages: wget, unzip, and httpd (Apache)..."
sudo yum install wget unzip httpd -y

# Start and enable the Apache web server
echo "Starting and enabling the Apache web server..."
sudo systemctl start httpd
sudo systemctl enable httpd

# Create a temporary directory for web files
echo "Creating a temporary directory to store web files..."
mkdir -p /tmp/webfiles
cd /tmp/webfiles

# Remove any existing conflicting files
if [ -f "templatemo_589_lugx_gaming" ]; then
    echo "Removing existing conflicting file..."
    rm -f templatemo_589_lugx_gaming
fi

# Download the website template
echo "Downloading the website template..."
wget https://templatemo.com/tm-zip-files-2020/templatemo_589_lugx_gaming.zip

# Extract the downloaded template
echo "Extracting the downloaded template..."
unzip templatemo_589_lugx_gaming.zip -d extracted_files

# Copy the extracted files to the Apache web server's root directory
echo "Copying the template files to the Apache web server's root directory..."
sudo cp -r extracted_files/* /var/www/html/

# Restart the Apache web server
echo "Restarting the Apache web server to apply changes..."
sudo systemctl restart httpd

# Clean up by removing the temporary directory
echo "Cleaning up temporary files..."
rm -rf /tmp/webfiles

echo "Setup completed successfully! You can now access your website via the server's IP address."

