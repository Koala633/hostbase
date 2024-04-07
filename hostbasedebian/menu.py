import os
import itertools
import signal
from signal import SIGINT, SIGTERM, sigwait
from signal import signal, SIGINT
import sys
from sys import exit
import subprocess
import pandas

# pandas lib is not necessary in this menu script but we keep it to see if some errors come from pyenv install

YELLOW = "\033[33m"
RED = "\033[31m"
GREEN = "\033[32m"
BLUE = "\033[34m"
CYAN = "\033[36m"
MAGENTA = "\033[35m"
RESET = "\033[0m"

# Script working with python >= 3.10
# Verif que le fichier contenant la clé soit éffacé pour éviter une reconnexion sur un réseau fantome à la fin du script.
if os.path.isfile('/home/wpa_supplicant.conf') or os.path.isfile('/home/cle.txt'):
    os.system("rm -rf /home/wpa_supplicant.conf")
    os.system("rm -rf /home/cle.txt")
    os.system("rm -rf *carte")
else:
    None

print(f"{YELLOW}Cards available :")

liste = os.system("bash init.sh")

with open(r"cartes.conf", 'r') as fp:
    # lines to read
    line_numbers = [0]
    # To store lines
    lines = []
    for i, line in enumerate(fp):
        # read line 4 and 7
        if i in line_numbers:
            lines.append(line.strip())
        elif i > 7:
            # don't read after line 7 to save time
            break
lines=str(lines)
print(lines)
with open('carte1.txt', 'w+') as f:
    f.write(lines)

infilecanal = "carte1.txt"
outfilecanal = "c1.txt"
delete_list = ["[", "'", "]"]
with open(infilecanal) as fin, open(outfilecanal, "w+") as fout:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        fout.write(line)

with open(r"cartes.conf", 'r') as fp:
    # lines to read
    line_numbers = [1]
    # To store lines
    lines = []
    for i, line in enumerate(fp):
        # read line 4 and 7
        if i in line_numbers:
            lines.append(line.strip())
        elif i > 7:
            # don't read after line 7 to save time
            break
lines=str(lines)
print(lines)
with open('carte2.txt', 'w+') as f:
    f.write(lines)

infilecanal = "carte2.txt"
outfilecanal = "c2.txt"
delete_list = ["[", "'", "]"]
with open(infilecanal) as fin, open(outfilecanal, "w+") as fout:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        fout.write(line)

with open(r"cartes.conf", 'r') as fp:
    # lines to read
    line_numbers = [2]
    # To store lines
    lines = []
    for i, line in enumerate(fp):
        # read line 4 and 7
        if i in line_numbers:
            lines.append(line.strip())
        elif i > 7:
            # don't read after line 7 to save time
            break
lines=str(lines)
print(lines)
with open('carte3.txt', 'w+') as f:
    f.write(lines)

infilecanal = "carte3.txt"
outfilecanal = "c3.txt"
delete_list = ["[", "'", "]"]
with open(infilecanal) as fin, open(outfilecanal, "w+") as fout:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        fout.write(line)

os.system("rm -rf carte*.txt")

ssid = os.system("iw dev | grep -Po '^\sInterface\s\K.*$' | xargs -I {} iw dev {} link | grep -Po '^\sSSID:\s\K.*$' > /tmp/ssid")
print(f"{GREEN}If domestic mode is choose hostbase will not attack this network :")
print(open('/tmp/ssid', 'r').read())
print(f"{CYAN}Checking wifi cards compatibilities...")


with open(r"interfaces.txt", 'r') as fp:
    for count, line in enumerate(fp):
        pass
print(count)



findString = "AP/VLAN"

with open('interfaces.txt') as f:
    lines = f.readlines()
    for line_num, line_context in enumerate(lines):
        if findString in line_context:
            print(f'{line_num+1}')


if line_num > 21:
    print('Three wifi cards detected')
    c = 3
    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[2:10]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("Third wifi card is supported by hostapd")
            htrois = 1
        else:
            print("Third wifi card is NOT supported by hostapd")
            htrois = 0

    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[10:19]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("Second wifi card is supported by hostapd")
            hdeux = 1
        else:
            print("Second wifi card is NOT supported by hostapd")
            hdeux = 0

    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[20:29]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("First wifi card is supported by hostapd")
            hun = 1
        else:
            print("First wifi card is NOT supported by hostapd")
            hun = 0

elif line_num > 10:
    print('Two wifi cards detected')
    c = 2
    os.system('rm -rf c3.txt')
    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[2:10]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("Second wifi card is supported by hostapd")
            hdeux = 1
        else:
            print("Second wifi card is NOT supported by hostapd")
            hdeux = 0

    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[10:19]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("First wifi card is supported by hostapd")
            hun = 1
        else:
            print("First wifi card is NOT supported by hostapd")
            hun = 0



else:
    print(f"{RED}Please insert other wifi card ! this script need two at least")
    os.system("rm -rf *.txt")
    os.system("killall python")
    sys.exit(0)
    # fonction retour menu

