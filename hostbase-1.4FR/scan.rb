#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detectée: exit dans 5s.\e[0m"
sleep 5
abort("BYE..")
end


File.open("carte.txt").readlines.each do |carte|
   puts carte
$carte = carte.chomp
if carte.chomp.start_with?('wlan', 'wlx', 'wlp')
   puts "\e[1;32m[*] Vérification de l'interface wifi... OK.\e[0m"
else
error()
end
end


File.open("ghz.txt").readlines.each do |ghz|
   puts ghz
$ghz = ghz.chomp
if ghz.chomp.start_with?('oui', 'non')
   puts "\e[1;32m[*] Vérification de l'option 5GHz...\e[0m"
else
error()
end
end

File.open("ghz.txt").readlines.each do |ghz|
$ghz = ghz.chomp
   if ghz.chomp == "oui"
    puts "\e[1;32m[*]Le scan en 2.4GHz va commencer avant celui en 5GHz...\e[0m"
    puts "Arret de network-manager... (pour éviter les conflits)"
`systemctl stop NetworkManager.service`
sleep 1
`systemctl disable NetworkManager.service`
sleep 4
puts "Lancement du mode monitor..."
`ip link set #{$carte} down`
`iw dev #{$carte} set type monitor`
sleep 5
`ip link set #{$carte} up`# 
sleep 2
puts "\e[1;32m[*] Lancement du scan en 2.4GHz... ATTENDRE 1m et laisser la fenetre de airodump ouverte pour l'utiliser après...\e[0m"
system "xterm -geometry '100x80' -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa #{$carte} &> /dev/null &"
sleep 60
`killall airodump-ng`
puts "\e[1;32m[*] Lancement du scan en 5GHz... ATTENDRE 1m et laisser la fenetre de airodump ouverte pour l'utiliser après...\e[0m"
system "xterm -geometry '100x80' -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa -b a #{$carte} &> /dev/null &"
sleep 60
puts "Retour a la configuration normal de la carte wifi..."
`killall airodump-ng`
sleep 2
`ip link set #{$carte} down`
`iw dev #{$carte} set type managed`
sleep 4
`rfkill unblock all`
`ip link set #{$carte} up`
sleep 2
puts "\e[1;32m[*] OK\e[0m"
    else
    puts "\e[1;32m[*]Pas d'option choisie pour le scan en 5GHz, lancement du scan en 2.4GHz....\e[0m"
puts "Paramos network-manager... (pour éviter les conflits)"
`systemctl stop NetworkManager.service`
sleep 1
`systemctl disable NetworkManager.service`
sleep 4
puts "Lancement du mode monitor..."
`ip link set #{$carte} down`
`iw dev #{$carte} set type monitor`
sleep 5
`ip link set #{$carte} up`# Pour info les sleep sont important car sinon l'action n'a pas le temps de s'éxécuter et il y a erreur pa la suite
puts "\e[1;32m[*] Lancement du scan en 2.4GHz... ATTENDRE 1m et laisser la fenetre de airodump ouverte pour l'utiliser après...\e[0m"
system "xterm -geometry '100x80' -hold -bg '#000000' -fg '#3A94FF' -e airodump-ng --encrypt wpa #{$carte} &> /dev/null &"
sleep 60
puts "Retour a la configuration normal de la carte wifi..."
`killall airodump-ng`
sleep 2
`ip link set #{$carte} down`
sleep 4
`iw dev #{$carte} set type managed`
sleep 5
`rfkill unblock all`
`ip link set #{$carte} up`
sleep 6
puts "\e[1;32m[*] OK\e[0m"
end
end

