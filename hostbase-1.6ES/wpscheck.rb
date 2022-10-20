#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detectado: salida dentro 5s.\e[0m"
sleep 5
abort("BYE..")
end


puts "\e[1;33m[*] Interfaz wifi:\e[0m"
system"airmon-ng"
puts "Elige un interfaz wifi para capturar el WPS boton: "
$carte = gets.chomp
puts "#{$carte} para el WPS"
if $carte.chomp.start_with?('wlan', 'wlx', 'wlp')
  `echo #{$carte} > carte.txt`
   puts "\e[1;32m[*] Vérificacion de la interfaz wifi... OK.\e[0m"
   `ifconfig #{$carte} down`
`iw dev #{$carte} set type managed`
sleep 2
`ip link set #{$carte} up`
         sleep 3        
   `touch wps.txt`
   `cp -R $(pwd) *.txt /tmp/hostbase-1.6ES`
else
error()
end
