#!/usr/bin/env ruby


  file = "metasploit.txt"
  file = "netcat.txt"
  if File.exist?("metasploit.txt")
  puts "Lancement de metasploit en reverse shell... config par défaut LHOST: 175.0.0.1 LPORT: 4444"
system"x-terminal-emulator -e msfconsole -r /tmp/hostbase-1.6FR/metasploit.rc &> /dev/null &"
elsif File.exist?("netcat.txt")
  puts "Lancement de netcat, config par défaut LHOST: 175.0.0.1 LPORT: 4444"
`iptables -A INPUT -s 175.0.0.1 -p tcp -m tcp --dport 4444 -j ACCEPT`
system"x-terminal-emulator -e nc -l -v -n -p 4444 &> /dev/null &"
else
nil
end