import os
import csv
import pandas
import time
import subprocess
import sys
import re

YELLOW = "\033[33m"
RED = "\033[31m"
GREEN = "\033[32m"
BLUE = "\033[34m"
CYAN = "\033[36m"
MAGENTA = "\033[35m"
RESET = "\033[0m"

with open('hostapdcarte') as f:
 scan = f.readline()

print("Parando network-manager...")
os.system("airmon-ng check kill")
time.sleep(4)
print("Iniciando airodump en 2.4GHz para tenar mas informaciones sobre la red...")
print("Tiempo de airodump : 20s...")
os.system("ip link set" + " " + scan + " " + "down")
os.system("iw dev" + " " + scan + " " + "set type monitor")
time.sleep(4)
os.system("ip link set" + " " + scan + " " + "up")
time.sleep(3)
os.system("wmctrl -r :ACTIVE: -b add,fullscreen")

airodump = subprocess.Popen("airodump-ng" + " " + scan + " " + "--encrypt WPA -w airodumpwpa --output-format csv", shell=True)
time.sleep(20)
airodump.terminate()
airodump.wait()
airodump.kill()


print("Vuelta de la tarjeta a la normal...")
os.system("ip link set" + " " + scan + " " + "down")
os.system("iw dev" + " " + scan + " " + "set type managed")
time.sleep(4)
os.system("ip link set" + " " + scan + " " + "up")
time.sleep(3)


if os.path.isfile('cinqgcarte'):
  with open('cinqgcarte') as f:
    scan = f.readline()
  os.system("cp -R ssid.txt LasTry")
  print("Iniciando airodump en 5GHz...")
  print("Inciando modo monitor...")
  print("Tiempo de airodump : 30s...")
  os.system("ip link set" + " " + scan + " " + "down")
  os.system("iw dev" + " " + scan + " " + "set type monitor")
  time.sleep(4)
  os.system("ip link set" + " " + scan + " " + "up")
  time.sleep(3)
  os.system("wmctrl -r :ACTIVE: -b add,fullscreen")
  os.system("touch cinqgscanfait")
  airodump = subprocess.Popen("airodump-ng" + " " + "-b" + " " + "a" + " " + scan + " " + "-w airodumpwpacinqg --output-format csv", shell=True)
  time.sleep(30)
  airodump.terminate()
  airodump.wait()
  airodump.kill()

  print("Vuelta de la tarjeta a la normal...")
  os.system("ip link set" + " " + scan + " " + "down")
  os.system("iw dev" + " " + scan + " " + "set type managed")
  time.sleep(4)
  os.system("ip link set" + " " + scan + " " + "up")
  time.sleep(3)
  os.system("wmctrl -r :ACTIVE: -b remove,fullscreen")
  filtre = subprocess.Popen("python filtre.py", shell=True)
else:
    os.system("wmctrl -r :ACTIVE: -b remove,fullscreen")
    filtre = subprocess.Popen("python filtre.py", shell=True)

