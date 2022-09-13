#!/bin/bash
echo $$ >/tmp/hostbase-1.5FR/wash.pid


#####################################################

f_variables(){
intmoniteur="$(cat cartedos.txt)"
BSSID="$(cat apmac.txt)"
echo "$intmoniteur"
while [ -z "${intmoniteur}" ]; do read -r ${intmoniteur}; done

echo "$BSSID"
while [ -z ${BSSID} ]; do read -r ${BSSID}; done
f_wash
}

#####################################################

f_relance(){
intmoniteur="$(cat cartedos.txt)"
BSSID="$(cat apmac.txt)"
echo "$intmoniteur"
while [ -z "${intmoniteur}" ]; do read -r ${intmoniteur}; done

echo "$BSSID"
while [ -z ${BSSID} ]; do read -r ${BSSID}; done
killall wash
f_wash
}

#####################################################

f_wash(){
        wash -i ${intmoniteur} -b ${BSSID} -j > wash.txt &
        echo $! >/tmp/testwash.pid
         sleep 20;
f_relance
       }

#####################################################
f_activedos(){
clear
echo "1.  Dos"
read -p "Choix: " menuchoix
case ${menuchoix} in
1) unset clean; f_floodinterface ;;
*) f_activedos ;;
esac
}


# run as root
if [ "$(id -u)" != "0" ]; then
	echo -e "\e[1;31m[]\e[0m Ve te pedir al admin !" 1>&2
	exit 1
else
	clean=1
	f_variables
fi

