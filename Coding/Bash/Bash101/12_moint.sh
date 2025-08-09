#!/bin/bash

echo "################################"

# Check if the httpd.pid file exists
if [ -f /var/run/httpd/httpd.pid ]; then
    echo "Httpd process is Running."
else
    echo "Httpd process is Not Running."
    echo "Starting the process"
    
    # Try to start httpd service
    systemctl start httpd
    if [ $? -eq 0 ]; then
        echo "Process started successfully."
    else
        echo "Process starting failed, contact the admin."
    fi
fi

# Log the script execution
echo "$(date) - Script executed" >> /var/log/monit_httpd_test.log

echo "#################################"
