#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detected: check ALL your entry will abort in 5s.\e[0m"
sleep 5
abort("BYE..")
end


puts "\e[1;33m[*] Cartes disponibles:\e[0m"
system"airmon-ng"
puts "Entrez une carte wifi pour lancer des requetes WPS: "
$carte = gets.chomp
puts "#{$carte} a été sélectionnée pour lancer des requetes WPS"
if $carte.chomp.start_with?('wlan', 'wlx', 'wlp')
  `echo #{$carte} > carte.txt`
   puts "\e[1;32m[*] Vérification de l'interface wifi... OK.\e[0m"
   `ifconfig #{$carte} down`
`iw dev #{$carte} set type managed`
sleep 2
`ip link set #{$carte} up`
         sleep 3        
   `touch wps.txt`
   `cp -R $(pwd) *.txt /tmp/hostbase-1.6FR`
else
error()
end
