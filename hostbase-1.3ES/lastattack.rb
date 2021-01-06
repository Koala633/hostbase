#!/usr/bin/env ruby

require 'open3'
require 'highline/import'
require 'timeout'
require './state'




Timeout::timeout(0) { sleep(600); puts 'Clé non trouvé redémarrage de l attaque!' }

# XDo::Keyboard.char("ctrl+c") #=> sortie de hostbase

File.open("attack.txt").readlines.each do |attack|
puts attack
attack = attack.chomp
if File.read("attack.txt").include?('hostapd')
puts "Restarting hostapd attack..."
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
`killall wpa_supplicant`
`ip link set wlan5 down`
`iw dev wlan5 set type managed`
sleep 5
`ip link set wlan5 up`
sleep 3
`truncate -s 0 hostapd.txt`
sleep 1
Choice.attaque
else
puts "Restarting hostapd 5GHz attack..."
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
load 'accessdosbis.rb'
`killall wpa_supplicant`
`ifconfig #{$cartef} down`
`iw dev #{$cartef} set type managed`
sleep 2
`ip link set #{$cartef} up`
         sleep 2
`ifconfig #{$cartebis} down`
`iw dev #{$cartebis} set type managed`
sleep 2
`ip link set #{$cartebis} up`
         sleep 2         
`truncate -s 0 hostapd.txt`
Choice.attaque
end
end
