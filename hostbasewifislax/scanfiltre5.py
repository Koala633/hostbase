import os
import csv
import pandas
import subprocess
import time
import sys

GREEN = "\033[32m"
YELLOW = "\033[33m"
RESET = "\033[0m"





df = pandas.read_csv("airodumpwpa-01.csv")   # Fichier qui .csv qui sert à l'analyse
df.columns = ['BSSID', 'First time seen', 'Last time seen', 'channel', 'Speed', 'Privacy', 'Cypher', 'Atuthentication', 'Power', '# beacons', '# IV', 'LAN IP', 'ID-lenght', 'ESSID', 'Key']
df = df[['BSSID', 'channel', 'Power', '# IV', 'ESSID']] # Filtrage des colonnes avec pandas pour garder uniquement l'essentiel
df.to_csv('midvalues.csv', index=False)

if os.path.isfile('domesticmode'):
    with open('/tmp/ssid') as f:
      ssidconnected = f.readline()

    domestique = subprocess.Popen("bash delssidconnected.sh", shell=True)
    print(f"{GREEN}Modo domestic ON : su red ha sido borrado de la lista...")
    print(f"{RESET}Eso quiere decir que Hostbase no la atacara...")
    time.sleep(2)
    os.system("touch delssid5g.txt")
else:
    savage = subprocess.Popen("bash delssidconnected.sh", shell=True)
    print(f"{YELLOW}Modo salvaje ON : quisas Hostbase atacara su red... depende del trafico")
    print(f"{RESET}Este modo no esta consejado si su red esta cerca...")
    time.sleep(2)
print(df)



infilemid = "midvalues.csv" # Nouveau fichier généré par pandas avec les 5 colonnes uniquement.On le garde pour la suite.
outfilemid = "midvalues1.csv" # Second filtre appliqué sur le fichier pandas pour enlever les espaces et caractères spéciaux du csv

delete_list = [".0", " "] # Suppression des caractères et espaces inutiles dans le midvalues.csv
with open(infilemid) as fin, open(outfilemid, "w+") as fout:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        fout.write(line)

bssid = open("bssid.txt", "w+") # Création des fichiers textes correspondant aux colonnes
channel = open("channel.txt", "w+")
power = open("power.txt", "w+")
iv = open("iv.txt", "w+")
essid = open("essid.txt", "w+")

with open('midvalues1.csv') as cards: # Placement des données dans les fichiers textes sans caractères inutiles après le second filtre sur midvalues1.csv
   csv_reader = csv.reader(cards)
   for index, row in enumerate(csv_reader):
      bssid.write(f"{row[0]}\n")
      channel.write(f"{row[1]}\n")
      power.write(f"{row[2]}\n")
      iv.write(f"{row[3]}\n")
      essid.write(f"{row[4]}\n")

# supprbssid à mettre la si suppr.txt existe ?'
if os.path.isfile('direct.txt'):
    supprbssid = subprocess.Popen("bash delssidconnected.sh", shell=True)  # Suppression du bssid 2.4GHz pour éviter la confusion avec celui en 5G dans la lecture du fichier csv.
    time.sleep(2)
    analysedeux = subprocess.Popen("python scanfiltre4.py", shell=True)
    sys.exit()
else:
    analyseun = subprocess.Popen("python scanfiltre4.py", shell=True)
    sys.exit()