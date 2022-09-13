#!/bin/bash
killall ruby
rm -rf *.txt
rm -rf /tmp/hostbase-1.5FR
clear
echo -e "\e[1;32m[*] Vous pouvez fermer cette console et relancer hostbase dans une nouvelle console avec: ruby hostbase.rb puis lancer ensuite l'option 0 scan de réseau pour voir quel réseau vient d'apparaitre.\e[0m"
exit
