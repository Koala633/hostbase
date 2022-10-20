#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERREUR détectée: vérifiez vos entrées: sortie du programme dans 5s.\e[0m"
sleep 5
abort("BYE..")
end

WAIT_FOR_WASH = 60 #secondes

# Bloc a rajouter en cas de problème de sélection des interfaces

# puts "\e[1;33m[*] Cartes disponibles:\e[0m"
# system"airmon-ng"
# puts "Entrez la carte wifi qui va servir pour la deauth de l'AP réel en 2.4GHz: "
# $cartedos = gets.chomp
# puts "#{$cartedos} a été sélectionnée pour la deauth en 2.4GHz"
# if $cartedos.chomp.start_with?('wlan', 'wlx', 'wlp')
#  `echo #{$cartedos} > cartedos.txt`
#   puts "\e[1;32m[*] Vérification de l'interface wifi... OK.\e[0m"
# else
# `rm -rf *.txt`
# `rm -rf /tmp/hostbase-1.6FR`
# error()
# end


puts "\e[1;33m[*] Cartes disponibles:\e[0m"
system"airmon-ng"
puts "Entrez une carte wifi pour le scan de réseau en 5GHz: "
$wlan_name = gets.chomp
puts "#{$wlan_name} a été sélectionnée pour la deauth en 5GHz"
if $wlan_name.chomp.start_with?('wlan', 'wlx', 'wlp')
  `echo #{$wlan_name} > cartef.txt`
   puts "\e[1;32m[*] Vérification de l'interface wifi... OK.\e[0m"
else
error()
end


def get_wlan_interface
      wlan_interface = $wlan_name
  if wlan_interface[wlan_interface.length-3..-1] == 'mon'
    monitor_enabled = true
  else
    monitor_enabled = false
  end
  if wlan_interface.length > 0
    if monitor_enabled
      puts "Carte en mode moniteur: #{wlan_interface}"
    else
      puts "Carte sélectionnée: #{wlan_interface}"
    end
  else
    puts "Pas de carte trouvée, exit..."
    exit!
  end
  {
      name: wlan_interface,
      monitor: monitor_enabled
  }
end

def run_airmon_zc(wlan_name)
  `ip link set #{wlan_name} down`.delete! ":"
  puts "Lancement du mode moniteur sur: #{wlan_name}".delete! ":"
  system("iw dev #{wlan_name} set type monitor")
  `ip link set #{wlan_name} up`.delete! ":"
end

def run_wash(wlan_name)
  puts"#{wlan_name}".delete! ":"
#  system("wash -i #{wlan_name} &")
  cmd = "wash -5 -i #{wlan_name}"
  puts "Lancement de wash: #{cmd} , attendez #{WAIT_FOR_WASH} secondes avant de voir les réseaux s'afficher..."
# sleep 30
  p = IO.popen(cmd)
  process_line = false
  wifi_points = []

  Thread.new do
    p.each_line do |line|
      if process_line
        wifi_hash = process_wash_line(line)
        if wifi_hash[:locked] == "No" or wifi_hash[:locked] == "Yes"
          wifi_points << wifi_hash
        end
      end
      if line.include?('-------')
        process_line = true
      end
    end
  end

  Thread.new do
    start_time = Time.now
    while true do
      sleep(5)
      diff = Time.now - start_time
      print "%.0f" % diff + '... '
      if diff > WAIT_FOR_WASH
        puts "\nArret de wash"
        `killall wash`
        break
      end
    end
  end.join

  wifi_points
end

def process_wash_line(line)
  fields = line.split(" ")
  wifi_point = {
      bssid: fields[0],
      channel: fields[1],
      power: fields[2],
      version: fields[3],
      locked: fields[4],
      vendor: fields[5],
      essid: fields[6]
  }
  wifi_point
end

def select_point_to_crack(access_points, wlan_iface_name)
  access_points = access_points.sort_by { |access_point| access_point[:power] }
  puts "Faites un choix (entre 0 et #{access_points.length - 1}):"
  access_points.each_with_index do |access_point, idx|
    puts "#{idx}. #{access_point[:essid]} #{access_point[:vendor]} #{access_point[:bssid]} #{access_point[:power]}dB Canal: #{access_point[:channel]}"
  end
  print "Entrez un nombre correspondant au réseau que vous avez choisi précédemment (le réseau doit logiquement etre le meme que celui choisi en 2.4GHz):"
  n = input_number(access_points.length)
  point_to_crack = access_points[n]
 `echo #{point_to_crack[:channel]} > canalf.txt`
 `echo #{point_to_crack[:bssid]} > bssidf.txt`
 `echo #{point_to_crack[:essid]} > ssidf.txt`
  puts "Enregistrement des paramètres en 5GHz pour le réseau #{point_to_crack[:essid]}"
end

def input_number(max)
  while true
    input = gets
    if input.match(/^\d+$/)
      n = input.to_i
      if n < max
        break
      end
    end
    print "Rentrez un nombre entre 0 et #{max - 1}:"
  end
  n
end

# check_packages
wlan_iface = get_wlan_interface
wlan_iface_name = wlan_iface[:name]
if !wlan_iface[:monitor]
  run_airmon_zc(wlan_iface[:name])
  wlan_iface_name += ''
end
wifi_access_points = run_wash(wlan_iface_name)
select_point_to_crack(wifi_access_points, wlan_iface_name)

