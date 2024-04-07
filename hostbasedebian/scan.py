import os
import csv
import pandas
import time
import subprocess
import sys
import re

GREEN = "\033[32m"
YELLOW = "\033[33m"

with open('hostapdcarte') as f:
 scan = f.readline()

print("Stopping network-manager...")
os.system("systemctl stop NetworkManager.service")
time.sleep(1)
os.system("systemctl disable NetworkManager.service")
time.sleep(4)
print("Starting monitor mode...")
print("Scan duration : 120s...")
os.system("ip link set" + " " + scan + " " + "down")
os.system("iw dev" + " " + scan + " " + "set type monitor")
time.sleep(4)
os.system("ip link set" + " " + scan + " " + "up")
time.sleep(3)
os.system("wmctrl -r :ACTIVE: -b add,fullscreen")

airodump = subprocess.Popen("airodump-ng" + " " + scan + " " + "--encrypt WPA -w airodumpwpa --output-format csv", shell=True)
time.sleep(64)
os.system("pkill -TERM -P %s"%airodump.pid)

print("Reseting wifi card as normal operation...")
os.system("ip link set" + " " + scan + " " + "down")
os.system("iw dev" + " " + scan + " " + "set type managed")
time.sleep(4)
os.system("ip link set" + " " + scan + " " + "up")
time.sleep(3)
scanfiltre = subprocess.Popen("python3 scanfiltre5.py", shell=True)

