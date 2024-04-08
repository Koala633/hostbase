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

print("Parando network-manager...")
os.system("airmon-ng check kill")
time.sleep(4)
print("Iniciando modo monitor...")
print("Tiempo de airodump : 120s...")
os.system("ip link set" + " " + scan + " " + "down")
os.system("iw dev" + " " + scan + " " + "set type monitor")
time.sleep(4)
os.system("ip link set" + " " + scan + " " + "up")
time.sleep(3)
os.system("wmctrl -r :ACTIVE: -b add,fullscreen")

airodump = subprocess.Popen("airodump-ng" + " " + scan + " " + "--encrypt WPA -w airodumpwpa --output-format csv", shell=True)
time.sleep(124)
airodump.terminate()
airodump.wait()
airodump.kill()

print("Vuelta a la configuracion normal de la tarjeta wifi...")
os.system("ip link set" + " " + scan + " " + "down")
os.system("iw dev" + " " + scan + " " + "set type managed")
time.sleep(4)
os.system("ip link set" + " " + scan + " " + "up")
time.sleep(3)
scanfiltre = subprocess.Popen("python scanfiltre5.py", shell=True)

