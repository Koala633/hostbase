#!/usr/bin/env ruby
require "highline/import"
require 'open3'
require 'monitor'
require './berate'


puts 'Choisissez une option en tapant le chiffre correspondant a ce que vous voulez faire (1,2 ou 3)'
puts "\e[1;32m[*] Choix 1: lancer le rogue AP et ensuite metaploit (configuration reverse shell par défaut)\e[0m"
puts "\e[1;32m[*] Choix 2: lancer le rogue AP et ensuite netcat IP: 175.0.0.1 et port d'écoute par défaut: 4444) \e[0m"
puts "\e[1;32m[*] Choix 3: quitter le programme\e[0m"

choice = gets.chomp
case choice
when '1'
  puts 'Metasploit sera lancé après le rogue AP... (option: reverse shell par défaut, LHOST: 175.0.0.1, LPORT: 4444)'
`touch metasploit.txt`
system"ruby scan2g.rb"
when '2'
  puts 'Netcat sera lancé après le rogue AP (port par défaut: 4444)'
`touch netcat.txt`
system"ruby scan2g.rb"
when '3'
  puts 'BYE...'
  exit
else
  puts "\e[1;31m[*] ERREUR: merci de sélectionner une option correcte (1,2 ou 3) !\e[0m"
end
