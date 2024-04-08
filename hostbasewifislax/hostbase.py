import os
import time
import subprocess
import signal
from signal import SIGINT, SIGTERM, sigwait
from signal import signal, SIGINT
import sys
from sys import exit

GREEN = "\033[32m"
RED = "\033[31m"
RESET = "\033[0m"

# Script working with python >= 3.10

def handler(signal_received, frame):
      print('Quitando Hostbase...')
      print("Limpieza de los ficheros...")
      leave = subprocess.Popen("python exit.py", shell=True)
      exit(0)

lemenu = subprocess.Popen("python menu.py", shell=True)


if __name__ == '__main__':
    # Tell Python to run the handler() function when SIGINT is recieved
    signal(SIGINT, handler)

    print('Press ctrl+c una vez para quitar cuando el script anda...')
    while True:
        # Do nothing and hog CPU forever until SIGINT received.
        pass



