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
    print(f"{RESET}Setting up priorities...")
    sa = subprocess.Popen("bash iv9.sh", shell=True)
    sys.exit()

def net3():

    print(f"{CYAN}Analyzing networks traffic from the 3/3 networks selected...")

    with open('iv3.txt') as filetrois:
        ivtrois = filetrois.readline()

    ivtrois = int(ivtrois)

    if 0 <= ivtrois <= 1:
        print(f"{CYAN}No traffic found on the network !")
        with open('priority.txt', 'a') as f1:
            f1.write('1')
            f1.write('\n')
            os.system("python3 iv9.py")
            sys.exit()
    elif 1 <= ivtrois <= 10:
        print(f"{CYAN}Very few traffic found on the network !")
        with open('priority.txt', 'a') as f2:
            f2.write('2')
            f2.write('\n')
            os.system("python3 iv9.py")
            sys.exit()
    elif 10 <= ivtrois <= 20:
        print(f"{CYAN}Few traffic found on the network !")
        with open('priority.txt', 'a') as f3:
            f3.write('3')
            f3.write('\n')
            os.system("python3 iv9.py")
            sys.exit()
    elif 20 <= ivtrois <= 40:
        print(f"{CYAN}Medium traffic found on the network !")
        with open('priority.txt', 'a') as f4:
            f4.write('4')
            f4.write('\n')
            os.system("python3 iv9.py")
            sys.exit()
    elif 40 <= ivtrois <= 70:
        print(f"{CYAN}High fraffic found on the network !")
        with open('priority.txt', 'a') as f5:
            f5.write('5')
            f5.write('\n')
            os.system("python3 iv9.py")
            sys.exit()
    elif 70 <= ivtrois <= 200:
        print(f"{CYAN}Heavy traffic found on the network!")
        with open('priority.txt', 'a') as f6:
            f6.write('6')
            f6.write('\n')
            os.system("python3 iv9.py")
            sys.exit()

    else:
        print(f"{CYAN}This network has very heavy traffic go for it now!")
        line = open("identfinal.csv", "r").readlines()[2]
        f = open(f'finalchoice.csv', 'w+')
        f.write(line)
        f.close()
        directident = subprocess.Popen("python3 direct.py", shell=True)
        sys.exit()



def net2():
    print(f"{MAGENTA}Analyzing networks traffic from the 2/3 network selected...")

    with open('iv2.txt') as filedeux:
        ivdeux = filedeux.readline()

    ivdeux = int(ivdeux)

    if 0 <= ivdeux <= 1:
        print(f"{MAGENTA}No traffic found on the network !")
        with open('priority.txt', 'a') as f1:
            f1.write('1')
            f1.write('\n')
        net3()
    elif 1 <= ivdeux <= 10:
        print(f"{MAGENTA}Very few traffic found on the network !")
        with open('priority.txt', 'a') as f2:
            f2.write('2')
            f2.write('\n')
        net3()
    elif 10 <= ivdeux <= 20:
        print(f"{MAGENTA}Few traffic found on the network !")
        with open('priority.txt', 'a') as f3:
            f3.write('3')
            f3.write('\n')
        net3()
    elif 20 <= ivdeux <= 40:
        print(f"{MAGENTA}Medium traffic found on the network !")
        with open('priority.txt', 'a') as f4:
            f4.write('4')
            f4.write('\n')
        net3()
    elif 40 <= ivdeux <= 70:
        print(f"{MAGENTA}High fraffic found on the network !")
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
        print(f"{MAGENTA}This network has very heavy traffic go for it now!")
        line = open("identfinal.csv", "r").readlines()[1]
        f = open(f'finalchoice.csv', 'w+')
        f.write(line)
        f.close()
        directident = subprocess.Popen("python3 direct.py", shell=True)
        sys.exit()
def net1():


    with open('iv1.txt') as fileun:
        ivun = fileun.readline()

    ivun=int(ivun)


    if 0 <= ivun <= 1:
        print(f"{BLUE}No traffic found on the network !")
        with open('priority.txt', 'a') as f1:
            f1.write('1')
            f1.write('\n')
        net2()
    elif 1 <= ivun <= 10:
        print(f"{BLUE}Very few traffic found on the network !")
        with open('priority.txt', 'a') as f2:
            f2.write('2')
            f2.write('\n')
        net2()
    elif 10 <= ivun <= 20:
        print(f"{BLUE}Few traffic found on the network !")
        with open('priority.txt', 'a') as f3:
            f3.write('3')
            f3.write('\n')
        net2()
    elif 20 <= ivun <= 40:
        print(f"{BLUE}Medium fraffic found on the network !")
        with open('priority.txt', 'a') as f4:
            f4.write('4')
            f4.write('\n')
        net2()
    elif 40 <= ivun <= 70:
        print(f"{BLUE}High fraffic found on the network !")
        with open('priority.txt', 'a') as f5:
            f5.write('5')
            f5.write('\n')
        net2()
    elif 70 <= ivun <= 200:
        print(f"{BLUE}Heavy traffic found on the network!")
        with open('priority.txt', 'a') as f6:
            f6.write('6')
            f6.write('\n')
        net2()

    else:
        print(f"{BLUE}This network has very heavy traffic go for it now!")
        with open('identfinal.csv') as f:
            line = f.readline()
            f = open(f'finalchoice.csv', 'w+')
            f.write(line)
            f.close()
            directident = subprocess.Popen("python3 direct.py", shell=True)
            sys.exit()


def net():
        print(f"{BLUE}Analyzing networks traffic from the 1/3 networks selected...")
        net1()

net()
