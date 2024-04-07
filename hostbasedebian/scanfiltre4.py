import os
import sys
import subprocess

infilecanal = "channel.txt"
outfilecanal = "channelbase.txt"
infilessid = "essid.txt"
outfilessid = "essidbase.txt"
infilepw = "power.txt"
outfilepw = "powerbase.txt"
infileiv = "iv.txt"
outfileiv = "ivbase.txt"


delete_list = ["channel", "P", "ower", "-", ".0", " "]
with open(infilecanal) as fin, open(outfilecanal, "w+") as fout:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        fout.write(line)
os.system("awk 'NF' channel.txt > channell.txt")
os.system("rm -rf channel.txt")
os.system("mv channell.txt channel.txt")

delete_list = [".0", " "]
with open(infilessid) as fin, open(outfilessid, "w+") as foutbis:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        foutbis.write(line)

delete_list = ["Power", "-1"]
with open(infilepw) as fin, open(outfilepw, "w+") as pw:
    for line in fin:
        for word in delete_list:
            line = line.replace(word, "")
        pw.write(line)

with open('power.txt') as reader, open('power.txt', 'r+') as writer:
  for line in reader:
    if line.strip():
      writer.write(line)
  writer.truncate()

delete_list = [" ", "#", "IV"]
with open(infileiv) as fin, open(outfileiv, "w+") as iv:
        for line in fin:
            for word in delete_list:
                line = line.replace(word, "")
            iv.write(line)

with open('ivbase.txt', 'r+') as f:
    txt = f.read().replace(' ', '')
    f.seek(0)
    f.write(txt)
    f.truncate()

os.system("sed -i -e 's/\(ESSID\|StationMAC\)//g' essid.txt")
os.system("awk 'NF' essid.txt > essidd.txt")
os.system("rm -rf essid.txt")
os.system("mv essidd.txt essid.txt")

os.system("sed -i -e 's/\(BSSID\|StationMAC\)//g' bssid.txt")
os.system("awk 'NF' bssid.txt > bssidd.txt")
os.system("rm -rf bssid.txt")
os.system("mv bssidd.txt bssid.txt")

os.system("rm -rf essidbase.txt")

analysedeux = subprocess.Popen("python3 comparaison10.py", shell=True)