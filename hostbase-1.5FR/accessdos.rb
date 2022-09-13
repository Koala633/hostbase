#!/usr/bin/env ruby


File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
end