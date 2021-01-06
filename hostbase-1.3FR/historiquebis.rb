#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


File.open("cartebis.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
end
