#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


Dir.chdir '/tmp/hostbase-1.5FR'
sleep 1
if File.exist?("cartef.txt")
Dir.chdir '/tmp'
sleep 1
`rm -rf hostapd.psk`
`rm -rf *.pid`
`killall berate_ap`
`killall hostapd-mana`
`killall dnsspoof`
`killall xterm`
`killall dhcpd`
`killall wash`
Dir.chdir '/tmp/hostbase-1.5FR'
sleep 1
`rm -rf *.pid`
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
puts "Retour a la normale des interfaces wifi..."
`ifconfig #{$cartef} down`
`iw dev #{$cartef} set type managed`
sleep 2
`ip link set #{$cartef} up`
         sleep 2
`ifconfig #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
sleep 2
`ip link set #{$cartedos} up`
         sleep 2         
`systemctl enable NetworkManager.service`
sleep 2
`systemctl start NetworkManager.service`
sleep 4
`rm -rf /var/lib/dhcp/dhcpd.leases`
`rm -rf *.txt`
`killall wash`
`killall bash`
puts "Bye..."
end
end
else
Dir.chdir '/tmp'
sleep 1
`rm -rf hostapd.psk`
`rm -rf *.pid`
`killall berate_ap`
`killall hostapd-mana`
`killall dnsspoof`
`killall xterm`
`killall wash`
Dir.chdir '/tmp/hostbase-1.5FR'
sleep 1
`rm -rf *.pid`
sleep 2
puts "Retour a la normale de l'interfacee wifi..."
File.open("cartedos.txt").readlines.each do |cartedos|
   puts cartedos
$cartedos = cartedos.chomp
`ifconfig #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
sleep 2
`ip link set #{$cartedos} up`
         sleep 3
`systemctl enable NetworkManager.service`
sleep 3
`systemctl start NetworkManager.service`
sleep 5
`rm -rf /var/lib/dhcp/dhcpd.leases`
`killall wash`
`killall bash`
`rm -rf *.txt`
puts"Bye.."
exit
end
end
