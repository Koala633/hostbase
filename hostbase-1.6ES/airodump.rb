#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


sleep 5
puts"Esperamos la red... (se dectara 2 minutos despuès para estar seguro)..."
until File.read('airodump.txt').include?('0d 00:02:')  # 0d 00:02:00
sleep 1
end
puts "\e[1;32m[*] Nueva red detectada...\e[0m"
`wmctrl -r :ACTIVE: -b remove,fullscreen`
system"ffplay manau.mp3 &> /dev/null &"
sleep 10
system"xterm -geometry '150x20' -hold -e bash infos2.sh &> /dev/null &"
File.open("cartescanpassif.txt").readlines.each do |carte|
   puts carte
$carte = carte.chomp
puts "Vuelta a la normal de la tarjeta wifi..."
`killall airodump-ng`
sleep 2
`ip link set #{$carte} down`
`iw dev #{$carte} set type managed`
sleep 4
`rfkill unblock all`
`ip link set #{$carte} up`
sleep 4
puts "\e[1;32m[*] OK\e[0m"
system"bash wait.sh"
end
