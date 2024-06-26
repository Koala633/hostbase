import os
import subprocess
import time
import sys
import signal

GREEN = "\033[32m"
RED = "\033[31m"
RESET = "\033[0m"


print(f"{RESET}Clean up...")
### Uncomment the following lines if you use berate-ap (Kali) instead of a sample Hostapd package.
# os.system("killall berate_ap")
# os.system("killall hostapd-mana")
os.system("killall hostapd")
os.system("killall dnsspoof")
os.system("killall xterm")
os.system("killall dhcpd")
os.system("killall wash")
os.system("killall dhcpd")
os.system("rm -rf dhcpd.conf")
os.system("rm -rf /tmp/hostapd.conf")
os.system("rm -rf /var/lib/dhcp/dhcpd.leases")
os.system("rm -rf /tmp/*.pid")
os.system("rm -rf /tmp/*sid")
os.system("mv ssid.txt ssid")
os.system("rm -rf *.txt")
os.system("rm -rf *.csv")
os.system("rm -rf *.conf")
os.system("rm -rf domesticmode")
os.system("rm -rf cinqgscanfait")
print('Restarting wifi card as normal...')
if os.path.isfile('cinqgcarte'):
    with open("cinqgcarte", "r") as c:
        cinq = c.read()

    with open("deuxgcarte", "r") as d:
        deux = d.read()
    print("Reseting wifi cards as default configuration...")
    os.system("rm -rf finalchoice2g")
    os.system("rfkill unblock all")
    os.system("ip link set" + " " + cinq + " " + "down")
    os.system("iw dev" + " " + cinq + " " + "set type managed")
    time.sleep(3)
    os.system("ip link set" + " " + cinq + " " + "up")
    time.sleep(3)
    os.system("ip link set" + " " + deux + " " + "down")
    os.system("iw dev" + " " + deux + " " + "set type managed")
    time.sleep(3)
    os.system("ip link set" + " " + deux + " " + "up")
    time.sleep(3)
    os.system("killall bash")
    print("Restarting network-manager...")
    os.system("systemctl enable NetworkManager.service")
    time.sleep(2)
    os.system("systemctl start NetworkManager.service")
    time.sleep(4)


else:
    print("Reseting the other wifi card as default configuration...")
    with open("deuxgcarte", "r") as d:
        deux = d.read()
    os.system("ip link set" + " " + deux + " " + "down")
    os.system("iw dev" + " " + deux + " " + "set type managed")
    time.sleep(3)
    os.system("ip link set" + " " + deux + " " + "up")
    time.sleep(3)
    print("Restarting network-manager...")
    os.system("systemctl enable NetworkManager.service")
    time.sleep(2)
    os.system("systemctl start NetworkManager.service")
    time.sleep(4)


# connexion pour le flag : wps ou wpa3
if os.path.isfile('/home/wpa_supplicant.conf'):
    print(f"{GREEN}Connecting to the cracked network... wait...")
    dataLog = []
    with open('/home/wpa_supplicant.conf', 'rt') as f:
        data = f.readlines()
        for line in data:
            if 'psk=' in line:
                print(line)
                f = open(f'wpakey.txt', 'w+')
                f.write(line)
                f.close()

    os.system("sed -i -e 's/\(psk=\)//g' wpakey.txt")
    os.system("awk 'NF' wpakey.txt > wpakeyy.txt")
    os.system("rm -rf wpakey.txt")
    os.system("mv wpakeyy.txt wpakey.txt")
    os.system("sed -r 's/\s+//g' wpakey.txt > key.txt")
    wps = subprocess.Popen("bash connectwps.sh", shell=True)
    sys.exit()
elif os.path.isfile('/home/cle.txt'):
    print(f"{GREEN}Connecting to the cracked network... wait...")
    os.system("killall mdk3")
    os.system("killall mdk4")
    os.system("mv /home/cle.txt key.txt")
    with open('hostapdcarte') as h:
        hc = h.readline()
        print(hc)

    with open("ssid", "r") as co:
        ssid = co.read()
        print(ssid)

    with open('key.txt') as k:
        cle = k.readline()
        print(cle)

    os.system('sudo nmcli device wifi rescan ifname {} ssid {}'.format(hc, ssid))
    time.sleep(2)
    # sudo nmcli dev wifi connect nom_du_réseau password "supersecret"
    os.system('sudo nmcli dev wifi connect {} password {}'.format(ssid, cle))
    time.sleep(8)
    print(f"{RESET}All task are done... bye")
    os.system("rm -rf *.txt")
    os.system("rm -rf *carte")
    os.system("killall python3")
    sys.exit(0)
else:
    print("All task are done... bye.")
    os.system("rm -rf *.txt")
    os.system("rm -rf *carte")
    os.system("killall python3")
    sys.exit(0)