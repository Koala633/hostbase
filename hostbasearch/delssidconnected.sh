#!/bin/bash

f_deldeuxg(){
if [ -f "domesticmode" ]; then
ssid="$(cat /tmp/ssid)"

free="FreeWifi_secure"
edu="eduroam"
imprimante="DIRECT"

echo "$ssid"
while [ -z "${ssid}" ]; do read -r ${ssid}; done

echo "$free"
while [ -z "${free}" ]; do read -r ${free}; done

echo "$edu"
while [ -z "${edu}" ]; do read -r ${edu}; done

echo "$imprimante"
while [ -z "${imprimante}" ]; do read -r ${imprimante}; done


# sed -i /${ssid}/d airodumpwpa-01.csv
# sed -i /${free}/d airodumpwpa-01.csv
# sed -i /${edu}/d airodumpwpa-01.csv
sed -i /${ssid}/d midvalues.csv  # Application du filtrage sur les réseaux en configuration EAP entreprise non utiles pour la sélection finale.
sed -i /${free}/d midvalues.csv
sed -i /${edu}/d midvalues.csv
sed -i /${imprimante}/d midvalues.csv
else
free="FreeWifi_secure"
edu="eduroam"
imprimante="DIRECT"

echo "$free"
while [ -z "${free}" ]; do read -r ${free}; done

echo "$edu"
while [ -z "${edu}" ]; do read -r ${edu}; done

echo "$imprimante"
while [ -z "${imprimante}" ]; do read -r ${imprimante}; done

# sed -i /${free}/d airodumpwpa-01.csv
# sed -i /${edu}/d airodumpwpa-01.csv
sed -i /${free}/d midvalues.csv
sed -i /${edu}/d midvalues.csv
sed -i /${imprimante}/d midvalues.csv
fi
exit 0
}

################ 5G : si domestic mode remove du réseau
f_delcinqg(){
ssid="$(cat /tmp/ssid)"
bssid="$(cat bssid.txt)"

free="FreeWifi_secure"
edu="eduroam"

echo "$ssid"
while [ -z "${ssid}" ]; do read -r ${ssid}; done

echo "$free"
while [ -z "${free}" ]; do read -r ${free}; done

echo "$edu"
while [ -z "${edu}" ]; do read -r ${edu}; done

echo "$bssid"
while [ -z "${bssid}" ]; do read -r ${bssid}; done
# sed -i /${ssid}/d airodumpwpa-01.csv
# sed -i /${free}/d airodumpwpa-01.csv
# sed -i /${edu}/d airodumpwpa-01.csv
sed -i /${ssid}/d midvalues.csv  # Application du filtrage sur les réseaux en configuration EAP entreprise non utiles pour la sélection finale.
sed -i /${free}/d midvalues.csv
sed -i /${edu}/d midvalues.csv
sed -i /${bssid}/d midvalues1.csv
rm -rf delssid5g.txt
exit 0
}

############### Orientation
f_cap(){
clear
echo "1.  Dos"
read -p "Choix: " menuchoix
case ${menuchoix} in
1) unset clean; f_floodinterface ;;
*) f_cap ;;
esac
}


############### Orientation
if [ -f "delssid5g.txt" ]; then
f_delcinqg
elif [ -f "direct.txt" ]; then
bssid="$(cat bssid.txt)"
echo "$bssid"
while [ -z "${bssid}" ]; do read -r ${bssid}; done
sed -i /${bssid}/d midvalues1.csv
# rm -rf direct.txt
# 08:87:C6:46:D3:80,1,-76,1473,Livebox-D380
exit 0
else
f_deldeuxg
fi
