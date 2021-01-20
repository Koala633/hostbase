#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detected: check ALL your entry will abort in 5s.\e[0m"
sleep 5
abort("BYE..")
end


File.open("carte.txt").readlines.each do |carte|
   puts carte
$carte = carte.chomp
if carte.chomp.start_with?('wlan', 'wlx', 'wlp')
   puts "\e[1;32m[*] Wifi card is OK.\e[0m"
else
error()
end
end

puts "Shuting down network manager..."
`service stop networkmanager`
sleep 5
puts "Starting monitor mode"
`ip link set #{$carte} down`
`iw dev #{$carte} set type monitor`
sleep 2
`ip link set #{$carte} up`
sleep 4
sleep 5 # Pour info les sleep sont important car sinon l'action n'a pas le temps de s'éxécuter et il y a erreur pa la suite
puts "\e[1;32m[*] Iniciamos airodump para el scan... ESPERA 1m y deja la ventana de airodump abierta despuès...\e[0m"
system "xterm -geometry '100x80' -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa #{$carte} &> /dev/null &"
sleep 60
puts "Scan terminado, re iniciando la tarjeta wifi"
`killall airodump-ng`
sleep 2
`ip link set #{$carte} down`
`iw dev #{$carte} set type managed`
sleep 2
`ip link set #{$carte} up`
sleep 4
puts "\e[1;32m[*] OK\e[0m"

