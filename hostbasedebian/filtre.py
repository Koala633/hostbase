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


df = pandas.read_csv("airodumpwpa-01.csv")   # Fichier qui .csv qui sert à l'analyse
df.columns = ['BSSID', 'First time seen', 'Last time seen', 'channel', 'Speed', 'Privacy', 'Cypher', 'Atuthentication', 'Power', '# beacons', '# IV', 'LAN IP', 'ID-lenght', 'ESSID', 'Key']
df = df[['BSSID', 'channel', 'Power', '# IV', 'ESSID']] # Filtrage des colonnes avec pandas pour garder uniquement l'essentiel
df.to_csv('midvalues.csv', index=False)


print(df)



infilemid = "midvalues.csv" # Nouveau fichier généré par pandas avec les 5 colonnes uniquement.On le garde pour la suite.
outfilemid = "midvalues1.csv" # Second filtre appliqué sur le fichier pandas pour enlever les espaces et caractères spéciaux du csv

delete_list = [".0", " "] # Suppression des caractères et espaces inutiles dans le midvalues.csv
with open(infilemid) as fin, open(outfilemid, "w+") as fout:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        fout.write(line)


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
            print(f"{RED}ERROR while finding 2.4GHz network : data not found!")
            print(f"{YELLOW}Maybe you didn't entered the right name or the network is too far...")
            print(f"{RESET}Aborting...")
            os.system("rm -rf *.txt")
            os.system("rm -rf *.csv")
            os.system("rm -rf *.conf")
            os.system("rm -rf *carte")
            print("Bye")
            os.system("killall python3")
            sys.exit()

# os.system("rm -rf *f.txt") A VOIR.
    with open('finalchoice.csv') as cards:
        csv_reader = csv.reader(cards)
        for index, row in enumerate(csv_reader):
            if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
                print(f"{CYAN}Bssid of 2.4GHz selected network :")
                print(row[0])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
                essid1 = (row[0])
                f = open("bssid.txt", "w+")
                f.write(row[0])
                f.close()

    with open('finalchoice.csv') as cards:
        csv_reader = csv.reader(cards)
        for index, row in enumerate(csv_reader):
            if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
                print(f"{CYAN}Channel of 2.4GHz selected network :")
                print(row[1])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
                essid1 = (row[1])
                f = open("channel.txt", "w+")
                f.write(row[1])
                f.close()

    with open('finalchoice.csv') as cards:
        csv_reader = csv.reader(cards)
        for index, row in enumerate(csv_reader):
            if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
                print(f"{CYAN}Essid of 2.4GHz selected network :")
                print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
                essid1 = (row[4])
                f = open("ssid.txt", "w+")
                f.write(row[4])
                f.close()
    print(f"{RESET}Preparing the attack..")




if os.path.isfile('airodumpwpacinqg-01.csv'):
    os.system("rm -rf midvalues.csv")
    os.system("rm -rf midvalues1.csv")
    os.system("rm -rf finalchoice.csv")
    os.system("touch direct.txt")
    df = pandas.read_csv("airodumpwpacinqg-01.csv")  # Fichier qui .csv qui sert à l'analyse
    df.columns = ['BSSID', 'First time seen', 'Last time seen', 'channel', 'Speed', 'Privacy', 'Cypher','Atuthentication', 'Power', '# beacons', '# IV', 'LAN IP', 'ID-lenght', 'ESSID', 'Key']
    df = df[['BSSID', 'channel', 'Power', '# IV','ESSID']]  # Filtrage des colonnes avec pandas pour garder uniquement l'essentiel
    df.to_csv('midvalues.csv', index=False)


    infilemid = "midvalues.csv"  # Nouveau fichier généré par pandas avec les 5 colonnes uniquement.On le garde pour la suite.
    outfilemid = "midvalues1.csv"  # Second filtre appliqué sur le fichier pandas pour enlever les espaces et caractères spéciaux du csv

    delete_list = [".0", " "]  # Suppression des caractères et espaces inutiles dans le midvalues.csv
    with open(infilemid) as fin, open(outfilemid, "w+") as fout:
        for line in fin:
            for word in delete_list:
                line = line.replace(word, "")
            fout.write(line)

    supprbssid = subprocess.Popen("bash delssidconnected.sh", shell=True)  # Suppression du bssid 2.4GHz pour éviter la confusion avec celui en 5G dans la lecture du fichier csv.
    time.sleep(2)
    ssid = open("ssidf.txt", "w+")
    with open('midvalues1.csv') as cards:  # Placement des données dans les fichiers textes sans caractères inutiles après le second filtre sur midvalues1.csv
        csv_reader = csv.reader(cards)
        for index, row in enumerate(csv_reader):
            ssid.write(f"{row[4]}\n")
    print(f"{RESET}Saving 5GHz data from selected network...")
    cinqfiltre = subprocess.Popen("python3 filtre1.py", shell=True)
    sys.exit()
else:
    attack = subprocess.Popen("python3 attack2.py", shell=True)
    sys.exit()