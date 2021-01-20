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


File.open("canal.txt").readlines.each do |canal|
   puts canal
$canal = canal.chomp
if canal.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Rogue channel is OK.\e[0m"
else
error()
end
end



page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
if page.chomp.start_with?('movistar', 'jazztel', 'vodafone', 'orange', 'ono', '404')
   puts "\e[1;32m[*] Phishing page is OK.\e[0m"
else
error()
end
end


File.open("ssid.txt").readlines.each do |ssid|
   puts ssid
$ssid = ssid.chomp
puts "\e[1;32m[*] SSID 1 is OK.\e[0m"


pagebis = File.open("pagebis.txt").readlines.each do |pagebis|
  puts pagebis
$pagebis = pagebis.chomp
if pagebis.chomp.start_with?('movistar', 'jazztel', 'vodafone', 'orange', 'ono', '404')
   puts "\e[1;32m[*] Phishing page is OK.\e[0m"
else
error()
end
end

file = "apmacbis.txt"
if File.exist?("apmacbis.txt")
file = File.open("apmacbis.txt").readlines.each do |apmacbis|
  puts apmacbis
$apmacbis = apmacbis.chomp
if apmacbis.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] Ap mac number 2 is OK.\e[0m"
else
error()
end
end
end


file = "apcanal.txt"
if File.exist?("apcanal.txt")
file = File.open("apcanal.txt").readlines.each do |apcanal|
  puts apcanal
$apcanal = apcanal.chomp
if apcanal.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Channel of ap 1 is OK.\e[0m"
else
error()
end
end
end


File.open("ssidbis.txt").readlines.each do |ssidbis|
   puts ssidbis
$ssidbis = ssidbis.chomp
puts "\e[1;32m[*] SSID 2 is OK.\e[0m"

File.open("apmac.txt").readlines.each do |apmac|
   puts apmac
$apmac = apmac.chomp
if apmac.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] Ap mac number 1 is OK.\e[0m"
else
error()
end
end
end


file = "mac1ssid1.txt"
if File.exist?("mac1ssid1.txt")
file = File.open("mac1ssid1.txt").readlines.each do |mac1ssid1|
  puts mac1ssid1
$mac1ssid1 = mac1ssid1.chomp
if mac1ssid1.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] User mac 1 is OK.\e[0m"
else
error()
end
end
end



file = "mac2ssid1.txt"
if File.exist?("mac2ssid1.txt")
file = File.open("mac2ssid1.txt").readlines.each do |mac2ssid1|
  puts mac2ssid1
$mac2ssid1 = mac2ssid1.chomp
if mac2ssid1.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] User mac 2 is OK.\e[0m"
else
nil
end
end
end


file = "mac3ssid1.txt"
if File.exist?("mac3ssid1.txt")
file = File.open("mac3ssid1.txt").readlines.each do |mac3ssid1|
  puts mac3ssid1
$mac3ssid1 = mac3ssid1.chomp
if mac3ssid1.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] User mac 3 is OK.\e[0m"
else
nil
end
end
end


file = "apmacbis.txt"
if File.exist?("apmacbis.txt")
file = File.open("apmacbis.txt").readlines.each do |apmacbis|
  puts apmacbis
$apmacbis = apmacbis.chomp
if apmacbis.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] Ap mac number 2 is OK.\e[0m"
else
error()
end
end
end




File.open("apcanalbis.txt").readlines.each do |apcanalbis|
   puts apcanalbis
$apcanalbis = apcanalbis.chomp
if apcanalbis.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Channel of AP 2 is OK.\e[0m"
else
error()
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
