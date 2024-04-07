import os
import subprocess
import time
import sys
import signal

def checkwash():
    # os.system("killall wash") a voir mais OK enlève bien wash
    with open('deuxgcarte') as f:
        deuxg = f.read()
    with open("bssid.txt", "r") as bs:
        bssid = bs.read()
    washdeux = subprocess.Popen("wash -i" + " " + deuxg + " " + "-b" + " " + bssid + " " + "-j" + " " + "-F" + " " + "> wash.txt", shell=True)
    try:
        washdeux.wait(timeout=20)
    except subprocess.TimeoutExpired:
        washdeux.terminate()
        washdeux.send_signal(subprocess.signal.SIGTERM)

        os.system("killall wash")


with open('deuxgcarte') as f:
    deuxg = f.read()
with open("bssid.txt", "r") as bs:
    bssid = bs.read()


washun = subprocess.Popen("wash -i" + " " + deuxg + " " + "-b" + " " + bssid + " " + "-j" + " " + "-F" + " " + "> wash.txt", shell=True)
try:
    washun.wait(timeout=20)
except subprocess.TimeoutExpired:
    washun.terminate()
    washun.send_signal(subprocess.signal.SIGTERM)


os.system("killall wash")


starttime = time.monotonic()
while True:
  time.sleep(1.0 - ((time.monotonic() - starttime) % 1.0))
  checkwash()