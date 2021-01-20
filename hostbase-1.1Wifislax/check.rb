#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detected: check ALL your entry will abort in 5s.\e[0m"
sleep 5
abort("BYE..")
end

# déclaration globales des variables a utiliser de manière a éviter les fonctions récurrentes.


File.open("apcanal.txt").readlines.each do |apcanal|
   puts apcanal
$apcanal = apcanal.chomp
if apcanal.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Ap channel is OK.\e[0m"
else
error()
end
end

File.open("apmac.txt").readlines.each do |apmac|
   puts apmac
$apmac = apmac.chomp
if apmac.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] Ap mac is OK.\e[0m"
else
error()
end
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

page = "page.txt"
if File.exist?("page.txt")
page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
if page.chomp.start_with?('movistar', 'jazztel', 'vodafone', 'orange', 'ono', '404')
   puts "\e[1;32m[*] Phishing page is OK.\e[0m"
else
error()
end
end

File.open("canal.txt").readlines.each do |canal|
   puts canal
$canal = canal.chomp
if canal.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Channel is OK.\e[0m"
else
error()
end
end


File.open("ssid.txt").readlines.each do |ssid|
   puts ssid
$ssid = ssid.chomp

file = "mac.txt"
if File.exist?("mac.txt")
file = File.open("mac.txt").readlines.each do |mac|
   puts mac
$mac = mac.chomp
if mac.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] Your mac is OK.\e[0m"
else
error()
end
end
end
end
end
Dir.chdir '/tmp/hostbase-1.1'
sleep 1
`touch cartedos.txt`


if $carte.include?('wlan0')
puts "Falso AP en wlan0, cambiamos el falso AP en wlan0 para no tener conflicto y errores despuès..."
`ifconfig wlan1 down`
       `ip link set wlan1 name wlan5`
       `ifconfig wlan5 up`
         sleep 4
else
puts "Cambiamos el falso AP en wlan0 para no tener conflicto y errores despuès..."
`ifconfig wlan0 down`
`ip link set wlan0 name wlan5`
`ifconfig wlan5 up`
         sleep 4
puts $carte
`ifconfig #{$carte} down`
`ip link set #{$carte} name wlan0`
`ifconfig wlan0 up`
         sleep 4
end
