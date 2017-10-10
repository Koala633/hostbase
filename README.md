
~~~~~~~~~~~~~~~~~~ Hostbase project By Koala @ crack-wifi.com @ wifi-libre.com @ kali-linux.fr ~~~~~~~~~~~~~~~~~~~~

Welcome to the hostbase project// Bienvenido en hostbase// Bienvenu sur le projet hostbase.

Update of 5/10/2017: ruby GUI minors bugs fixed, full read me below:


EN/ES/FR full guide install:

First/En primero/En premier:

apt-get install -y build-essential upgrade-system subversion wget g++ iptables iptables-dev pavucontrol ffmpeg sqlite3 libsqlite3-dev libssl-dev libnl-3-dev libnl-genl-3-dev dsniff hostapd isc-dhcp-server pkg-config xterm freeradius apache2 php libapache2-mod-php php-mcrypt php-cli tcpdump scapy vokoscreen wireshark python-twisted bridge-utils devscripts gengetopt autoconf libtool make



Then you need to install the following ruby gems:

apt-get install ruby

apt-get install ruby-dev

gem install highline

apt-get install libgtk2.0-dev

gem install gtk2

Installar los gems de ruby:

apt-get install ruby

apt-get install ruby-dev

gem install highline

apt-get install libgtk2.0-dev

gem install gtk2



Il vous faut ensuite installer les gems de ruby:

apt-get install ruby

apt-get install ruby-dev

gem install highline

apt-get install libgtk2.0-dev

gem install gtk2


In case of troubleshooting during install//Si tienes problemo de installacion//En cas de problème d'installation:

gem install rake

gem install bundler

Then try to install again the ruby gems above//Despues reinicia las installacion de los gem de ruby a riba//Ensuite recommencez l'installation des ruby gems ci-dessus.


____________________________________________________

EN/ES/FR apache2 configuration:

EN: make sure your working direcory is /var/www instead of /var/www/html, if not you have to change your apache2.conf and 000-default.conf in site-available, see the example below.

ES: Verifica que la carpeta de trabajo de apache2 esta en /var/www y no /war/www/html, si no tienes que cambiar una parte del apache2.conf y del 000-default.conf dentro site-available, mira a bajo el ejemplo.

FR: Vérifiez le répertoire de travail soit bien en /var/www au lieu de /var/www/html, sinon changez la partie correspondante de apache2.conf et le 000-default.conf dans site-available, exemple de configuration ci-dessous:

ServerAdmin webmaster@localhost

	DocumentRoot /var/www/
  
        <Directory />
        
                Options FollowSymLinks
                
                AllowOverride None
                
        </Directory>
        
        <Directory /var/www/>
        
                Options Indexes FollowSymLinks MultiViews
                
                AllowOverride None
                
                Order allow,deny
                
                allow from all
                
        </Directory>

EN: the fake page folder need to be in /etc

ES: copia/pega todo lo que hay en paginasAQUI en la carpeta /etc

FR: Téléchargez le fichier frenchpages.zip, et une fois le tout dézipé, copiez les différents dossier des fake page dans le répertoire /etc.

____________________________________________________

EN/ES/FR start:

The script need to be started in /tmp folder //El script se tiene que ejecutar en la carpeta /tmp //Le script doit etre lancé dans /tmp

Just copy/paste the entire folder of hostbase-1.1 to /tmp // Copia y pega la carpeta entera de hostbase-1.1 a dentro la carpeta /tmp // Copiez/coller le dossier hostbase-1.1 dans /tmp


In /tmp/hostbase-1.1 folder, right click and open a shell here// A dentro /tmp/hostbase-1.1 click derecho, abrir un terminal aqui // Dans /tmp/hostbase-1.1, clique droit ouvrir un terminal ici.


Start it // Inicia lo asi // lancer le tel que:

ruby hostbase.rb


____________________________________________________

EN/ES/FR the bascis knowledge:


EN: For better performance this script works ONLY with 2 wifi-cards cause it automatise a lot of thing like the encrypted AP with WPS the active DoS tracking the AP channel etc...

ES: Para mas potentia este script ANDA con 2 tarjeta wifi porqué automatisa un monton de cosas: el AP encryptado con el WPS, la DoS que sigue el Ap etc...

FR: Pour une meilleur performance ce script fonctionne SEULEMENT avec 2 cartes wifi, automatisation de la rogue AP et du WPS, de la DoS qui suit l'ap sur son canal etc... c'est mieux ainsi.2 cartes wifi c'est pas de trop et ça coute aps très cher, il faut savoir ce qu'on veut comme compromis, soit avoir une chance de réussir l'attaque soit la foirer.


