import os
import csv
import re
import subprocess
import sys

GREEN = "\033[32m"
YELLOW = "\033[33m"
CYAN = "\033[36m"
RESET = "\033[0m"
RED = "\033[31m"


if os.path.isfile('direct.txt'):
  # supprbssid = subprocess.Popen("bash delssidconnected.sh", shell=True) # Suppression du bssid 2.4GHz pour éviter la confusion avec celui en 5G dans la lecture du fichier csv.
  print(f"{RESET}Saving new data...")
  with open('newnetwork.csv') as cards:
    csv_reader = csv.reader(cards)
    for index, row in enumerate(csv_reader):
      if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
        print(f"{CYAN}Bssid of new selected network (5GHz) :")
        print(row[0])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
        essid1 = (row[0])
        f = open("bssidf.txt", "w+")
        f.write(row[0])
        f.close()

  with open('newnetwork.csv') as cards:
    csv_reader = csv.reader(cards)
    for index, row in enumerate(csv_reader):
      if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
        print(f"{CYAN}Channel of new selected network (5GHz) :")
        print(row[1])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
        essid1 = (row[1])
        f = open("canalf.txt", "w+")
        f.write(row[1])
        f.close()

  with open('newnetwork.csv') as cards:
    csv_reader = csv.reader(cards)
    for index, row in enumerate(csv_reader):
      if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
        print(f"{CYAN}Essid of new selected network (5GHz) :")
        print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
        essid1 = (row[4])
        f = open("ssidf.txt", "w+")
        f.write(row[4])
        f.close()

  os.system("rm -rf direct.txt")
  print(f"{GREEN}All data from this new target network has been save...")
  print(f"{RESET}Starting the attack...")
  attack = subprocess.Popen("python attack2.py", shell=True)
  sys.exit()
else:
  print(f"{RESET}Saving new data...")
  os.system("rm -rf ssid.txt")
  with open('newnetwork.csv') as cards:
    csv_reader = csv.reader(cards)
    for index, row in enumerate(csv_reader):
      if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
        print(f"{CYAN}Bssid of new selected network (2.4GHz) :")
        print(row[0])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
        essid1=(row[0])
        f = open("bssid.txt", "w+")
        f.write(row[0])
        f.close()

  with open('newnetwork.csv') as cards:
    csv_reader = csv.reader(cards)
    for index, row in enumerate(csv_reader):
      if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
        print(f"{CYAN}Channel of new selected network (2.4GHz) :")
        print(row[1])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
        essid1=(row[1])
        f = open("channel.txt", "w+")
        f.write(row[1])
        f.close()

  with open('newnetwork.csv') as cards:
    csv_reader = csv.reader(cards)
    for index, row in enumerate(csv_reader):
      if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
        print(f"{CYAN}Essid of new selected network (2.4GHz) :")
        print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
        essid1=(row[4])
        f = open("ssid.txt", "w+")
        f.write(row[4])
        f.close()

      print(f"{GREEN}All data from this new target network has been save...")
      print(f"{RESET}Starting the attack...")
      attack = subprocess.Popen("python attack2.py", shell=True)
      sys.exit()
