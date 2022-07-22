#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'

File.open("carte.txt").readlines.each do |carte|
   puts carte
$carte = carte.chomp
if File.exist?("cartedos.txt")
  puts 'Mode mult AP detected'# Le multi AP de hostapd a besoin de renommer les interfaces en wlan1 wlan2 etc..., par conséquent on rennomme la seconde interface a été renommée en wlan5 dans le script rogue.rb pour éviter les conflits avec hostapd.
File.open("cartedos.txt", "w+") { |file| file.write("wlan5") }
elsif "wlan0" === carte.chomp
  puts 'Wlan0 in use'
File.open("cartedos.txt", "w+") { |file| file.write("wlan1") }
elsif "wlan1" === carte.chomp
  puts 'Wlan1 in use'
File.open("cartedos.txt", "w+") { |file| file.write("wlan0") }
else
  puts "\e[1;31m[*] ERROR detected: unable to detect your second wifi-card...Take manual control !\e[0m"
sleep 7
end
end

File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
end
