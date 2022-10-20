#!/usr/bin/env ruby


require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detectado: salida dentro 5s.\e[0m"
sleep 5
abort("BYE..")
end

puts"Analizando los datos..."

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
puts"wlan1 para la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan1") }
elsif File.read('carte.txt').include?('wlan1') and File.read('cartef.txt').include?('wlan2')
puts"wlan0 para la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan0") }
elsif File.read('carte.txt').include?('wlan1') and File.read('cartef.txt').include?('wlan0')
puts"wlan2 para la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan2") }
elsif File.read('carte.txt').include?('wlan0') and File.read('cartef.txt').include?('wlan1')
puts"wlan2 para la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan2") }
elsif File.read('carte.txt').include?('wlan2') and File.read('cartef.txt').include?('wlan1')
puts"wlan0 para la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan0") }
elsif File.read('carte.txt').include?('wlan2') and File.read('cartef.txt').include?('wlan0')
puts"wlan1 para la deauth en 2.4GHz"
File.open("cartedos.txt", "w+") { |file| file.write("wlan1") }
else
puts "\e[1;31m[*] ERROR: has entrado dos veces la misma interfaz en la opciones, eso no se puede !\e[0m"
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6ES`
error()
end
