#!/usr/bin/env ruby

require 'open3'
require 'highline/import'

def error
puts "\e[1;31m[*] ERREUR détectée: vérifiez vos entrées: sortie du programme dans 5s.\e[0m"
sleep 5
abort("BYE..")
end

File.open("ssid.txt").readlines.each do |ssid|
   puts ssid
$ssid = ssid.chomp
end

File.open("ssidf.txt").readlines.each do |ssidf|
   puts ssidf
$ssidf = ssidf.chomp
end

if File.read('ssidf.txt').include?($ssid)
puts "\e[1;32m[*] Le réseau sélectionné lors du scan en 5GHz est le meme qu'en 2.4GHz... pas d'erreur détecté.\e[0m"
else
puts "\e[1;31m[*] ERREUR: vous n'avez pas sélectionner le meme réseau en 2.4GHz qu'en 5GHz.\e[0m"
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6FR`
error()
end