#!/usr/bin/env ruby

require 'open3'
require 'highline/import'
require './dos'
require './ghzdos'

class Choice
def self.attaque
if File.read('page.txt').include?('wps')
puts "Hostapd wps"
File.open("attack.txt").readlines.each do |attack|
puts attack
attack = attack.chomp
if File.read("attack.txt").include?('encrypted')
puts "Lancement de hostapd wps attack..."
Setup.interface
else
puts "Lancement de hostapd wps 5GHz attack..."
Start.interface
end
end
else
puts "Hostapd clé"
File.open("attack.txt").readlines.each do |attack|
puts attack
attack = attack.chomp
if File.read("attack.txt").include?('hostapd')
puts "Starting hostapd key attack..."
Setup.interface
else
puts "Starting airbase-ng key attack..."
Cle.airbase
end
end
end
end
end
