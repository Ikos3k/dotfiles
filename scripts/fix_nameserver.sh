#!/bin/bash

NAMESERVER="nameserver 8.8.8.8"

if grep -q "$NAMESERVER" /etc/resolv.conf; then
    echo "Nameserver $NAMESERVER is already present in /etc/resolv.conf."
else
    echo "$NAMESERVER" | sudo tee -a /etc/resolv.conf > /dev/null
    echo "Nameserver $NAMESERVER has been added to /etc/resolv.conf."
fi
