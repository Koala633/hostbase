#!/bin/bash

sed 's|["]||g' key.txt > cle.txt
carteconnexion="$(cat hostapdcarte)"
# pass="$(cat key.txt)"
pass=$(head -n 1 cle.txt)
ESSID="$(cat ssid)"
echo "$carteconnexion"
while [ -z "${carteconnexion}" ]; do read -r ${carteconnexion}; done



echo "$pass"
while [ -z "${pass}" ]; do read -r ${pass}; done

echo "$ESSID"
while [ -z "${ESSID}" ]; do read -r ${ESSID}; done

#nmcli --fields UUID,TIMESTAMP-REAL con show | grep never |  awk '{print $1}' | while read line; do nmcli con delete uuid  $line;    done
sudo nmcli device wifi rescan ifname ${carteconnexion} ssid ${ESSID}
sleep 3;
sudo nmcli dev wifi connect ${ESSID} password ""${pass}""
sleep 8;
echo -e "All task are done... bye..."
rm -rf *.txt
killall python
exit 0
