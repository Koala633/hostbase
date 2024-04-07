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

print(f"{BLUE}Higher traffic registered in two minute :")
print(iv) #result
iv=str(iv)

with open('identfinal.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(f"{GREEN}The 3 networks selected :")
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
print(f"{RESET}Selecting the final target...")

with open("identfinal.csv", "r") as csv:
   found = False
   for line in csv:
        if finale in line:
            print(line)
            print(f"{GREEN}First target has been selected as target network !")
            f = open("finalchoice.csv", "w+")  # on mets les données de la ligne dans le fichier ident3.txt
            f.write(line)
            f.close()
            found = True
            prepfinale = subprocess.Popen("python3 iv15.py", shell=True)
            sys.exit()
if not found: print(f"{YELLOW}First target has been removed from target list")

print(f"{RESET}Second target...")

finale = ("," + iv + v + essid2)

with open("identfinal.csv", "r") as csv:
   found = False
   for line in csv:
        if finale in line:
            print(line)
            print(f"{GREEN}Second target has been selected as target network !")
            f = open("finalchoice.csv", "w+")  # on mets les données de la ligne dans le fichier ident3.txt
            f.write(line)
            f.close()
            found = True
            prepfinale = subprocess.Popen("python3 iv15.py", shell=True)
            sys.exit()
if not found: print(f"{YELLOW}Second target has been removed from target list")

print(f"{RESET}Third target...")

finale = ("," + iv + v + essid3)

with open("identfinal.csv", "r") as csv:
   found = False
   for line in csv:
        if finale in line:
            print(line)
            print(f"{GREEN}Third target has been selected as target network !")
            f = open("finalchoice.csv", "w+")  # on mets les données de la ligne dans le fichier ident3.txt
            f.write(line)
            f.close()
            found = True
            prepfinale = subprocess.Popen("python3 iv15.py", shell=True)
            sys.exit()
if not found: print(f"{YELLOW}Third target has been removed from target list")
