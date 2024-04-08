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
deplist="build-essential subversion wget g++ iptables pavucontrol ffmpeg sqlite3 libsqlite3-dev libssl-dev libnl-3-dev libnl-genl-3-dev libffi-dev zlib1g-dev libreadline-dev libbz2-dev libncursesw5-dev libgdbm-dev libncurses5-dev dsniff hostapd isc-dhcp-server pkg-config xterm freeradius apache2 php libapache2-mod-php php-cli tcpdump python3-scapy vokoscreen wireshark bridge-utils devscripts gengetopt autoconf libtool make libatk-adaptor libgail-common toilet net-tools aircrack-ng python3 python3-pip python3-venv ruby ruby-dev hostapd mdk3 mdk4 wmctrl wireless-tools reaver curl git"
# hostapd-mana berate-ap    si Kali, au choix...
# Ruby est aussi installé pour permettre l'utilisation de l'ancienne version de hostbase-1.6
# vokoscreen sert ici a débugger le tool et enregistrer ce qui se passe ce qui m'aide beaucoup dans la résolution des bugs



# run as root
if [ "$(id -u)" != "0" ]
    then
        echo -e "[$red!$NC] This script need root session. $NC" # 1>&2 inutile car il n'y a pas d'autre retour que l'echo
        exit 1
fi

Banniere(){
idu="$(logname)"
echo $idu
cp -R $(pwd) /home/$idu/Documents/
cd /home/$idu/Documents/
mv hostbasedebian hostbasebackup
echo -e "$yellow 	           Hostbase version $Version By Koala alias Flow $NC"
echo -e "                        |\          )           (                        "
echo -e "                    ____| \__        )         (                         "
echo -e "                   |       @ \        )       (                          "
echo -e "~~~~~~~~~~~~~~~~~~~|~~<->    /         )     (                           "
echo -e "                   |_________\          ) | (                            "
echo -e "                    |    |                |                              "
echo -e "___________________(|)__(|)_____________  |  ____________________________"
echo -e "$blue This script exist since 2016... sample and powerfull.$NC"
echo -e "$blue Install script of the tool.$NC"
echo
echo -e "$red Put in full screen for a bette visibility.$NC"
echo
}

mainmenu(){
Banniere
echo -e "$yellow      Install for Debian and other Debian based system.  $NC \
\n\n\n $blue 1$NC.  Classical install : (install time depend of your connection speed.)\
\n\n $blue 2$NC.  Leave"
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
echo -n "Updating the system before the installation..."
echo -n "Installation will make python and python venv on your computer..."
echo -n "Also ruby and ruby gems will be installed if you want use the older version of hostbase..."
echo -n "If you use Kali some things are already installed..."
echo -n "This install is for a none config to a good config on a Debian fresh version..."
apt update -y && apt upgrade -y
	
for app in $deplist
do
  dpkg --get-selections "$app" | grep install >/dev/null || apt install -y "$app"
done

echo -e "$blue Installing ruby gems if you want to use the older version...$NC"

# A voir pour Manjaro et Arch :

# [user~]$ export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
# [user~]$ export PATH="$PATH:$GEM_HOME/bin"
# user~]$ gem list
# [user~]$ gem update

gem install highline && gem install rake && gem install bundler && gem install colorize


echo -e "\t\e[1;32m[+] Configuring apache and the phishing page... WAIT....\e[0m"
rm -rf /etc/dhcp/dhcpd.conf
cd /home/$idu/Documents/hostbasebackup/
mkdir LasTry
cp -R WebPages/dhcpd.conf /etc/dhcp/
cp -R WebPages/* /etc/
sleep 5;
mkdir /opt/backupwebserver
mkdir /opt/backupwebserver/conf
mkdir /opt/backupwebserver/homepage
cp -R /etc/apache2/* /opt/backupwebserver/conf/
cp -R /var/www/* /opt/backupwebserver/homepage/
sleep 3;
rm -rf /etc/apache2/apache2.conf
rm -rf /etc/apache2/sites-available/000-default.conf
cp -R WebPages/apache2.conf /etc/apache2/
cp -R WebPages/000-default.conf /etc/apache2/sites-available/
echo -e "\t\e[1;32m[+] A backup configuration of apache has been created on : /opt/backupserver... starting apache NOW...\e[0m"
service apache2 restart
sleep 4;
cd /home/$idu/Documents/
echo -e "\t\e[1;32m[+] Installing python virtual environment (venv)... WAIT....\e[0m"
# curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
# echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc && echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc && echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
pythonversion=$(python3 --version)
echo $pythonversion
# string=$pythonversion
# install=$(echo "$string" | sed 's/[^0-9.]//g')
# echo $install
#pyenv install $install && pyenv global $install
# eval "$(pyenv init -)"
cd /home/$idu/Documents/
python3 -m venv hostbase
pip3 install numpy && pip3 install pandas
cp -R hostbasebackup/* /home/$idu/Documents/hostbase/
sed -i -e $'$a\\\nsource /home/'${idu}'/Documents/hostbase/bin/activate' ~/.bashrc
exec "$SHELL"
echo -e "$green Python venv install has be done.\e[0m"
echo -e "$yellow --> if you had some errors during the installation of python venv then please follow procedure install in the installPython file step by step."
echo -e "$blue You maybe need to install dkms driver for RT88XXAU cards... Please install it from aircrack-ng github version apart of this script.Reboot will be necessary."
echo -e "Your .~/bashrc has been modified to keep hostbase venv activated every time."
echo -e "If you don't want that you can remove the last line begining by : source hostbase..."
echo -e "$yellow To use the wpa3 QR code mode correctly you need to edit your php.ini file and check those parameters :"
echo -e "$yellow post_max_size = 8M"
echo -e "$yellow file_uploads = On"
echo -e "$yellow upload_max_filesize = 16M"
echo -e "$yellow max_file_uploads = 20"
echo -e "$yellow allow_url_fopen = On"
echo -e "$yellow You can close this windows and go to /Documents/hostbase folder to launch it like :"
echo -e "$green python3 hostbase.py"
echo -e "$red don't forget to plug your Wi-Fi cards before start it"
}

################################################

checkexit(){
echo "Goodbye..."
exit 0
}
mainmenu
