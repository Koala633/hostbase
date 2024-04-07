import os
import subprocess
import time
import csv
import sys
import signal
from signal import SIGINT, SIGTERM, sigwait
from signal import signal, SIGINT
import pandas

GREEN = "\033[32m"
YELLOW = "\033[33m"
CYAN = "\033[36m"
MAGENTA = "\033[35m"
RESET = "\033[0m"
RED = "\033[31m"






with open("ssid.txt", 'r') as file:  # A METTRE le input pour choper le ssid.
    data = [line.strip() for line in file if line.strip() != '']

    for i, number in enumerate(data):
        found = False
        with open('midvalues1.csv', 'r') as file:
                csv_reader = csv.reader(file)
                for row in csv_reader:
                    if any(number in cell for cell in row):
                        line = ','.join(row)
                        print(line)
                        print(f'Found {number}!')
                        f = open(f'finalchoice.csv', 'w+')
                        f.write(line)
                        f.close()
                        found = True
                        break

        if not found:
            print(f"{RED}ERROR while finding 5GHz network selected : data not found!")
            print(f"{YELLOW}Maybe this network hand only with 2.4GHz frequency...")
            print(f"{RESET}Trying to attack it on 2.4GHz frequency...")
            os.system("rm -rf cinqgcarte") # AP sur le tel pour tester.
            attack = subprocess.Popen("python3 attack2.py", shell=True)
            sys.exit()

# os.system("rm -rf *f.txt") A VOIR.
    with open('finalchoice.csv') as cards:
        csv_reader = csv.reader(cards)
        for index, row in enumerate(csv_reader):
            if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
                print(f"{CYAN}Bssid of 5GHz selected network :")
                print(row[0])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
                essid1 = (row[0])
                f = open("bssidf.txt", "w+")
                f.write(row[0])
                f.close()

    with open('finalchoice.csv') as cards:
        csv_reader = csv.reader(cards)
        for index, row in enumerate(csv_reader):
            if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
                print(f"{CYAN}Channel of 5GHz selected network :")
                print(row[1])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
                essid1 = (row[1])
                f = open("canalf.txt", "w+")
                f.write(row[1])
                f.close()

    with open('finalchoice.csv') as cards:
        csv_reader = csv.reader(cards)
        for index, row in enumerate(csv_reader):
            if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
                print(f"{CYAN}Essid of 5GHz selected network :")
                print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
                essid1 = (row[4])
                f = open("ssidf.txt", "w+")
                f.write(row[4])
                f.close()

    print(f"{RESET}Starting the attack...")
    attack = subprocess.Popen("python3 attack2.py", shell=True)
    sys.exit()


