import os
import re
import csv
import subprocess

os.system("awk '1' ident*.txt > identfinal.csv")

with open('identfinal.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(row[3])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      f = open("iv1temp.txt", "w+")
      f.write(row[3])
      f.close()

infileivtemp = "iv1temp.txt"
outfileivun = "iv1.txt"  # Fichier final

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
      print(row[3])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      f = open("iv2temp.txt", "w+")
      f.write(row[3])
      f.close()

infileivtempdeux = "iv2temp.txt"
outfileivdeux = "iv2.txt"  # Fichier final

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
      print(row[3])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      f = open("iv3temp.txt", "w+")
      f.write(row[3])
      f.close()

infileivtemp = "iv3temp.txt"
outfileivtrois = "iv3.txt"  # Fichier final

delete_list = [" "]  # Élimination de l'espace avant le ssid du au fichier .csv
with open(infileivtemp) as fin, open(outfileivtrois, "w+") as fout:
  for line in fin:
    for word in delete_list:
      line = line.replace(word, "")
    fout.write(line)

    #os.system("cat iv1.txt iv2.txt iv3.txt >> troisiv.txt")
    os.system("awk '1' iv1.txt iv2.txt iv3.txt > troisiv.txt")
    #os.system("head -c-1 troisiv.txt > tempp.txt; mv tempp.txt troisiv.txt")

analysecinq = subprocess.Popen("python3 iv1.py", shell=True)
