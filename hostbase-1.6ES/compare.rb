#!/usr/bin/env ruby

require 'open3'
require 'highline/import'

def error
puts "\e[1;31m[*] ERROR detectado: salida del script dentro 5s.\e[0m"
sleep 5
abort("BYE..")
end

File.open("ssid.txt").readlines.each do |ssid|
   puts ssid
$ssid = ssid.chomp
end

File.open("ssidf.txt").readlines.each do |ssidf|
   puts ssidf
$ssidf = ssidf.chomp
end

if File.read('ssidf.txt').include?($ssid)
puts "\e[1;32m[*] La red eligida en el scan en 5GHz es la misma que la red en eligida en 2.4GHz... no hay errores.\e[0m"
else
puts "\e[1;31m[*] ERROR: no se ha eligido la misma red en 2.4GHz que en 5GHz.\e[0m"
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6ES`
error()
end