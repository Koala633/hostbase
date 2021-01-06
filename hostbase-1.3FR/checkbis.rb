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
if page.chomp.start_with?('livebox', 'sfr', 'bbox', 'free', '404', 'sncf')
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


File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$carte = cartef.chomp
if cartef.chomp.start_with?('wlan', 'wlx', 'wlp')
   puts "\e[1;32m[*] Wifi card is OK.\e[0m"
else
error()
end
end

File.open("bssidf.txt").readlines.each do |bssidf|
   puts bssidf
$bssidf = bssidf.chomp
if bssidf.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] Ap mac is OK.\e[0m"
else
error()
end
end

File.open("canalf.txt").readlines.each do |canalf|
   puts canalf
$apcanal = canalf.chomp
if canalf.chomp.to_i.between?(15, 165)
   puts "\e[1;32m[*] Ap channel is OK.\e[0m"
else
error()
end
end

File.open("cartebis.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
if cartebis.chomp.start_with?('wlan', 'wlx', 'wlp')
   puts "\e[1;32m[*] Wifi card is OK.\e[0m"
else
error()
end
end
end
end

