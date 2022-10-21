#!/bin/bash
# Under licence GPLv3 http://www.gnu.org/licenses/gpl.txt
# Hostbase By Koala alias Flow

Version=1.6

# set color variable

red='\e[1;31m' 
NC='\e[0m' 
yellow='\e[1;33m'
blue='\e[1;34m'


deplist="build-essential subversion wget g++ iptables pavucontrol ffmpeg sqlite3 libsqlite3-dev libssl-dev libnl-3-dev libnl-genl-3-dev dsniff hostapd isc-dhcp-server pkg-config xterm freeradius apache2 php libapache2-mod-php php-cli tcpdump python3-scapy vokoscreen wireshark bridge-utils devscripts gengetopt autoconf libtool make libatk-adaptor libgail-common toilet ruby ruby-dev hostapd mdk3 mdk4 berate-ap wmctrl"


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
echo -e "$blue Script utilisant berate_ap, pour plus d'infos voir: https://github.com/sensepost/berate_ap.$NC"
echo -e "$blue Installation des dépendances du script pour la version 1.6 console.$NC"
echo
echo -e "$red Merci de mettre d'agrandir cette fenetre pour une meilleure visibilité.$NC"
echo
}

mainmenu(){
Banniere
echo -e "$yellow      Installation pour kali-linux $NC \
\n\n\n $blue 1$NC.  Lancer l'installation classique: (le temps dépendra de votre connexion internet.)\
\n\n $blue 2$NC.  Installation apache2 SSL: (--> pour utiliser cette option vous devez ajouter le backport correspondant a votre distribution linux.))\
\n $blue 3$NC.  Quitter \n"
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
echo -n "Recherche de mise a jours"
apt-get -qq update
	
for app in $deplist
do
  dpkg --get-selections "$app" | grep install >/dev/null || apt install -y "$app"
done

echo -e "$blue Installation des ruby gems servant a faire fonctionner hostbase.$NC"
gem install highline && gem install rake && gem install bundler && gem install colorize

echo -e "\t\e[1;32m[+] Configuration de apache2 et des pages de phishing... PATIENTEZ....\e[0m"
cp -R $(pwd) /tmp/
sleep 8;
cp -R /tmp/hostbase-1.6FR/PagesFR/* /etc/
sleep 5;
cd /etc/apache2/
rm -rf apache2.conf
cd /etc/apache2/sites-available/
rm -rf 000-default.conf
cp -R /tmp/hostbase-1.6FR/apache2.conf /etc/apache2/
cp -R /tmp/hostbase-1.6FR/000-default.conf /etc/apache2/sites-available/
service apache2 restart
sleep 2;
echo -e "\t\e[1;32m[+] Lancement de hostbase...\e[0m"
cd /tmp/hostbase-1.6FR/
ruby hostbase.rb
mainmenu
}

################################################
sslinstall(){
echo -e "NOTE: cette option ne marchera pas si vous ajoutez pas dans le fichier sources.list le backport correspondant a votre distribution linux et vous devez installer python-certbot-apache"
sleep 10;
echo -e "L'installation débutera dans 5s... commande pour renouveller le certificat: certbot renew --dry-run"
sleep 10;
certbot --apache
}
################################################

checkexit(){
echo "Goodbye..."
exit 0
}
mainmenu
