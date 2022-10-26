#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


Dir.chdir '/tmp/hostbase-1.6ES'
sleep 1
if File.exist?("cartef.txt")
Dir.chdir '/tmp'
sleep 1
`rm -rf *.pid`
`killall hostapd`
`killall dnsspoof`
`killall dhcpd`
`killall wash`
`service stop httpd`
sleep 4
Dir.chdir '/tmp/hostbase-1.6ES'
sleep 1
`rm -rf *.pid`
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
puts "Vuelta a la normal de las tarjetas wifi..."
`ifconfig #{$cartef} down`
`iw dev #{$cartef} set type managed`
`ip link set #{$cartef} up`
`ifconfig #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
`ip link set #{$cartedos} up`        
`service start networkmanager`
sleep 3
`rm -rf /var/lib/dhcp/dhcpd.leases`
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6ES`
`killall bash`
puts "Bye..."
end
end
else
Dir.chdir '/tmp'
sleep 1
`rm -rf *.pid`
`killall dnsspoof`
# `killall xterm`
`killall dhcpd`
`killall wash`
`service stop httpd`
sleep 4
Dir.chdir '/tmp/hostbase-1.6ES'
sleep 1
`rm -rf *.pid`
sleep 2
puts "Vuelta a la normal de la tarjeta wifi..."
File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
`ifconfig #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
`ip link set #{$cartedos} up`
`service start networkmanager`
sleep 3
`rm -rf /var/lib/dhcp/dhcpd.leases`
`killall bash`
`rm -rf *.txt`
`rm -rf /tmp/hostbase-1.6ES`
puts"Bye.."
exit
end
end