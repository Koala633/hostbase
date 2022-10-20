#!/usr/bin/env ruby


require 'highline/import'


def error
puts "\e[1;31m[*] ERREUR détectée: vérifiez vos entrées: sortie du programme dans 5s.\e[0m"
sleep 5
abort("BYE..")
end

puts"Analyse des données reçues..."

File.open("carte.txt").readlines.each do |carte|
   puts carte
$carte = carte.chomp
end

File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
end

# `cat carte.txt cartef.txt > verif.txt` non utile
if File.read('carte.txt').include?('wlan0') and File.read('cartef.txt').include?('wlan2')
puts"wlan1 a été automatiquement sélectionnée pour la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan1") }
elsif File.read('carte.txt').include?('wlan1') and File.read('cartef.txt').include?('wlan2')
puts"wlan0 a été automatiquement sélectionnée pour la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan0") }
elsif File.read('carte.txt').include?('wlan1') and File.read('cartef.txt').include?('wlan0')
puts"wlan2 a été automatiquement sélectionnée pour la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan2") }
elsif File.read('carte.txt').include?('wlan0') and File.read('cartef.txt').include?('wlan1')
puts"wlan2 a été automatiquement sélectionnée pour la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan2") }
elsif File.read('carte.txt').include?('wlan2') and File.read('cartef.txt').include?('wlan1')
puts"wlan0 a été automatiquement sélectionnée pour la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan0") }
elsif File.read('carte.txt').include?('wlan2') and File.read('cartef.txt').include?('wlan0')
puts"wlan1 a été automatiquement sélectionnée pour la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan1") }
else
puts "\e[1;31m[*] ERREUR: vous avez rentré 2 fois la meme carte dans les options !\e[0m"
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6FR`
error()
end
