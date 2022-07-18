#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'

if File.exist?("cartedos.txt")
File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
end

File.open("apmac.txt").readlines.each do |apmac|
   puts apmac
$apmac = apmac.chomp
end

page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
end
else
File.open("cartebis.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
end

File.open("apmac.txt").readlines.each do |apmac|
   puts apmac
$apmac = apmac.chomp
end

page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
end
end
