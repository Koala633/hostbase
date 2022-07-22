#!/usr/bin/env ruby


require 'gtk2'
require 'open3'
require 'highline/import'


class Wps
def self.wpsSuck 
load 'wpscheck.rb'
puts "\e[1;32m[*] Esperamos de tener una clave wifi usando WPS_PBC any...\e[0m"
`killall wpa_supplicant`
Dir.chdir '/etc'    
sleep 1
`rm -rf wpa_supplicant.conf`
`cp -R /tmp/hostbase-1.5ES/wpa_supplicant.conf /etc/`
sleep 1;
`sudo wpa_supplicant -B -Dnl80211 -i#{$carte} -c/etc/wpa_supplicant.conf`
sleep 2
wpacli = Thread.new do
  while true
    system "wpa_cli -i #{$carte} wps_pbc any" # A CHANGER PAR $BSSID  # On lance wpa_cli et wps_pbc en tant que thread
    sleep(20) # Temps avant la relance de la commande
  end
end
Wps.wpsGrab  # on appelle la fonction dont on a besoin A COMPLETER APRÈS WPA_CLI mettre le trap ici ?
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
end
end
end
