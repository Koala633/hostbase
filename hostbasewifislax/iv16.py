import os
import csv
import sys
import subprocess

YELLOW = "\033[33m"
GREEN = "\033[32m"
RESET = "\033[0m"
MAGENTA = "\033[35m"
RED = "\033[31m"
BLUE = "\033[34m"

def finalconfig():
    print('Preparing files...')




iv = 0
with open('troisiv.txt', 'r') as data: # use the with context so that the file closes gracefully
  for line in data.readlines(): # read the lines as a generator to be nice to my memory
    try:
      val = int(line.split(",")[0])
    except ValueError: # just incase the text file is not formatted like your example
      val = 0
    if val > iv: # logic
      iv = val

print(f"{BLUE}El mas grande trafico registrado en 2 minutos :")
print(iv) #result
iv=str(iv)

with open('identfinal.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(f"{GREEN}Las 3 redes guardado :")
      print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid1=(row[4])
      f = open("essid1temp.txt", "w+")
      f.write(row[4])
      f.close()

infileivtemp = "essid1temp.txt"
outfileivun = "essid1.txt"  # Fichier final

delete_list = [" "]  # Élimination de l'espace avant le ssid du au fichier .csv
with open(infileivtemp) as fin, open(outfileivun, "w+") as fout:
  for line in fin:
    for word in delete_list:
      line = line.replace(word, "")
    fout.write(line)

with open('identfinal.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 1:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid2=(row[4])
      f = open("essid2temp.txt", "w+")
      f.write(row[4])
      f.close()

infileivtempdeux = "essid2temp.txt"
outfileivdeux = "essid2.txt"  # Fichier final

delete_list = [" "]  # Élimination de l'espace avant le ssid du au fichier .csv
with open(infileivtempdeux) as fin, open(outfileivdeux, "w+") as fout:
  for line in fin:
    for word in delete_list:
      line = line.replace(word, "")
    fout.write(line)

with open('identfinal.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 2:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid3=(row[4])
      f = open("essid3temp.txt", "w+")
      f.write(row[4])
      f.close()

infileivtemp = "essid3temp.txt"
outfileivtrois = "essid3.txt"  # Fichier final

delete_list = [" "]  # Élimination de l'espace avant le ssid du au fichier .csv
with open(infileivtemp) as fin, open(outfileivtrois, "w+") as fout:
  for line in fin:
    for word in delete_list:
      line = line.replace(word, "")
    fout.write(line)

v =','
finale = ("," + iv + v + essid1)
print(f"{RESET}Seleccionando la red final...")

with open("identfinal.csv", "r") as csv:
   found = False
   for line in csv:
        if finale in line:
            print(line)
            print(f"{GREEN}La primera red ha sido elegido !")
            f = open("finalchoice.csv", "w+")  # on mets les données de la ligne dans le fichier ident3.txt
            f.write(line)
            f.close()
            found = True
            prepfinale = subprocess.Popen("python iv15.py", shell=True)
            sys.exit()
if not found: print(f"{YELLOW}La primera red has sido borrado de la lista")

print(f"{RESET}Segunda cibla...")

finale = ("," + iv + v + essid2)

with open("identfinal.csv", "r") as csv:
   found = False
   for line in csv:
        if finale in line:
            print(line)
            print(f"{GREEN}La segunda red ha sido elegido !")
            f = open("finalchoice.csv", "w+")  # on mets les données de la ligne dans le fichier ident3.txt
            f.write(line)
            f.close()
            found = True
            prepfinale = subprocess.Popen("python iv15.py", shell=True)
            sys.exit()
if not found: print(f"{YELLOW}La segunda red has sido borrado de la lista")

print(f"{RESET}Tercera cibla...")

finale = ("," + iv + v + essid3)

with open("identfinal.csv", "r") as csv:
   found = False
   for line in csv:
        if finale in line:
            print(line)
            print(f"{GREEN}La tercera red ha sido elegido !")
            f = open("finalchoice.csv", "w+")  # on mets les données de la ligne dans le fichier ident3.txt
            f.write(line)
            f.close()
            found = True
            prepfinale = subprocess.Popen("python iv15.py", shell=True)
            sys.exit()
if not found: print(f"{YELLOW}La tercera red has sido borrado de la lista")