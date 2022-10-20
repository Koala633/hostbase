#!/usr/bin/env ruby
require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detectado, salida dentro 5s.\e[0m"
sleep 5
abort("BYE..")
end

puts "\e[1;33m[*] Interfaz wifi:\e[0m"
system"airmon-ng"
puts "Interfaz wifi para el scan: "
$carte = gets.chomp
puts "#{$carte} para el scan scan"
if $carte.chomp.start_with?('wlan', 'wlx', 'wlp')
   puts "\e[1;32m[*] Vérificacion de la interfaz wifi... OK.\e[0m"
   `echo #{$carte} > cartescanpassif.txt` 
else
error()
end

puts "Paramos network-manager..."
`systemctl stop NetworkManager.service`
sleep 1
`systemctl disable NetworkManager.service`
sleep 4
puts "Iniciando el modo monitor..."
`ip link set #{$carte} down`
`iw dev #{$carte} set type monitor`
sleep 5
`ip link set #{$carte} up`
sleep 4
`wmctrl -r :ACTIVE: -b add,fullscreen`
system"ruby airodump.rb &> /dev/null &"
`airodump-ng #{$carte} --encrypt WPA --uptime | grep "0d 00:02:" > airodump.txt`
