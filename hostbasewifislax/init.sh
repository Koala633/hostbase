#!/bin/bash


ip -br l | awk '$1 !~ "lo|vir|en" {print $1}' > cartes.conf
airmon-ng
iw list | grep "Supported interface modes" -A 8 > interfaces.txt