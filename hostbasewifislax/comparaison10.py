


import os
import re
import time
import subprocess

# file = open('power1.txt', 'r')

os.system("awk 'NF' powerbase.txt > powerbasee.txt")
os.system("rm -rf powerbase.txt")
os.system("mv powerbasee.txt powerbase.txt")

with open("powerbase.txt", "r") as t:
 lst = t.readlines()
b = list()
for i in range(len(lst)):
    b.append(lst[i])
    while i>0 and b[i]<b[i-1]:
        b[i], b[i-1] = b[i-1], b[i]
        i-= 1
with open('troisignaux.txt', 'w+') as myfile:
    myfile.write('\n'.join(map(str, (b[:3]))))
print(b)

os.system("awk 'NF' troisignaux.txt > troistemp.txt")
os.system("rm -rf troisignaux.txt")
os.system("mv troistemp.txt troisignaux.txt")
analysetrois = subprocess.Popen("python comparaison15.py", shell=True)