#!/bin/bash
rm -rf iv.txt
rm -rf ivbase.txt
rm -rf *temp.txt
out=troisiv.txt
rm -f "$out"
for f in iv*.txt
do
    cat "$f" >> "$out"
    echo >> "$out"
done
python3 iv16.py
