#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'



File.open("carte.txt").readlines.each do |carte|
   puts carte
$carte = carte.chomp
if carte.chomp.start_with?('wlan', 'wlx', 'wlp')
   puts "\e[1;32m[*] Wifi card is OK.\e[0m"
end
end
