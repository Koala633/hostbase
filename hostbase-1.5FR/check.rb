#!/usr/bin/env ruby


require 'open3'
require 'highline/import'


def error
puts "\e[1;31m[*] ERREUR détectée: vérifiez vos entrées: sortie du programme dans 5s.\e[0m"
sleep 5
abort("BYE..")
end



# déclaration globales des variables a utiliser de manière a éviter les fonctions récurrentes.

puts "Entrez une carte wifi pour créer votre fake AP: "
$carte = gets.chomp
puts "#{$carte} a été sélectionnée pour créer votre fake AP"
if $carte.chomp.start_with?('wlan', 'wlx', 'wlp')
  `echo #{$carte} > carte.txt`
   puts "\e[1;32m[*] Vérification de l'interface wifi... OK.\e[0m"
else
error()
end

puts "Entrez un nom (SSID) pour créer votre fake AP: "
$ssid = gets.chomp
puts "Le #{$ssid} a été sélectionné pour créer votre fake AP"
`echo #{$ssid} > ssid.txt`
puts "\e[1;32m[*] SSID... OK.\e[0m"



puts "Entrez le canal de votre fake AP entre 1 et 13: (le canal doit IMPÉRATIVEMENT etre différent de celui de l'AP réel)"
$canal = gets.chomp
puts "Le canal #{$canal} a été sélectionné pour créer votre fake AP"
if $canal.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Canal... OK.\e[0m"
else
error()
end


puts "Entrez la page de phishing a utiliser: "
$page = gets.chomp
puts "#{$page} a été sélectionné comme page de phishing de votre fake AP"
if $page.chomp.start_with?('liveboxwp', 'sfrwp', 'bboxwp', 'freewp', '404', 'sncf', 'microsoft')
   puts "\e[1;32m[*] Page de phishing... OK.\e[0m"
else
error()
end


puts "Entrez le BSSID de la fréquence 2.4GHz du réseau ciblé: "
$apmac = gets.chomp
puts "Le BSSID #{$apmac} a été sélectionné pour attaquer le réseau ciblé"
if $apmac.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
   puts "\e[1;32m[*] BSSID de l'AP réel... OK.\e[0m"
   `echo #{$apmac} > apmac.txt`
else
error()
end


puts "Entrez le canal de la fréquence 2.4GHz du réseau ciblé: "
$apcanal = gets.chomp
puts "Le canal #{$apcanal} a été sélectionné pour attaquer le réseau ciblé"
if $apcanal.chomp.to_i.between?(1, 13)
   puts "\e[1;32m[*] Canal... OK.\e[0m"
   `echo #{$apcanal} > apcanal.txt`
else
error()
end

if File.read('carte.txt').include?('wlan0')
  `echo wlan1 > cartedos.txt`
else
  `echo wlan0 > cartedos.txt`
end 

puts "\e[1;94m[*] Voulez-vous attaquez le réseau ciblé aussi sur les fréquences 5GHz ?: oui,non (nécessite une 3e carte wifi dont une carte wifi compatible 5GHz): \e[0m"
  choix = gets.chomp
  case choix

  when 'oui'
    puts "Vous avez choisi d'attaquer le réseau ciblé également sur les fréquences 5GHz"
    puts "Entrez le BSSID de la fréquence 5GHz du réseau ciblé (différent du BSSID de la fréquence en 2.4GHz): "
    $bssid5ghz = gets.chomp
    puts "Le BSSID #{$bssid5ghz} a été sélectionné pour attaquer le réseau ciblé sur la fréquence 5GHz"
    if $bssid5ghz.chomp =~ /^([0-9a-fA-F]{2}[:-]){5}[0-9a-fA-F]{2}$/i
     puts "\e[1;32m[*] BSSID 5GHz de l'AP réel... OK.\e[0m"
     `echo #{$bssid5ghz} > bssidf.txt`
    else
    error()
    end

    puts "Entrez le canal de la fréquence 5GHz du réseau ciblé: "
    $canal5ghz = gets.chomp
    puts "Le canal #{$canal5ghz} a été sélectionné pour attaquer le réseau ciblé sur la fréquence 5GHz"
    if $canal5ghz.chomp.to_i.between?(36, 190)
     puts "\e[1;32m[*] Canal... OK.\e[0m"
     `echo #{$canal5ghz} > canalf.txt`
    else
    error()
    end

    puts "Entrez la carte wifi pour la deauth en 2.4Ghz: "
    $cartedos = gets.chomp
    puts "#{$cartedos} a été sélectionnée pour la deauth en 2.4GHz"
    if $cartedos.chomp.start_with?('wlan', 'wlx', 'wlp')
     puts "\e[1;32m[*] Vérification de l'interface wifi pour la deauth en 2.4GHz... OK.\e[0m"
     `echo #{$cartedos} > cartedos.txt`
    else
    error()
    end

    puts "Entrez la carte wifi pour la deauth en 5Ghz: "
    $dos5ghz = gets.chomp
    puts "#{$dos5ghz} a été sélectionnée pour la deauth en 5GHz"
    if $dos5ghz.chomp.start_with?('wlan', 'wlx', 'wlp')
     puts "\e[1;32m[*] Vérification de l'interface wifi pour la deauth en 5GHz... OK.\e[0m"
     `echo #{$dos5ghz} > cartef.txt`
     `cp -R $(pwd) *.txt /tmp/hostbase-1.5FR`
    else
    error()
    end
  when 'non'
    puts "Vous avez choisi d'attaquer le réseau ciblé uniquement sur les fréquences 2.4GHz"
    `cp -R $(pwd) *.txt /tmp/hostbase-1.5FR`
    else
    puts "\e[1;31m[*] ERREUR: merci de sélectionner une option correcte (oui,non) !\e[0m"
  end
