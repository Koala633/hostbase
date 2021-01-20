#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'




page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
if page.chomp.start_with?('movistar', 'jazztel', 'vodafone', 'orange', 'ono', '404')
nil
else
error()
end
end
