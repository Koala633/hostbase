#!/usr/bin/env ruby
require "highline/import"
require 'open3'
require 'monitor'
require './berate'
require './wps'


`rm -rf *.txt`
`cp -R $(pwd) /tmp/`

puts"Paramos network-manager..."
`systemctl stop NetworkManager.service`
sleep 1
`systemctl disable NetworkManager.service`
sleep 4


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





puts 'Entra un numéro con lo se quiere hacer (1,2,3,4 ou 5)'
puts "\e[1;32m[*] Opcion 1: berate_ap ataque clasica\e[0m"
puts "\e[1;32m[*] Opcion 2: WPS PBC loop, esperamos que alguien apoya en boton WPS para recoger la clave wifi\e[0m"
puts "\e[1;32m[*] Opcion 3: berate_ap y despuès: Metasploit / Netcat \e[0m"
puts "\e[1;32m[*] Opcion 4: Scan pasivo: detectara si se inicia una red\e[0m"
puts "\e[1;32m[*] Opcion 5: Salir del script\e[0m"

choice = gets.chomp
case choice
when '1'
  puts 'berate_ap eligido'
  system"ruby scan2g.rb"
when '2'
  puts 'WPS PBC loop!'
  Wps.wpsSuck
when '3'
  puts 'Metasploit/Netcat eligido'
system"ruby metcat.rb"
when '4'
puts 'Scan pasivo eligido'
system"ruby scanpassif.rb"
when '5'
  puts 'BYE...'
  exit
else
  puts "\e[1;31m[*] ERROR: ponga un numero correcto (1,2,3, 4 o 5) !\e[0m"
end
