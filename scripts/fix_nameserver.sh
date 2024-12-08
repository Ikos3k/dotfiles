#!/bin/bash

# Define the nameserver
NAMESERVER="nameserver 8.8.8.8"

# Check if the nameserver already exists in /etc/resolv.conf
if grep -q "$NAMESERVER" /etc/resolv.conf; then
    echo "Nameserver $NAMESERVER is already present in /etc/resolv.conf."
else
    # Add the nameserver to /etc/resolv.conf
    echo "$NAMESERVER" | sudo tee -a /etc/resolv.conf > /dev/null
    echo "Nameserver $NAMESERVER has been added to /etc/resolv.conf."
fi
