#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detectée: vérifiez les données, exit dans 5s.\e[0m"
sleep 5
abort("BYE..")
end

File.open("ssid.txt").readlines.each do |ssid|
   puts ssid
$ssid = ssid.chomp
end

File.open("apcanal.txt").readlines.each do |apcanal|
   puts apcanal
$apcanal = apcanal.chomp
if apcanal.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Canal OK.\e[0m"
else
error()
end
end

File.open("apmac.txt").readlines.each do |apmac|
   puts apmac
$apmac = apmac.chomp
if apmac.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] Ap mac OK.\e[0m"
else
error()
end
end


File.open("carte.txt").readlines.each do |carte|
   puts carte
$carte = carte.chomp
if carte.chomp.start_with?('wlan', 'wlx', 'wlp')
   puts "\e[1;32m[*] Interface wifi OK.\e[0m"
else
error()
end
end


File.open("canal.txt").readlines.each do |canal|
   puts canal
$canal = canal.chomp
if canal.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Canal OK.\e[0m"
else
error()
end
end
