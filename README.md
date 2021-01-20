# Hostbase project By Koala @ sécurité-wifi.com @ wifi-libre.com @ kali-linux.fr
## Welcome to the hostbase project! - ¡Bienvenidos al proyecto hostbase! - Bienvenue sur le projet hostbase! 
Official page in [https://www.facebook.com/Rogue-ap-hostbase-785509138309015/](Facebook)
If you like the project share it as much as you can. 
Hostbase automates encrypted WPS Rogue AP and DoS, even if  the AP switch to a different channel.
### For kali-linux users:
 Hostbase is available in French, Spanish and English. 
Locate your shell in the directory of the language of your choice. For example, to execute Hostbase in Spanish, do:
 ```bash
 cd hostbase/hostbase-1.3ES/
 ```
 ### Para usuarios de wifislax
 Usen la versión especial que se encuentra en la carpeta dedicada:
 ```bash
 cd hostbase/hostbase-1.1Wifislax
 ```
 
 Más información en [https://foro.seguridadwireless.net/wifislax/hostbase-atacando-2-redes-al-mismo-tiempo/msg365822/](seguridadwireless) 
## Full guide install using kali-linux:
### Step 1__________________________________________________________
```bash
apt-get install -y build-essential upgrade-system subversion wget g++ iptables pavucontrol ffmpeg sqlite3 libsqlite3-dev libssl-dev libnl-3-dev libnl-genl-3-dev dsniff hostapd isc-dhcp-server pkg-config xterm freeradius apache2 php libapache2-mod-php php-cli tcpdump scapy vokoscreen wireshark bridge-utils devscripts gengetopt autoconf libtool make
```
### Step 2____________________________________________________________
Hostbase use hostapd, a deamon that creates access points.To check if your wifi card is compatible with hostapd:
```bash
iw list | grep "Supported interface modes" -A 8
```
If there is compatibility you will see something like that:
```bash
Supported interface modes:

		 * IBSS
		 
		 * managed
		 
		 * AP
		 
		 * AP/VLAN
		 
		 * WDS
		 
		 * monitor
		 
		 * mesh point
``` 

If your card is not compatible with hostapd you will only be able to use the simple attack with airbase-ng and you can jump directly to ----> Step 3.

For those who have a wifi card compatible with hostapd, you must first remove any older version of hostapd
```bash
apt-get remove hostapd
```
Then download the latest version and compile it:
```bash
wget https://w1.fi/cgit/hostap/snapshot/hostap_2_9.tar.gz

tar -zxf hostap_2_9.tar.gz

cd /root/hostap_2_9/hostapd

cp defconfig .config

nano .config


CONFIG_DRIVER_NL80211=y

CONFIG_LIBNL32=y

CONFIG_EAP_PWD=y

CONFIG_WPS=y

CONFIG_WPS_UPNP=y

CONFIG_WPS_NFC=y

CONFIG_RADIUS_SERVER=y

CONFIG_IEEE80211N=y

CONFIG_IEEE80211AC=y

CONFIG_DEBUG_FILE=y

CONFIG_FULL_DYNAMIC_VLAN=y

CONFIG_TLSV11=y

CONFIG_TAXONOMY=y
```
Then finish installation with
```bash
sudo make
sudo make install
```
### Step 3_______________________________________________________

Install dependencies
```bash
sudo apt install ruby ruby-dev libgtk2.0-dev gobject-introspection ruby-gtk2 mdk4
```
You also need to install the following ruby gems:
```bash
gem install highline rake bundler
```

### Step 4________________________________________________________

Apache2 settings

Copy/paste the file `000-default.conf` into `/etc/apache2/site-available`

Copy/paste the file `apache2.conf` into `/etc/apache2`

Download the french fake pages and place all them into `/etc`

WARNING: There is no phishing page in English for the moment.  To use a fake page for your country you will need to edit the filter in check.rb line 54.
Actually you can enter on the phishing page field one of the following pages:
livebox or bbox or free or sfr.

REMEMBER you will have to adapt the file check.rb line 54 if you want to use your own phishing page.




### Step 5________________________________________________________

The begining:

Copy/paste the folder of hostbase-1.3 into `/tmp`.
Go to `/tmp/hostbase-1.3FR` and launch it: 
```bash
ruby hostbase.rb
```
WARNING: you have to start with the network scan --> discover the network

Network-manager CAN CAUSE TROUBLE with hostapd so you need to disable/stop it. 

Don't forget to leave thostbase with ctrl+c on the main hostbase terminal.

Leaving the program by ctrl+c, files are cleaned and network manager is restarted so if you want to do some other test without make a network scan each time, just stop network-manager before relaunch hostbase:
```bash
systemctl stop NetworkManager.service
systemctl disable NetworkManager.service
```

REMEMBER: if network-manager is running when you are using hostbase you will have some problems

More information: [hostbase/Legacy/hostbaseEnglishVersion/RogueAPparty.pdf](RogueAPparty.pdf)


--> Not for beginner usage <--
