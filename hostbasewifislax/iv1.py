import os
import sys
import time
import csv
import subprocess

YELLOW = "\033[33m"
RED = "\033[31m"
GREEN = "\033[32m"
BLUE = "\033[34m"
CYAN = "\033[36m"
MAGENTA = "\033[35m"
RESET = "\033[0m"

# 2.4GHz, 5GHz filtre par l'IV

def suite():
    print(f"{RESET}Eligiendo las prioridades...")
    sa = subprocess.Popen("bash iv9.sh", shell=True)
    sys.exit()

def net3():

    print(f"{CYAN}Analysando los datos de la red (3/3)...")

    with open('iv3.txt') as filetrois:
        ivtrois = filetrois.readline()

    ivtrois = int(ivtrois)

    if 0 <= ivtrois <= 1:
        print(f"{CYAN}No trafico on esta red !")
        with open('priority.txt', 'a') as f1:
            f1.write('1')
            f1.write('\n')
            os.system("python iv9.py")
            sys.exit()
    elif 1 <= ivtrois <= 10:
        print(f"{CYAN}Un poco de trafico en esta red !")
        with open('priority.txt', 'a') as f2:
            f2.write('2')
            f2.write('\n')
            os.system("python iv9.py")
            sys.exit()
    elif 10 <= ivtrois <= 20:
        print(f"{CYAN}No mucho trafico en esta red !")
        with open('priority.txt', 'a') as f3:
            f3.write('3')
            f3.write('\n')
            os.system("python iv9.py")
            sys.exit()
    elif 20 <= ivtrois <= 40:
        print(f"{CYAN}Medio trafico en esta red !")
        with open('priority.txt', 'a') as f4:
            f4.write('4')
            f4.write('\n')
            os.system("python iv9.py")
            sys.exit()
    elif 40 <= ivtrois <= 70:
        print(f"{CYAN}Buen trafico en esta red !")
        with open('priority.txt', 'a') as f5:
            f5.write('5')
            f5.write('\n')
            os.system("python iv9.py")
            sys.exit()
    elif 70 <= ivtrois <= 200:
        print(f"{CYAN}Mucho trafico on esta red !")
        with open('priority.txt', 'a') as f6:
            f6.write('6')
            f6.write('\n')
            os.system("python iv9.py")
            sys.exit()

    else:
        print(f"{CYAN}Mucho mucho trafico en esta red, atacando le ahora !")
        line = open("identfinal.csv", "r").readlines()[2]
        f = open(f'finalchoice.csv', 'w+')
        f.write(line)
        f.close()
        directident = subprocess.Popen("python direct.py", shell=True)
        sys.exit()



def net2():
    print(f"{MAGENTA}Analysando los datos de la red (2/3)...")

    with open('iv2.txt') as filedeux:
        ivdeux = filedeux.readline()

    ivdeux = int(ivdeux)

    if 0 <= ivdeux <= 1:
        print(f"{MAGENTA}No trafico on esta red !")
        with open('priority.txt', 'a') as f1:
            f1.write('1')
            f1.write('\n')
        net3()
    elif 1 <= ivdeux <= 10:
        print(f"{MAGENTA}Un poco de trafico en esta red !")
        with open('priority.txt', 'a') as f2:
            f2.write('2')
            f2.write('\n')
        net3()
    elif 10 <= ivdeux <= 20:
        print(f"{MAGENTA}No mucho trafico en esta red !")
        with open('priority.txt', 'a') as f3:
            f3.write('3')
            f3.write('\n')
        net3()
    elif 20 <= ivdeux <= 40:
        print(f"{MAGENTA}Medio trafico en esta red !")
        with open('priority.txt', 'a') as f4:
            f4.write('4')
            f4.write('\n')
        net3()
    elif 40 <= ivdeux <= 70:
        print(f"{MAGENTA}Buen trafico en esta red !")
        with open('priority.txt', 'a') as f5:
            f5.write('5')
            f5.write('\n')
        net3()
    elif 70 <= ivdeux <= 200:
        print(f"{MAGENTA}Heavy traffic found on the network!")
        with open('priority.txt', 'a') as f6:
            f6.write('6')
            f6.write('\n')
        net3()

    else:
        print(f"{MAGENTA}Mucho mucho trafico en esta red, atacando le ahora !")
        line = open("identfinal.csv", "r").readlines()[1]
        f = open(f'finalchoice.csv', 'w+')
        f.write(line)
        f.close()
        directident = subprocess.Popen("python direct.py", shell=True)
        sys.exit()
def net1():


    with open('iv1.txt') as fileun:
        ivun = fileun.readline()

    ivun=int(ivun)


    if 0 <= ivun <= 1:
        print(f"{BLUE}No trafico on esta red !")
        with open('priority.txt', 'a') as f1:
            f1.write('1')
            f1.write('\n')
        net2()
    elif 1 <= ivun <= 10:
        print(f"{BLUE}Un poco de trafico en esta red !")
        with open('priority.txt', 'a') as f2:
            f2.write('2')
            f2.write('\n')
        net2()
    elif 10 <= ivun <= 20:
        print(f"{BLUE}No mucho trafico en esta red !")
        with open('priority.txt', 'a') as f3:
            f3.write('3')
            f3.write('\n')
        net2()
    elif 20 <= ivun <= 40:
        print(f"{BLUE}Medio trafico en esta red !")
        with open('priority.txt', 'a') as f4:
            f4.write('4')
            f4.write('\n')
        net2()
    elif 40 <= ivun <= 70:
        print(f"{BLUE}Buen trafico en esta red !")
        with open('priority.txt', 'a') as f5:
            f5.write('5')
            f5.write('\n')
        net2()
    elif 70 <= ivun <= 200:
        print(f"{BLUE}Mucho trafico on esta red !")
        with open('priority.txt', 'a') as f6:
            f6.write('6')
            f6.write('\n')
        net2()

    else:
        print(f"{BLUE}Mucho mucho trafico en esta red, atacando le ahora !")
        with open('identfinal.csv') as f:
            line = f.readline()
            f = open(f'finalchoice.csv', 'w+')
            f.write(line)
            f.close()
            directident = subprocess.Popen("python direct.py", shell=True)
            sys.exit()


def net():
        print(f"{BLUE}Analysando los datos de la red (1/3)...")
        net1()

net()