frequn = 0
freqdeux = 0
freqtrois = 0
print(f"{BLUE}Checking 5GHz compatibilies...")
if c == 2:
    print('')
    with open('c1.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('First card support 5GHz')
             frequn = 1
            else:
             print("First card doesn't support 5GHz")
             frequn = 0

    with open('c2.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('Second card support 5GHz')
             freqdeux = 1
            else:
             print("Second card doesn't support 5GHz")
             freqdeux = 0
else:
    print('')
    with open('c1.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('First card support 5GHz')
             frequn = 1
            else:
             print("First card doesn't support 5GHz")
             frequn = 0

    with open('c2.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('Second card support 5GHz')
             freqdeux = 1
            else:
             print("Second card doesn't support 5GHz")
             freqdeux = 0

    with open('c3.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('Third card support 5GHz')
             freqtrois = 1
            else:
             print("Third card doesn't support 5GHz")
             freqtrois = 0


occupun = 0
occupdeux = 0
occuptrois = 0

if hun == 1:
    os.system('mv c1.txt hostapdcarte')
    occupun = 2
elif hdeux == 1:
    os.system('mv c2.txt hostapdcarte')
    occupdeux = 2
elif htrois == 1:
    os.system('mv c3.txt hostapdcarte')
    occuptrois = 2
else:
    print(f"{RED}ERROR : if your wifi cards are NOT supported by hostapd you can not use this script ! aborting...")
    os.system("rm -rf *.txt")
    os.system("killall python3")
    sys.exit(0)
    # exit du script à placer


# Si il y a trois cartes...
if occupun == 0 and frequn == 1:
    os.system('mv c1.txt cinqgcarte')
    print(f"{MAGENTA}First card will be use on 5GHz frequency")
elif occupdeux == 0 and freqdeux == 1:
    os.system('mv c2.txt cinqgcarte')
    print(f"{MAGENTA}Second card will be use on 5GHz frequency")
elif occuptrois == 0 and freqtrois == 1:
    os.system('mv c3.txt cinqgcarte')
    print(f"{MAGENTA}Third card will be use on 5GHz frequency")
else:
    print(f"{YELLOW}No 5GHz support for your cards or they are already busy, attack will be configured on 2.4GHz")
    os.system("touch no5ghzconfig.txt")


if os.path.isfile('c1.txt'):
   print(f"{CYAN}First card will be us to deauth the 2.4GHz frequency")
   os.system('mv c1.txt deuxgcarte')
elif os.path.isfile('c2.txt'):
   print(f"{CYAN}Second card will be us to deauth the 2.4GHz frequency")
   os.system('mv c2.txt deuxgcarte')
elif os.path.isfile('c3.txt'):
   print(f"{CYAN}Third card will be us to deauth the 2.4GHz frequency")
   os.system('mv c3.txt deuxgcarte')
else:
    print(f"{RED}'ERROR : while finding the card to deauth 2.4GHz frequency")


print(f"{RESET}Welcome to...")
print("\n")
print("╻ ╻┏━┓┏━┓╺┳╸┏┓ ┏━┓┏━┓┏━╸")
print("┣━┫┃ ┃┗━┓ ┃ ┣┻┓┣━┫┗━┓┣╸ ")
print("╹ ╹┗━┛┗━┛ ╹ ┗━┛╹ ╹┗━┛┗━╸")
print("\n")
print(f"{CYAN}Full automated rogue AP script created by Koala")
print(f"{YELLOW}Remember : this script work with two wifi cards at least")
print(f"{MAGENTA}NOTE : by default the wps flag is set to 1 in page file, change to 0 for wpa3 page")
print(f"{GREEN}--- > You must leave the script by ctrl+c when it run")
print(f"{RESET}The wifi is something invisible... let's make it visible with a fake AP ! ...")
print(f'''{CYAN}------------
Main Menu
------------''')
print(f"{MAGENTA}Let Hostbase choose for you... or attack directly a network entering his name")
print(f"{RESET} ")
one = '1 Domestic mode : will not attack current connected network but the other nearest networks'
two = '2 Savage mode : will attack all networks including your network if some traffic is detected'
three = '3 Attack network by name'
four = '4 Exit/Quit'
print(one)
print(two)
print(three)
print(four)

choice = input('enter your choice (1,2,3 or 4) : ')

if choice == '1':
    print('Domestic mode has been selected')
    os.system("touch domesticmode")
    scan = subprocess.Popen("python3 scan.py", shell=True)
elif choice == '2':
    print('Savage mode has been selected')
    scan = subprocess.Popen("python3 scan.py", shell=True)
elif choice == '3':
    print('---> Network name')
    user_input = input('Enter the name : ')
    user_list = []
    user_list.append(user_input)
    with open('ssid.txt', 'a') as file:
        for item in user_list:
            file.write(item + '\n')
    name = subprocess.Popen("python3 nom.py", shell=True)
elif choice == '4':
    print('Bye...')
    os.system("rm -rf *carte")
    os.system("rm -rf *.conf")
    os.system("rm -rf *.txt")
    os.system("killall python3")
    sys.exit(0)
elif choice !="":
    print("\n Not valid choice... leaving !")
    os.system("rm -rf *carte")
    os.system("rm -rf *.conf")
    os.system("rm -rf *.txt")
    os.system("killall python3")
    sys.exit(0)































