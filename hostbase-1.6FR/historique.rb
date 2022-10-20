#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
end

File.open("bssid.txt").readlines.each do |bssid|
   puts bssid
$bssid = bssid.chomp
end
