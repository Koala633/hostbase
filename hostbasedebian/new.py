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

with open('deuxgcarte') as f:
 scan = f.readline()

with open('ivdeuxg.txt') as i:
 ivdeuxg = i.readline()

with open('ivcinqg.txt') as bis:
 ivcinqg = bis.readline()

ivdeuxg=int(ivdeuxg)
ivcinqg=int(ivcinqg)

if os.path.isfile('domesticmode'):
    with open('/tmp/ssid') as f:
      ssidconnected = f.readline()

    domestique = subprocess.Popen("bash delssidconnected.sh", shell=True)
    print(f"{GREEN}Domestic mode ON : your network has been removed from network target list...")
    print(f"{RESET}This mode means hostbase will not attack the network you were connected to")
    time.sleep(2)
else:
    savage = subprocess.Popen("bash delssidconnected.sh", shell=True)
    print(f"{YELLOW}Savage mode ON...")
    print(f"{RESET}This mode is not recommended if you don't want to attack your own network...")
    time.sleep(2)

if ivdeuxg >= ivcinqg:
    print(f"{MAGENTA}2.4GHz traffic is higher than 5GHz traffic... nothing to do...")
    print(f"{RESET}Saving final data about 5GHz target network...")


    with open("ssid.txt", 'r') as file:
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
            print('ERROR while finding 5GHz network : data not found!')

    os.system("rm -rf *f.txt")
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
else:
    os.system("wmctrl -r :ACTIVE: -b add,fullscreen")
    print(f"{YELLOW}5GHz traffic is higher than 2.4GHz from the previous selected network... network selection has changed... ")
    print(f"{CYAN}5GHz frequency has less range than 2.4GHz that mean the attack will be more effective... ")
    print(f"{MAGENTA}Restarting airodump on 2.4GHz to get all data about this new selected network...")
    print(f"{RESET}Starting monitor mode...")
    os.system("rm -rf airodumpwpa-*.csv")
    print("Scan duration : 15s...")
    os.system("ip link set" + " " + scan + " " + "down")
    os.system("iw dev" + " " + scan + " " + "set type monitor")
    time.sleep(4)
    os.system("ip link set" + " " + scan + " " + "up")
    time.sleep(3)

    airodump = subprocess.Popen("airodump-ng" + " " + "-b" + " " + "g" + " " + scan + " " + "-w airodumpwpa --output-format csv", shell=True)
    time.sleep(17)
    os.system("pkill -TERM -P %s"%airodump.pid)

print("Reseting wifi card as normal operation...")
os.system("ip link set" + " " + scan + " " + "down")
os.system("iw dev" + " " + scan + " " + "set type managed")
time.sleep(4)
os.system("ip link set" + " " + scan + " " + "up")
time.sleep(3)
os.system("wmctrl -r :ACTIVE: -b remove,fullscreen")


os.system("rm -rf bssid.txt")
os.system("rm -rf channel.txt")
# os.system("rm -rf ssid.txt")
df = pandas.read_csv("airodumpwpa-01.csv")   # Fichier qui .csv qui sert à l'analyse
df.columns = ['BSSID', 'First time seen', 'Last time seen', 'channel', 'Speed', 'Privacy', 'Cypher', 'Atuthentication', 'Power', '# beacons', '# IV', 'LAN IP', 'ID-lenght', 'ESSID', 'Key']
df = df[['BSSID', 'channel', 'Power', '# IV', 'ESSID']] # Filtrage des colonnes avec pandas pour garder uniquement l'essentiel
df.to_csv('newvalues.csv', index=False)

if os.path.isfile('domesticmode'):
    with open('/tmp/ssid') as f:
      ssidconnected = f.readline()

    domestique = subprocess.Popen("bash delssidconnected.sh", shell=True)
    print(f"{GREEN}Domestic mode ON : your network has been removed from network target list...")
    print(f"{RESET}This mode means hostbase will not attack the network you were connected to")
    time.sleep(2)
else:
    savage = subprocess.Popen("bash delssidconnected.sh", shell=True)
    print(f"{YELLOW}Savage mode ON...")
    print(f"{RESET}This mode is not recommended if you don't want to attack your own network...")
    time.sleep(2)

print(df)

infilemid = "newvalues.csv" # Nouveau fichier généré par pandas avec les 5 colonnes uniquement.On le garde pour la suite.
outfilemid = "newvalues1.csv" # Second filtre appliqué sur le fichier pandas pour enlever les espaces et caractères spéciaux du csv

delete_list = [".0", " "] # Suppression des caractères et espaces inutiles dans le midvalues.csv
with open(infilemid) as fin, open(outfilemid, "w+") as fout:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        fout.write(line)

f = open('./ssidf.txt','r')
a = ['_5GHZ','_5GHz','-5GHz', '-5GHZ', '_5G', '-5G']
lst = []
for line in f:
    for word in a:
        if word in line:
            line = line.replace(word,'')
    lst.append(line)
f.close()
f = open('./ssidf.txt','w')
for line in lst:
    f.write(line)
f.close()

with open("ssidf.txt", 'r') as file:
    data = [line.strip() for line in file if line.strip() != '']

for i, name in enumerate(data):
    found = False
    with open('newvalues1.csv', 'r') as file:
        csv_reader = csv.reader(file)
        for row in csv_reader:
            if any(name in cell for cell in row):
                line = ','.join(row)
                print(line)
                print(f'Found {name}!')
                f = open(f'newnetwork.csv', 'w+')
                f.write(line)
                f.close()
                found = True
                finale = subprocess.Popen("python3 newfinal.py", shell=True)
                break

    if not found:
        print(f"{RED}The data of new selected network were not been found aborting now !")
        os.system("mv ssid.txt ssid") # histoire de garder une trace
        os.system("rm -rf *.txt")
        os.system("rm -rf *.csv")
        os.system("rm -rf *.conf")
        os.system("rm -rf /tmp/*sid")
        os.system("rm -rf *carte")
        os.system("rm -rf domesticmode")
        sys.exit(0)


