#!/usr/bin/env ruby
require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERREUR detectée, vérifiez vos entrées: exit du programme dans 5s.\e[0m"
sleep 5
abort("BYE..")
end

system"ifconfig -a"
puts "Entrez une carte wifi pour le scan: "
$carte = gets.chomp
puts "#{$carte} a été sélectionnée pour le scan"
if $carte.chomp.start_with?('wlan', 'wlx', 'wlp')
   puts "\e[1;32m[*] Vérification de l'interface wifi... OK.\e[0m"
   `echo #{$carte} > cartescanpassif.txt` 
else
error()
end

puts "Arret de network-manager... (pour éviter les conflits)"
`systemctl stop NetworkManager.service`
sleep 1
`systemctl disable NetworkManager.service`
sleep 4
puts "Lancement du mode monitor..."
`ip link set #{$carte} down`
`iw dev #{$carte} set type monitor`
sleep 5
`ip link set #{$carte} up`
sleep 4
`wmctrl -r :ACTIVE: -b add,fullscreen`
system"ruby airodump.rb &> /dev/null &"
`airodump-ng #{$carte} --encrypt WPA --uptime | grep "0d 00:02:" > airodump.txt`
