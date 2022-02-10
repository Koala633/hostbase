#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
if page.chomp.start_with?('livebox', 'sfr', 'bbox', 'free', '404', 'sncf')
nil
else
error()
end
end
