#!/bin/bash

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
