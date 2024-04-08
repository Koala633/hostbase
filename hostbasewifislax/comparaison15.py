import os
import re
import csv
import sys
import subprocess
import time

os.system("head -c-1 troisignaux.txt > temp.txt; mv temp.txt troisignaux.txt")
with open("troisignaux.txt", 'r') as file:
    data = [line.strip() for line in file if line.strip() != '']

for i, number in enumerate(data):
    found = False
    with open('midvalues1.csv', 'r') as file:
        csv_reader = csv.reader(file)
        for row in csv_reader:
            if any(number in cell for cell in row):
                line = ','.join(row)
                print(line)
                print(f'Found {number}!')
                f = open(f'ident{i+1}.txt', 'w+')
                f.write(line)
                f.close()
                found = True
                break

    if not found:
        print('Data not found!')

analysequatre = subprocess.Popen("python iv2.py", shell=True)