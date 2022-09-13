#!/usr/bin/env ruby
require "highline/import"
require 'open3'
require 'monitor'
require './berate'
require './wps'

`cp -R $(pwd) /tmp/`

 puts"█                           █"
 puts"█                      █    █"
 puts"█                      █    █"
 puts"█▒██▒   ███   ▒███▒  █████  █▓██   ░███░  ▒███▒   ███"
 puts"█▓ ▒█  █▓ ▓█  █▒ ░█    █    █▓ ▓█  █▒ ▒█  █▒ ░█  ▓▓ ▒█"
 puts"█   █  █   █  █▒░      █    █   █      █  █▒░    █   █"
 puts"█   █  █   █  ░███▒    █    █   █  ▒████  ░███▒  █████"
 puts"█   █  █   █     ▒█    █    █   █  █▒  █     ▒█  █"
 puts"█   █  █▓ ▓█  █░ ▒█    █░   █▓ ▓█  █░ ▓█  █░ ▒█  ▓▓  █"
 puts"█   █   ███   ▒███▒    ▒██  █▓██   ▒██▒█  ▒███▒   ███▒"





puts 'Choisissez une option en tapant le chiffre correspondant a ce que vous voulez faire (0,1,2,3,4 ou 5)'
puts "\e[1;32m[*] Choix 0: scan de réseau\e[0m"
puts "\e[1;32m[*] Choix 1: berate_ap attaque classique\e[0m"
puts "\e[1;32m[*] Choix 2: WPS PBC loop, lance une boucle WPS_PBC de manière a capturer une connexion via WPS\e[0m"
puts "\e[1;32m[*] Choix 3: berate_ap et ensuite lancement de: Metasploit / Netcat \e[0m"
puts "\e[1;32m[*] Choix 4: Scan passif: détectera un réseau qui vient de spawn\e[0m"
puts "\e[1;32m[*] Choix 5: quitter le programme\e[0m"

choice = gets.chomp
case choice
when '0'
  puts 'Scan de réseau'
  system"ruby scan.rb"
when '1'
  puts 'berate_ap sélectionné'
  Berate.berateNormal
when '2'
  puts 'WPS PBC loop!'
  Wps.wpsSuck
when '3'
  puts 'Metasploit/Netcat choisi'
system"ruby metcat.rb"
when '4'
puts 'Scan passif choisi'
system"ruby scanpassif.rb"
when '5'
  puts 'BYE...'
  exit
else
  puts "\e[1;31m[*] ERREUR: merci de sélectionner une option correcte (0,1,2,3, 4 ou 5) !\e[0m"
end
