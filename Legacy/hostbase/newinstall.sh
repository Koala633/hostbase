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

deplist="build-essential upgrade-system subversion wget g++ iptables iptables-dev pavucontrol ffmpeg sqlite3 libsqlite3-dev libssl-dev libnl-3-dev libnl-genl-3-dev dsniff hostapd isc-dhcp-server pkg-config xterm apache2 php libapache2-mod-php php-mcrypt php-cli tcpdump scapy vokoscreen wireshark python-twisted bridge-utils devscripts gengetopt autoconf libtool make"

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
echo -e "$blue Install dependencies script for hostbase V 0.9 and 1.0.$NC"
echo
echo -e "$red Please put the windows in full screen for better visibility.$NC"
echo
}

mainmenu(){
Banniere
echo -e "$yellow      Install for Unbutu/Debian $NC \
\n\n\n $blue 1$NC.  Launch install (Time will be accorded to your internet connection.)\
\n\n $blue 2$NC.  Ssl install(--> To use this option you need to add the backport according to your distribution name)\
\n $blue 3$NC.  Quit \n"
read -p "Choix: " choix

case $choix in
1) installationsuite ;;
2) sslinstall ;;
3) checkexit ;;
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

echo -e "\t\e[1;32m[+] Configuring apache2... wait....\e[0m"
touch /etc/wpa_supplicant.conf
cp -R $(pwd) /tmp/
sleep 8;
cp -R /tmp/hostbase/hostbaseV0.9/pagecle/* /etc/
sleep 3;
cp -R /tmp/hostbase/pagewps/* /etc/
sleep 5;
cd /tmp/hostbase/
chmod a+x dns.txt
cd /tmp/hostbase/hostbaseV0.9/
chmod a+x dns.txt
cd /etc/apache2/
rm -rf apache2.conf
cd /etc/apache2/sites-available/
rm -rf 000-default.conf
cp -R /tmp/hostbase/apache2.conf /etc/apache2/
cp -R /tmp/hostbase/000-default.conf /etc/apache2/sites-available/
cd /var/www/
rm -rf *
sleep 2;
service apache2 restart
sleep 2;
# A rajputer:
unset hostbasechoix
while [ -z "${hostbasechoix}" ]; do read -p "Wich version of hostbase you want to use? (Answer possible: hostbase1.0 or hostbase0.9): " hostbasechoix; done
if [ "${hostbasechoix}" = 'hostbase1.0' ]; then
cd /tmp/hostbase/
bash hostbase1.0.sh
elif [ "${hostbasechoix}" = 'hostbase0.9' ]; then
cd /tmp/hostbase/hostbaseV0.9/
bash hostbase0.9.sh
else
        echo "$red WRONG CHOICE ! Are you stupid ? go to /tmp/hostbase and exec the script: bash hostbase1.0.sh$NC"
sleep 4;
mainmenu
fi
}

################################################
sslinstall(){
echo -e "NOTE: this option will not work if you don't add and install on your sources.list the backport and install the python-certbot-apache"
sleep 10;
echo -e "Installation of ssl will begin in 10s... command to renew cert: certbot renew --dry-run"
sleep 10;
certbot --apache
}
################################################

checkexit(){
echo "Goodbye..."
exit 0
}
mainmenu