You need to start with the scan option to stop network-manager and grab network info // Se tiene que empezar por el scan para parar network-manager y tener informacion sobre la red que quieres // On doit toujours commencer par l'option scan pour stopper network-manager et récupérer les infos du réseau voulu.

____________________________________________________

EN/ES/FR good to know:

EN: The multi AP mode is configured on wlan0, if you have other card just rename your card wlan0 before launch the script to use it.

ES: El modo multi AP esta configurado con wlan0, si tienes otra tarjeta wifi da le el nombre de wlan0 para usar este modo antes de iniciar el script.

FR: Le mode multi AP est configuré avec wlan0, si votre carte compatible hostapd n'est pas en wlan0, renommez la en wlan0 avant d'utiliser le script.

EN only: if you want to use this script with the fake page of your country you will need to change the filter in check.rb line 54



Date source //  Informaciones completo // Informations complètes:

EN: https://github.com/Koala633/hostbase/blob/master/hostbaseEnglishVersion/RogueAPparty.pdf

FR: http://www.crack-wifi.com/forum/topic-12236-hostbase-11-beta-test.html

FR: https://github.com/Koala633/hostbase/blob/master/hostbase/UnehistoirederogueAP.pdf

ES: https://www.wifi-libre.com/topic-745-hostbase-10-released-page-6.html

ES: https://www.wifi-libre.com/topic-756-una-historia-de-rogue-ap-el-pdf-de-koala-traducido-al-espanol.html





Old bash script below.
# Hostbase
A bash script for advanced rogue AP attack (Update of 11 august 2017: Added 3 tracked channel more 3 9 and 13 instead of the 1 6 and 11 before)

(download the hostbase folder and launch the newinstall.sh script into hostbase folder)(don't use the hostbase english folder because it's an old version)

The script is able to:

Disconnect quickly the target station from the target network

Create encrypted fake WPA AP

Create heavy interference and replace the target AP by your fake (work only again windows system)

Ask to push te WPS button instead of ask the key which is very suspicious...

Switch between local and internet rogue AP

DoS attack tracking target AP on the master channel's


Included airbase-ng cafe-latte fake AP attack again routers with hexadecimal passwords

Included hostapd multi AP option, that allow you to create multi fake AP (WARNING: to use this attack, CONFIGURE_DYNAMIC_WLAN must be compiled with hostapd install), if you only use the reposity version and not the latest version of hostapd you will have to change your MAC adress before use the multi AP option, please take note of that and see the manual.
Included redirect option if you want to use your computer as an evil AP and a dd-wrt router as a repeater with a configured chilispot inside.

Included a PDF for documentation

Once you entered the data of target network, the script is autonomous and can work alone, just go take a cup of tea :)
French most popular router pages are included

Tool used are hostapd and airbase-ng for a final result of hostbase.

French project but also open as other to make this more fun.

How use it ?
Go inside the hostbase folder and launch the installation script dependency:

bash newinstall.sh

Then when install finished, you will have the choice between hostbase1.0 and hostbase0.9.

The 0.9 ask for the key
The 1.0 ask for wps push button

At the first install all is going to do automaticaly but for the next use copy the hostbase folder into /tmp and start it like that:
cd /tmp/hostbase
bash hostbase1.0.sh

For 0.9 version:
cd /tmp/hostbase/hostbaseV0.9
bash hostbase0.9.sh

If you want to use the phishing page of your country, you will have to change the name on the script.Don't forget to start with the passive scan (option 5) for scan around and for kill any trouble process (network-manager etc...)

This script is a rogue AP based script and use WPA rogue AP with wps open session to let the victim come to us.
Also a new DoS is incorpored to track every second you want the channel of the target AP.




----> PLEASE, LOOK THE MANUAL AND PDF BEFORE USE <----

Sample video of how it work here:
https://www.youtube.com/channel/UCeWPrv3C8UxHzCsjTjbjKrQh

Youtube channel moved here:
https://www.youtube.com/channel/UCeWPrv3C8UxHzCsjTjbjKrQ  (other vidéo coming soon)


Coming in future:

Freeradius rogue AP attack based on the login only to directly grab the key without webserver or redirection (NOT TESTED YET).

Maybe i will include a WPS attacks too.

--> Not for beginner usage <--

