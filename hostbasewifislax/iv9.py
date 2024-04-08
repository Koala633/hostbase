import os
import sys
import subprocess



YELLOW = "\033[33m"
GREEN = "\033[32m"
RESET = "\033[0m"
MAGENTA = "\033[35m"
RED = "\033[31m"
p =''
prioegal=''



def check():
    print(f"{RESET}Analysando...")
    if p == '2':
       print("Mirando la mejor posibiliad...")
       bashiv = subprocess.Popen("bash iv.sh", shell=True)
    else:
       print("Mirando la mejor posibiliad")
       bashiv = subprocess.Popen("bash iv.sh", shell=True)

def prep():
    print(f"{RESET}Preparando la analysss del trafico...")
    bashiv = subprocess.Popen("bash iv.sh", shell=True)



def main():
  print(f"{YELLOW}Analysando el orderen...")
  global p
  global prioegal
with open('priority.txt') as f:
    prioegal = f.read()
    if '7' in prioegal:
        print(f"{YELLOW}Nivel de prioridad : 7")
        prioegal = '7'
    elif '6' in prioegal:
        print(f"{YELLOW}Nivel de prioridad : 6")
        prioegal = '6'
    elif '5' in prioegal:
        print(f"{YELLOW}Nivel de prioridad : 5")
        prioegal = '5'
    elif '4' in prioegal:
        print(f"{YELLOW}Nivel de prioridad : 4")
        prioegal = '4'
    elif '3' in prioegal:
        print(f"{YELLOW}Nivel de prioridad : 3")
        prioegal = '3'
    elif '2' in prioegal:
        print(f"{YELLOW}Nivel de prioridad : 2")
        prioegal = '2'
    elif '1' in prioegal:
        print(f"{YELLOW}Nivel de prioridad : 1")
        prioegal = '1'
    print(f"{RESET}Verificando las mismas prioridades...")
    with open("priority.txt", "r") as g:
        priodoublons = g.read()
    for w in prioegal:
        if priodoublons.count(w) > 2:
            print(f"{MAGENTA}3 Prioridad similar encontrado")
            # Vérif lequel des 3 réseaux a le meilleur power
            p = '3'
            check()
        elif priodoublons.count(w) > 1:
            print(f"{MAGENTA}2 Prioridad similar encontrado")
            # Vérif lequel des 2 réseaux a le meilleur power
            p = '2'
            check()
        elif priodoublons.count(w) == 1:
            print(f"{GREEN}Orderen de proridad correcto")
            # Ok
            prep()
            # Appel de la fonction ou script suivante pour localiser le réseau et passer à l'attaque
        else:
            print(f"{RED}Error mientras la verificacion de las prioridades")

