import os
import itertools
import signal
from signal import SIGINT, SIGTERM, sigwait
from signal import signal, SIGINT
import sys
from sys import exit
import subprocess
import pandas

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

print(f"{YELLOW}Tarjetas wifi :")

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
print(f"{GREEN}Si el modo domestico esta eligido Hostbase no atacara esta red :")
print(open('/tmp/ssid', 'r').read())
print(f"{CYAN}Verificando compatibilidad de las tarjetas wifi...")


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
    print('Tres tarjetas detectado')
    c = 3
    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[2:10]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("La tercera tarjeta es compatible con hostapd")
            htrois = 1
        else:
            print("La tercera tarjeta no es compatible con hostapd")
            htrois = 0

    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[10:19]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("La segunda tarjeta es compatible con hostapd")
            hdeux = 1
        else:
            print("La segunda tarjeta no es compatible con hostapd")
            hdeux = 0

    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[20:29]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("La primera tarjeta es compatible con hostapd")
            hun = 1
        else:
            print("La primera tarjeta no es compatible con hostapd")
            hun = 0

elif line_num > 10:
    print('Dos tarjetas wifi detectado')
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
            print("La segunda tarjeta es compatible con hostapd")
            hdeux = 1
        else:
            print("La segunda tarjeta no es compatible con hostapd")
            hdeux = 0

    file = open('interfaces.txt')
    all_lines = file.readlines()
    all_lines = all_lines[10:19]
    all_lines = str(all_lines)
    with open('interfaces1.txt', 'w+') as ft:
        ft.write(all_lines)

    with open('interfaces1.txt') as f:
        if findString in f.read():
            print("La primera tarjeta es compatible con hostapd")
            hun = 1
        else:
            print("La primera tarjeta no es compatible con hostapd")
            hun = 0



else:
    print(f"{RED}Por favor inserta otra tarjeta wifi ! Hostbase necesita por lo menos dos !")
    os.system("rm -rf *.txt")
    print(f"{RESET}.")
    os.system("killall python")
    sys.exit(0)
    # fonction retour menu

frequn = 0
freqdeux = 0
freqtrois = 0
print(f"{BLUE}Verificando compatibilidad en 5GHz...")
if c == 2:
    print('')
    with open('c1.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('La primera tarjeta soporta 5GHz')
             frequn = 1
            else:
             print("La primera tarjeta no soporta 5GHz")
             frequn = 0

    with open('c2.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('La segunda tarjeta soporta 5GHz')
             freqdeux = 1
            else:
             print("La segunda tarjeta no soporta 5GHz")
             freqdeux = 0
else:
    print('')
    with open('c1.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('La primera tarjeta soporta 5GHz')
             frequn = 1
            else:
             print("La primera tarjeta no soporta 5GHz")
             frequn = 0

    with open('c2.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('La segunda tarjeta soporta 5GHz')
             freqdeux = 1
            else:
             print("La segunda tarjeta no soporta 5GHz")
             freqdeux = 0

    with open('c3.txt') as f:
        un = f.readline()
        ghz = os.system("iwlist" + " " + un + " " + "freq > freq.txt")
        with open('freq.txt') as myfile:
            if 'Channel 100' in myfile.read():
             print('La tercera tarjeta soporta 5GHz')
             freqtrois = 1
            else:
             print("La tercera tarjeta no soporta 5GHz")
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
    print(f"{RED}ERROR : si tu tarjetas wifi no soporta hostapd no puedes usar Hostbase ! quitando...")
    os.system("rm -rf *.txt")
    os.system("killall python")
    sys.exit(0)
    # exit du script à placer


# Si il y a trois cartes...
if occupun == 0 and frequn == 1:
    os.system('mv c1.txt cinqgcarte')
    print(f"{MAGENTA}La primera tarjeta va a estar usando el 5GHz")
elif occupdeux == 0 and freqdeux == 1:
    os.system('mv c2.txt cinqgcarte')
    print(f"{MAGENTA}La segunda tarjeta va a estar usando el 5GHz")
elif occuptrois == 0 and freqtrois == 1:
    os.system('mv c3.txt cinqgcarte')
    print(f"{MAGENTA}La tercera tarjeta va a estar usando el 5GHz")
else:
    print(f"{YELLOW}No hay soporte en 5GHz, el ataque estara configurado en 2.4GHz")
    os.system("touch no5ghzconfig.txt")


if os.path.isfile('c1.txt'):
   print(f"{CYAN}La primera tarjeta va a estar usando el 2.4GHz")
   os.system('mv c1.txt deuxgcarte')
elif os.path.isfile('c2.txt'):
   print(f"{CYAN}La segunda tarjeta va a estar usando el 2.4GHz")
   os.system('mv c2.txt deuxgcarte')
elif os.path.isfile('c3.txt'):
   print(f"{CYAN}La tercera tarjeta va a estar usando el 2.4GHz")
   os.system('mv c3.txt deuxgcarte')
else:
    print(f"{RED}'ERROR : buscando la tarjeta a usar por el 2.4GHz")
    os.system('mv cinqgcarte deuxgcarte')
    print(f"{YELLOW}La tarjeta en 5GHz va estar usado en 2.4GHz")


print(f"{RESET}Welcome to...")
print("\n")
print("╻ ╻┏━┓┏━┓╺┳╸┏┓ ┏━┓┏━┓┏━╸")
print("┣━┫┃ ┃┗━┓ ┃ ┣┻┓┣━┫┗━┓┣╸ ")
print("╹ ╹┗━┛┗━┛ ╹ ┗━┛╹ ╹┗━┛┗━╸")
print("\n")
print(f"{CYAN}Script automatico de rogue AP creado por Koala")
print(f"{YELLOW}Recuerdo : este script anda con dos tarjetas wifi por lo menos")
print(f"{MAGENTA}NOTA : Hostbase esta configurado en modo WPS, si quieres el modo WPA cambia 1 a 0 en el fichero : pagina")
print(f"{GREEN}--- > Se tiene que salir del script con ctrl+c")
print(f'''{CYAN}------------
Main Menu
------------''')
print(f"{MAGENTA}Dejar Hostbase eligir... o entrar el nombre de la red a atacar")
print(f"{RESET} ")
one = '1 Modo domestic : este ataque borra su red de la lista'
two = '2 Modo salvaje : este ataque no borra su red de la lista'
three = '3 Atacando la red por su nombre'
four = '4 Exit/Quitar'
print(one)
print(two)
print(three)
print(four)

choice = input('Elegir (1,2,3 or 4) : ')

if choice == '1':
    print('Modo domestic elegido')
    os.system("touch domesticmode")
    scan = subprocess.Popen("python scan.py", shell=True)
elif choice == '2':
    print('Modo salvaje elegido')
    scan = subprocess.Popen("python scan.py", shell=True)
elif choice == '3':
    print('---> Nombre de la red')
    user_input = input('Entra el nombre : ')
    user_list = []
    user_list.append(user_input)
    with open('ssid.txt', 'a') as file:
        for item in user_list:
            file.write(item + '\n')
    name = subprocess.Popen("python nom.py", shell=True)
elif choice == '4':
    print('Bye...')
    os.system("rm -rf *carte")
    os.system("rm -rf *.conf")
    os.system("rm -rf *.txt")
    os.system("killall python")
    sys.exit(0)
elif choice !="":
    print("\n Usted no ha elegido correctamente, quitando !")
    os.system("rm -rf *carte")
    os.system("rm -rf *.conf")
    os.system("rm -rf *.txt")
    os.system("killall python")
    sys.exit(0)































