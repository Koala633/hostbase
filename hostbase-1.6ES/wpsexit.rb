#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


if File.exist?("wps.txt")
`killall wpa_supplicant`
`service start networkmanager`
sleep 3
puts "Bye..."
`rm -rf /tmp/hostbase-1.6ES`
exit
else
nil
end
if File.exist?("cartef.txt")
Dir.chdir '/tmp'
sleep 1
`rm -rf *.pid`
#`killall hostapd`
#`killall dnsspoof`
`killall dhcpd`
`killall wash`
`rm -rf *.conf`
Dir.chdir '/tmp/hostbase-1.6ES'
sleep 1
`rm -rf *.pid`
puts "Vuelta a la normal de las interfaz wifi..."
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
`ifconfig #{$cartef} down`
`iw dev #{$cartef} set type managed`
`ip link set #{$cartef} up`
`ifconfig #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
`ip link set #{$cartedos} up`        
`rm -rf /var/lib/dhcp/dhcpd.leases`
`rm -rf *.txt`
`killall bash`
`killall wpa_supplicant`
`service start networkmanager`
sleep 3
puts "Bye..."
`rm -rf /tmp/hostbase-1.6ES`
sleep 5
exit
end
end
else
Dir.chdir '/tmp'
sleep 1
`killall hostapd`
#`rm -rf hostapd.psk`
`rm -rf *.pid`
`rm -rf *.conf`
#`killall berate_ap` # not for wifislax
#`killall hostapd-mana`
#`killall dnsspoof`
#`killall xterm`
#`killall wash`
Dir.chdir '/tmp/hostbase-1.6ES'
sleep 1
`rm -rf *.pid`
sleep 2
puts "Vuelta a la normal de la interfaz wifi..."
File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
`ifconfig #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
`ip link set #{$cartedos} up`
`rm -rf /var/lib/dhcp/dhcpd.leases`
#`killall wash`
#`killall sleep`
`killall bash`
`rm -rf *.txt`
`killall wpa_supplicant`
`service start networkmanager`
sleep 3
puts"Bye.."
`rm -rf /tmp/hostbase-1.6ES`
sleep 5
exit
end
end