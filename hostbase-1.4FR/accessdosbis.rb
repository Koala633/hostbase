#!/usr/bin/env ruby

File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$carte = cartef.chomp

File.open("cartedos.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
end
end
