#!/bin/bash
# Under licence GPLv3 http://www.gnu.org/licenses/gpl.txt
# Hostbase By Koala alias Flow

Version=1.7


# set color variable

red='\e[1;31m' 
NC='\e[0m' 
yellow='\e[1;33m'
blue='\e[1;34m'
green='\e[1;32m'

# Manjaro, installer wash : 
deplist="build-essential subversion wget g++ iptables pavucontrol ffmpeg sqlite3 libsqlite3-dev libssl-dev libnl-3-dev libnl-genl-3-dev libffi-dev zlib1g-dev libreadline-dev libbz2-dev libncursesw5-dev libgdbm-dev libncurses5-dev dsniff hostapd isc-dhcp-server pkg-config xterm freeradius apache2 php libapache2-mod-php php-cli tcpdump python3-scapy vokoscreen wireshark bridge-utils devscripts gengetopt autoconf libtool make libatk-adaptor libgail-common toilet net-tools aircrack-ng python3 python3-pip ruby ruby-dev hostapd mdk3 mdk4 wmctrl wireless-tools reaver curl git"
# hostapd-mana berate-ap    si Kali, au choix...
# Ruby est aussi installé pour permettre l'utilisation de l'ancienne version de hostbase-1.6
# vokoscreen sert ici a débugger le tool et enregistrer ce qui se passe ce qui m'aide beaucoup dans la résolution des bugs



# run as root
if [ "$(id -u)" != "0" ]
    then
        echo -e "[$red!$NC] Prohibido. $NC" # 1>&2 inutile car il n'y a pas d'autre retour que l'echo
        exit 1
fi

Banniere(){
idu="$(logname)"
echo $idu
cp -R $(pwd) /$idu/Documents/
cd /$idu/Documents/
mv hostbasewifislax hostbasebackup
echo -e "$yellow 	           Hostbase version $Version de Koala alias Flow $NC"
echo -e "                        |\          )           (                        "
echo -e "                    ____| \__        )         (                         "
echo -e "                   |       @ \        )       (                          "
echo -e "~~~~~~~~~~~~~~~~~~~|~~<->    /         )     (                           "
echo -e "                   |_________\          ) | (                            "
echo -e "                    |    |                |                              "
echo -e "___________________(|)__(|)_____________  |  ____________________________"
echo -e "$blue La primera version del script ha sido creado en 2016... ahora powered by Python$NC"
echo -e "$blue Instalacion del programa.$NC"
echo
echo -e "$red Ponga la pantalla en grande para ver todo lo que pasa.$NC"
echo
}

mainmenu(){
Banniere
echo -e "$yellow      Instalacion para WIFISLAX.  $NC \
\n\n\n $blue 1$NC.  Instalacion clasica.\
\n\n $blue 2$NC.  Salir"
read -p "Elegir: " choix

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
echo -e "\n\e[1;33m[*] Por favor espera...\e[0m\n"
echo -n "Actualizacion del systema..."
slapt-src -u && slapt-src -i wmctrl python3-virtualenv python3-pipx
cd /$idu/Documents/hostbasebackup/
mkdir LasTry
cp -R WebPages/* /etc/
sleep 5;
mkdir /opt/backupwebserver
mkdir /opt/backupwebserver/conf
mkdir /opt/backupwebserver/homepage
cd /etc/httpd/
cp -R * /opt/backupwebserver/conf/
cp -R /var/www/* /opt/backupwebserver/homepage/
sleep 3;
cd /etc/
cp -R php.ini /opt/backupwebserver/conf/
rm -rf /etc/httpd/httpd.conf
cd /$idu/Documents/hostbasebackup/
cp -R WebPages/httpd.conf /etc/httpd/
installpkg WebPages/php-7.4.33-x86_64-3_slack15.0.txz
cp -R WebPages/php.ini /etc/
echo -e "\t\e[1;32m[+] La configuracion de httpd ha sido guardado en : /opt/backupserver... reiniciando httpd...\e[0m"
httpd -k start
sleep 3;
cd /$idu/Documents/
pip install numpy && pip install pandas
python3 -m venv hostbase
cp -R hostbasebackup/* /$idu/Documents/hostbase/
sleep 2;
source hostbase/bin/activate
# sed -i -e $'$a\\\nsource '${idu}'/Documents/hostbase/bin/activate' ~/.bashrc
# exec "$SHELL"
echo -e "$green Python venv ha sido instalado.\e[0m"
echo -e "$blue Quisas usted tiene que instalar el driver para las tarjetas RT88XXAU.Réiniciar el ordenador despuès."
# echo -e "Your .~/bashrc has been modified to keep hostbase venv activated every time."
# echo -e "If you don't want that you can remove the last line begining by : source hostbase..."
echo -e "$yellow Usted puede cerrar esta pantalla y ir en /Documents/hostbase folder para iniciar hostbase :"
echo -e "$green python hostbase.py"
echo -e "$red No se olvida de poner las tarjetas wifi antes de iniciar Hostbase."
}

################################################

checkexit(){
echo "Adio..."
exit 0
}
mainmenu
