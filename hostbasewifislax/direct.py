import os
import subprocess
import time
import csv
import sys
import signal
from signal import SIGINT, SIGTERM, sigwait
from signal import signal, SIGINT
import pandas

YELLOW = "\033[33m"
RED = "\033[31m"
GREEN = "\033[32m"
BLUE = "\033[34m"
CYAN = "\033[36m"
MAGENTA = "\033[35m"
RESET = "\033[0m"


print(f"{RESET}Configuracion del ataque...")
with open('finalchoice.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(f"{CYAN}Bssid de la red :")
      print(row[0])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid1=(row[0])
      f = open("bssid.txt", "w+")
      f.write(row[0])
      f.close()

with open('finalchoice.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(f"{CYAN}Canal de la red :")
      print(row[1])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid1=(row[1])
      f = open("channel.txt", "w+")
      f.write(row[1])
      f.close()

with open('finalchoice.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(f"{CYAN}Essid de la red :")
      print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid1=(row[4])
      f = open("ssid.txt", "w+")
      f.write(row[4])
      f.close()


if os.path.isfile('cinqgcarte'):

  with open('cinqgcarte') as f:
    scan = f.readline()
  os.system("mv bssid.txt bssid2g.txt")
  os.system("mv channel.txt channel2g.txt")
  os.system("mv ssid.txt ssid2g.txt")
  os.system("cp -R bssid2g.txt LasTry")
  os.system("cp -R channel2g.txt LasTry")
  os.system("cp -R ssid2g.txt LasTry")
  print(f"{RESET}Iniciando un scan en 5GHz para tener mas informaciones sobre la red...")
  print("Iniciando modo monitor...")
  print("Tiempo de airodump : 30s... ESPERA...")
  os.system("ip link set" + " " + scan + " " + "down")
  os.system("iw dev" + " " + scan + " " + "set type monitor")
  time.sleep(4)
  os.system("ip link set" + " " + scan + " " + "up")
  time.sleep(3)
  os.system("wmctrl -r :ACTIVE: -b add,fullscreen")
  os.system("mv finalchoice.csv finalchoice2g")
  # os.system("rm -rf *.txt")
  # os.system("rm -rf *.csv")
  os.system("touch cinqgscanfait")
  os.system("touch direct.txt")
  airodumpdirect = subprocess.Popen("airodump-ng" + " " + "-b" + " " + "a" + " " + scan + " " + "-w airodumpwpadirect --output-format csv", shell=True)
  time.sleep(30)
  airodumpdirect.terminate()
  airodumpdirect.wait()
  airodumpdirect.kill()

  print("Vuelta a la configuracion normal de la tarjeta wifi 5GHz...")
  os.system("wmctrl -r :ACTIVE: -b remove,fullscreen")
  os.system("ip link set" + " " + scan + " " + "down")
  os.system("iw dev" + " " + scan + " " + "set type managed")
  time.sleep(4)
  os.system("ip link set" + " " + scan + " " + "up")
  time.sleep(3)
  df = pandas.read_csv("airodumpwpadirect-01.csv")  # Fichier qui .csv qui sert à l'analyse
  df.columns = ['BSSID', 'First time seen', 'Last time seen', 'channel', 'Speed', 'Privacy', 'Cypher', 'Atuthentication', 'Power', '# beacons', '# IV', 'LAN IP', 'ID-lenght', 'ESSID', 'Key']
  df = df[['BSSID', 'channel', 'Power', '# IV', 'ESSID']]  # Filtrage des colonnes avec pandas pour garder uniquement l'essentiel
  df.to_csv('midvalues.csv', index=False)
else:
    print('Iniciando ahora el ataque encontra la red (2.4GHz)...')
    attack = subprocess.Popen("python attack2.py", shell=True)
    sys.exit()

if os.path.isfile('domesticmode'):
      with open('/tmp/ssid') as f:
          ssidconnected = f.readline()

      domestique = subprocess.Popen("bash delssidconnected.sh", shell=True)
      print(f"{GREEN}Modo domestic ON : su red ha sido borrado de la lista...")
      os.system("touch delssid5g.txt")
else:
      savage = subprocess.Popen("bash delssidconnected.sh", shell=True)
      print(f"{YELLOW}Modo savage ON : quisas Hostbase iniciara el ataque encontra de su red si hay bastante trafico...")
      print(f"{RESET}Este modo no esta recomandado en el caso donde usted no quiere atacar a su propia red...")

print(df)

infilemid = "midvalues.csv"  # Nouveau fichier généré par pandas avec les 5 colonnes uniquement.On le garde pour la suite.
outfilemid = "midvalues1.csv"  # Second filtre appliqué sur le fichier pandas pour enlever les espaces et caractères spéciaux du csv

delete_list = [".0", " "]  # Suppression des caractères et espaces inutiles dans le midvalues.csv
with open(infilemid) as fin, open(outfilemid, "w+") as fout:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        fout.write(line)

os.system("mv finalchoice2g finalchoice2g.csv")
print(f"{RESET}Preparacion del ataque...")
with open('finalchoice2g.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(f"{CYAN}Bssid de la red :")
      print(row[0])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid1=(row[0])
      f = open("bssid.txt", "w+")
      f.write(row[0])
      f.close()

with open('finalchoice2g.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(f"{CYAN}Canal de la red :")
      print(row[1])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid1=(row[1])
      f = open("channel.txt", "w+")
      f.write(row[1])
      f.close()

with open('finalchoice2g.csv') as cards:
  csv_reader = csv.reader(cards)
  for index, row in enumerate(csv_reader):
    if index == 0:  # déplacement vertical dans ce cas la ligne 1 Livebox-D380
      print(f"{CYAN}Essid de la red :")
      print(row[4])  # deplacement horizontal dans la ligne 1, dans ce cas la l'ESSID
      essid1=(row[4])
      f = open("ssid.txt", "w+")
      f.write(row[4])
      f.close()


supprbssid = subprocess.Popen("bash delssidconnected.sh", shell=True) # Suppression du bssid 2.4GHz pour éviter la confusion avec celui en 5G dans la lecture du fichier csv.
time.sleep(2)

with open("ssid.txt", 'r') as file:
 data = [line.strip() for line in file if line.strip() != '']

for i, name in enumerate(data):
      found = False
      with open('midvalues1.csv', 'r') as file:
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
                  final = subprocess.Popen("python newfinal.py", shell=True)
                  break

      if not found:
          print(f"{RED}ERROR : los datos de la red no han sido encontrado, salida del script ahora !")
          os.system("mv ssid.txt ssid")  # histoire de garder une trace
          os.system("rm -rf *.txt")
          os.system("rm -rf *.csv")
          os.system("rm -rf *.conf")
          os.system("rm -rf /tmp/*sid")
          os.system("rm -rf *carte")
          os.system("rm -rf domesticmode")
          sys.exit(0)

