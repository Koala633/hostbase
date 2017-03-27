#!/bin/bash
# Under licence GPLv3 http://www.gnu.org/licenses/gpl.txt
# Hostbase By Koala alias Flow

Version=1.0

# set color variable

red='\e[1;31m' 
NC='\e[0m' 
yellow='\e[1;33m'
blue='\e[1;34m'

# requierement

deplist="build-essential upgrade-system subversion wget g++ iptables iptables-dev pavucontrol ffmpeg sqlite3 libsqlite3-dev libssl-dev libnl-3-dev libnl-genl-3-dev dsniff isc-dhcp-server pkg-config xterm apache2 php libapache2-mod-php php-mcrypt php-cli vokoscreen wireshark python-twisted bridge-utils devscripts gengetopt autoconf libtool make"

# run as root
if [ "$(id -u)" != "0" ]
    then
        echo -e "[$red!$NC] Ce script requiert les droits d'admin $NC" # 1>&2 inutile car il n'y a pas d'autre retour que l'echo
        exit 1
fi

Banniere(){
echo -e "$yellow 	           Hostbase version $Version By Koala alias Flow $NC"
echo -e "                        |\          )           (                        "
echo -e "                    ____| \__        )         (                         "
echo -e "                   |       @ \        )       (                          "
echo -e "~~~~~~~~~~~~~~~~~~~|~~<->    /         )     (                           "
echo -e "                   |_________\          ) | (                            "
echo -e "                    |    |                |                              "
echo -e "___________________(|)__(|)_____________  |  ____________________________"
echo -e "$blue A rogue AP script, the better of hostapd and airbase together.$NC"
echo -e "$blue Install dependencies script.$NC"
echo
echo -e "$red Please put the windows in full screen for better visibility.$NC"
echo
}

mainmenu(){
Banniere
echo -e "$yellow      Install for Unbutu/Debian $NC \
\n\n $blue 1$NC.  Lauch install (Time will be accorded to your internet connection.)\
\n $blue 2$NC.  Quit \n"
read -p "Choix: " choix

case $choix in
1) installationsuite ;;
2) checkexit ;;
*) exit 1;;
esac
}

#########################################################
installationsuite(){
clear
Banniere
echo -e "\n\e[1;33m[*] Please wait...\e[0m\n"
echo -n "Updating package"
apt-get -qq update
	
for app in $deplist
do
  dpkg --get-selections "$app" | grep install >/dev/null || apt-get install -y "$app"
done

echo -e "\t\e[1;32m[+] Install finished, for error report the log console.If you use corrupted file out it on /etc folder.\e[0m"
touch /etc/wpa_supplicant.conf
}

checkexit(){
echo "Goodbye..."
exit 0
}

mainmenu
