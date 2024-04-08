#!/usr/bin/env bash
# Under licence GPLv3 http://www.gnu.org/licenses/gpl.txt
# Hostbase By Koala alias Flow

Version=1.7



red='\e[1;31m' 
NC='\e[0m' 
yellow='\e[1;33m'
blue='\e[1;34m'
green='\e[1;32m'



# run as root
if [ "$(id -u)" != "0" ]
    then
        echo -e "[$red!$NC] This script need admin rules ! $NC" # 1>&2 inutile car il n'y a pas d'autre retour que l'echo
        exit 1
fi

Banniere(){
idu="$(logname)"
echo $idu
cp -R $(pwd) /home/$idu/Documents/
cd /home/$idu/Documents/
mv hostbasearch hostbasebackup
echo -e "$yellow 	           Hostbase version $Version By Koala alias ~GostInTheHell~ $NC"
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
echo -e "$yellow      Install for arch based distribs $NC \
\n\n\n $blue 1$NC.  Classical install : (install time depend of your connection speed.)\
\n\n $blue 2$NC.  Quit\n"
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
yes O | sudo pacman -Syu  # "yes" alone is not enough for pacman to automatically confirm a package.BASED ON YOUR LANGUAGE : you need to put the confirm letter after "yes" to make a good pipe to pacman.Choose one of them :
# yes Y | sudo pacman -Syu # English
# yes J | sudo pacman -Syu # English or other 
# yes O | sudo pacman -Syu # French/Canada 
# yes S | sudo pacman -Syu # Spanish
echo -e "$green Update done !"

packages=("lib32-sqlite" "glibc" "openssl" "libpcap" "wget" "git" "iptables" "ffmpeg" "dsniff" "dhcp" "pkg-config" "xterm" "freeradius" "apache" "php" "php-apache" "tcpdump" "python3" "bridge-utils" "toilet" "ruby" "hostapd" "mdk4" "aircrack-ng" "wmctrl" "reaver" "rfkill")

for pkg in ${packages[@]}; do
if  is_pkg_installed=$(pacman -Qq ${pkg}) > /dev/null ; then
echo "The package $pkg is installed"
echo -e "$yellow  The package $pkg is installed.$NC"
   else 
       echo -e "$blue $pkg is not installed yet ! Installing ${pkg}..."
       yes O | sudo pacman -Syu ${pkg}  # "yes" alone is not enough for pacman to automatically confirm a package.BASED ON YOUR LANGUAGE : you need to put the confirm letter after "yes" to make a good pipe to pacman.See above.
    fi
done
# yes O | sudo pacman -Syu --needed base-devel git  # "yes" alone is not enough for pacman to automatically confirm a package.BASED ON YOUR LANGUAGE : you need to put the confirm letter after "yes" to make a good pipe to pacman.See abovre.
echo -e "$green Installation of dependencies done !"
echo -e "$blue Installing the ruby gems...$NC"
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
gem list && gem update && gem install highline && gem install rake && gem install bundler && gem install colorize

# mdk3 AUR à mettre.
# dkms rt8812xx

echo -e "\t\e[1;32m[+] Configuration of the apache2 web server and the phishing page... WAIT....\e[0m"
#######" Installation du virtuel env à faire ici
# cp -R $(pwd) /tmp/
sleep 2;
mkdir LasTry
cp -R WebPages/* /etc/
sleep 5;
mkdir /opt/backupwebserver
mkdir /opt/backupwebserver/conf
mkdir /opt/backupwebserver/homepage
cp -R /etc/httpd/conf/* /opt/backupwebserver/conf/
cp -R /srv/http/* /opt/backupwebserver/homepage/
rm -rf /etc/httpd/conf/httpd.conf
echo -e "\t\e[1;32m[+] A backup configuration of apache has been created on : /opt/backupserver... starting apache NOW...\e[0m"
cp -R WebPages/httpd.conf /etc/httpd/conf/
apachectl start
sleep 2;
echo -e "$yellow mdk3 and dkms driver for rtl88xxau cards are not installed... AUR must be configured to install mdk3 and rtl88xxau.Please install them apart of this script.Reboot will be necessary."
echo -e "$blue You need to install python virtual env and pip by repositories or AUR"
echo -e "$yellow To use the wpa3 QR code mode correctly you need to edit your php.ini file and check those parameters :"
echo -e "$yellow post_max_size = 8M"
echo -e "$yellow file_uploads = On"
echo -e "$yellow upload_max_filesize = 16M"
echo -e "$yellow max_file_uploads = 20"
echo -e "$yellow allow_url_fopen = On"
echo -e "$yellow You can close this windows and go to /Documents/hostbase folder to launch it like :"
echo -e "$green python hostbase.py"
echo -e "$red don't forget to plug your Wi-Fi cards before start it"
echo -e "$yellow You can close this windows."
}

################################################

checkexit(){
echo "Goodbye..."
exit 0
}
mainmenu
