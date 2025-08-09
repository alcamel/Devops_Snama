#!/bin/bash

value=$(ip addr show | grep -v LOOPBACK | grep -ic mtu)

 

if [[ $value == 1 ]]
then 
    echo "1 Active Network Interface found."
elif [[ $value > 1 ]]
then 
    echo "Found Multtiple active Interface ($value)."
else 
    echo "No Active interface found."
fi 

echo "=============================="
echo "Script Execution Successfully." 
echo "=============================="