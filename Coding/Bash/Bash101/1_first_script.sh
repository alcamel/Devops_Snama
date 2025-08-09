#!/bin/bash

echo "++++++++++++"
echo "Hello World!" 

# this script print uptime # 
echo "++++++++++++++++++++++++++++"
echo "The uptime of the system is:" 
uptime 

# This part print Memory Info # 
echo "++++++++++++++++++"
echo "Memory Utilization"
free -m 

# This part print Disk Info # 
echo "++++++++++++++++"
echo "Disk Utilization"
df -h 
