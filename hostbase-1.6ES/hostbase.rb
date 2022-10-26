#!/usr/bin/env ruby
require "highline/import"
require 'open3'
require 'monitor'
require './berate'
require './wps'

install = "install.txt"
if File.exist?("install.txt")
nil
else
`rm -rf *.txt`
`cp -R $(pwd) /tmp/`
end

puts"Paramos network-manager..."
`service stop networkmanager`
sleep 3


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





puts 'Entra un numéro con lo se quiere hacer (1,2, o 3)'
puts "\e[1;32m[*] Opcion 1: crear fake AP con hostapd\e[0m"
puts "\e[1;32m[*] Opcion 2: WPS PBC loop, esperamos que alguien apoya en boton WPS para recoger la clave wifi\e[0m"
puts "\e[1;32m[*] Opcion 3: Salir del script\e[0m"

choice = gets.chomp
case choice
when '1'
  puts 'hostapd eligido'
  system"ruby scan2g.rb"
when '2'
  puts 'WPS PBC loop!'
  Wps.wpsSuck
when '3'
  puts 'reiniciando network-manager...'
  `service start networkmanager`
  `rm -rf /tmp/hostbase-1.6ES`
  puts 'BYE...'
  exit
else
  puts "\e[1;31m[*] ERROR: ponga un numero correcto (1,2,3, 4 o 5) !\e[0m"
end
