#!/bin/bash
#
# fonctionnement de hostbase :
# 1) Coupe NetworkManager, scanne les réseaux WPA en 2.4GHz avec airodump-ng
#    (bascule automatique de la carte en mode moniteur si besoin), affiche
#    une liste numérotée, et stocke ESSID/BSSID/CHANNEL du réseau choisi.
# 2) Si une carte wifi compatible 5GHz est détectée, bascule aussi cette
#    carte en mode moniteur si besoin, relance un scan de 45s sur la bande
#    5GHz, et stocke ESSID/BSSID/CHANNEL du réseau choisi (fichiers séparés).
# 3) En fin de script : remet les cartes utilisées en mode managed, PUIS
#    vérifie que plus aucune interface wifi n'est en mode moniteur avant
#    de quitter (NetworkManager n'est plus relancé automatiquement).,

set -uo pipefail

IFACE_ARG="${1:-}"
SCAN_TIME="${2:-30}"
SCAN_TIME_5GHZ=45

TMP_PREFIX="/tmp/airodump_scan_$$"
CSV_FILE="${TMP_PREFIX}-01.csv"

TMP_PREFIX_5G="/tmp/airodump_scan5g_$$"
CSV_FILE_5G="${TMP_PREFIX_5G}-01.csv"


NM_WAS_STOPPED=0
RESTORED_DONE=0
IFACE=""
IFACE_5G=""

if [[ "$EUID" -ne 0 ]]; then
    echo "Must be started in root ! (sudo)." >&2
    exit 1
fi

# ============================================================
# --- Fonctions utilitaires ---
# ============================================================

check_hostapd_compat() {
    local iface="$1"
    local phy
    phy="$(iw dev "$iface" info 2>/dev/null | awk '/wiphy/ {print $2}')"
    [[ -z "$phy" ]] && return 1
    iw phy "phy${phy}" info 2>/dev/null \
        | awk '/Supported interface modes/{flag=1; next} /^[[:space:]]*\*/{if(flag) print} !/^[[:space:]]*\*/{if(flag && !/Supported interface modes/) flag=0}' \
        | grep -qw "AP"
}

check_5ghz_compat() {
    local iface="$1"
    local phy
    phy="$(iw dev "$iface" info 2>/dev/null | awk '/wiphy/ {print $2}')"
    [[ -z "$phy" ]] && return 1
    iw phy "phy${phy}" info 2>/dev/null | grep -qE '\* 5[0-9]{3}(\.[0-9]+)? MHz'
}

check_24ghz_compat() {
    local iface="$1"
    local phy
    phy="$(iw dev "$iface" info 2>/dev/null | awk '/wiphy/ {print $2}')"
    [[ -z "$phy" ]] && return 1
    iw phy "phy${phy}" info 2>/dev/null | grep -qE '\* 24[0-9]{2}(\.[0-9]+)? MHz'
}

# Retourne une chaîne lisible indiquant la compatibilité 2.4GHz / 5GHz
# de l'interface, à afficher à côté des messages "hostapd compatibility OK".
freq_compat_str() {
    local iface="$1"
    local s24="no" s5="no"
    check_24ghz_compat "$iface" && s24="yes"
    check_5ghz_compat "$iface" && s5="yes"
    echo "2.4GHz: ${s24} / 5GHz: ${s5}"
}

check_monitor_mode() {
    local iface="$1"
    iw dev "$iface" info 2>/dev/null | grep -q "type monitor"
}

list_wifi_ifaces() {
    local -n _out_array="$1"
    _out_array=()
    local dev name
    for dev in /sys/class/net/*; do
        name="$(basename "$dev")"
        if [[ -d "$dev/wireless" || -d "$dev/phy80211" ]]; then
            _out_array+=("$name")
        fi
    done
}

# Coupe NetworkManager (une seule fois), pour qu'il n'interfère pas avec
# le passage en mode moniteur / le scan.
stop_network_manager() {
    if [[ "$NM_WAS_STOPPED" -eq 1 ]]; then
        return 0
    fi
    if command -v systemctl >/dev/null 2>&1 && systemctl is-active --quiet NetworkManager 2>/dev/null; then
        echo "[*] Shutdown NetworkManager..."
        systemctl stop NetworkManager 2>/dev/null || true
        NM_WAS_STOPPED=1
    fi
}

# Bascule une interface en mode moniteur si elle ne l'est pas déjà.
enable_monitor_mode() {
    local iface="$1"
    if check_monitor_mode "$iface"; then
        echo "[*] $iface is already in monitor mode."
        return 0
    fi

    echo "[*] Switching $iface in monitor mode..."
    ip link set "$iface" down 2>/dev/null
    iw dev "$iface" set type monitor 2>/dev/null
    ip link set "$iface" up 2>/dev/null

    if ! check_monitor_mode "$iface"; then
        echo "Error : can't switch $iface in monitor mode." >&2
        return 1
    fi
    echo "[*] $iface is now in monitor mode."
}

# Remet une interface en mode managed si elle est actuellement en mode moniteur.
disable_monitor_mode() {
    local iface="$1"
    if ! check_monitor_mode "$iface"; then
        return 0
    fi
    echo "[*] Switch $iface to managed mode..."
    ip link set "$iface" down 2>/dev/null
    iw dev "$iface" set type managed 2>/dev/null
    ip link set "$iface" up 2>/dev/null
}

# Remet les interfaces utilisées en mode managed.
# NetworkManager n'est PAS relancé automatiquement (il devra être relancé
# manuellement si besoin, via "systemctl start NetworkManager").
# Idempotent : ne fait rien si déjà exécutée.
restore_interfaces_and_nm() {
    if [[ "$RESTORED_DONE" -eq 1 ]]; then
        return 0
    fi
    RESTORED_DONE=1

    echo
    echo "[*] Switching cards into managed mode..."
    for iface in "$IFACE" "$IFACE_5G"; do
        [[ -z "$iface" ]] && continue
        disable_monitor_mode "$iface"
    done
}

# Vérifie, sur TOUTES les interfaces wifi de la machine (pas seulement
# celles utilisées par ce script), qu'aucune n'est restée en mode moniteur.
# Retourne 1 si au moins une interface est encore en mode moniteur.
verify_no_monitor_mode() {
    local any_monitor=0
    declare -a ALL_WIFI_IFACES=()
    list_wifi_ifaces ALL_WIFI_IFACES

    echo
    echo "[*] Checking cards status : no one must be in monitor mode to continue..."
    for iface in "${ALL_WIFI_IFACES[@]}"; do
        if check_monitor_mode "$iface"; then
            echo "[!] WARNING : $iface is in monitor mode !" >&2
            any_monitor=1
        else
            echo "[*] $iface : mode managed OK"
        fi
    done

    if [[ "$any_monitor" -eq 1 ]]; then
        echo "Error : one wifi card or more reminds in monitor mode." >&2
        return 1
    fi

    echo "[*] All cards are in managed mode."
    SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/hostbasebis.sh"
exit $?
}

cleanup() {
    rm -f "${TMP_PREFIX}"-*.csv "${TMP_PREFIX}"-*.cap "${TMP_PREFIX}"-*.kismet* "${TMP_PREFIX}"-*.log* 2>/dev/null || true
    rm -f "${TMP_PREFIX_5G}"-*.csv "${TMP_PREFIX_5G}"-*.cap "${TMP_PREFIX_5G}"-*.kismet* "${TMP_PREFIX_5G}"-*.log* 2>/dev/null || true
    restore_interfaces_and_nm

    # On quitte seulement après avoir vérifié qu'aucune interface n'est
    # restée en mode moniteur. Si une interface pose problème, le script
    # se termine avec un code d'erreur (1) au lieu du code d'origine.
    if ! verify_no_monitor_mode; then
        exit 1
    fi
}
trap cleanup EXIT

# ============================================================
# --- Phase 1 : sélection de l'interface (2.4GHz / scan principal) ---
# ============================================================

if [[ -n "$IFACE_ARG" ]]; then
    IFACE="$IFACE_ARG"
    if check_hostapd_compat "$IFACE"; then
        echo -e "[*] $IFACE -> hostapd compatibility OK ($(freq_compat_str "$IFACE"))"
    else
        echo -e "Error : card '$IFACE' doesn't support hostapd (no evil twin with this card)." >&2
        exit 1
    fi
else
    declare -a WIFI_IFACES=()
    list_wifi_ifaces WIFI_IFACES

    if [[ ${#WIFI_IFACES[@]} -eq 0 ]]; then
        echo "No cards detected." >&2
        exit 1
    fi

    echo "Checking hostapd compatibility :"
    echo "-----------------------------------------------------"
    for name in "${WIFI_IFACES[@]}"; do
        if check_hostapd_compat "$name"; then
            echo "  $name -> hostapd compatibility OK ($(freq_compat_str "$name"))"
        else
            echo "  $name -> hostapd compatibility FAIL" >&2
            echo "[!] Error : card '$name' doesn't support hostapd (no evil twin with this card)." >&2
            exit 1
        fi
    done
    echo "-----------------------------------------------------"

    if [[ ${#WIFI_IFACES[@]} -eq 1 ]]; then
        IFACE="${WIFI_IFACES[0]}"
        echo "Only one card detected: $IFACE"
    else
        echo "Cards available:"
        echo "-----------------------------------------------------"
        for i in "${!WIFI_IFACES[@]}"; do
            printf "%2d) %s\n" "$((i+1))" "${WIFI_IFACES[$i]}"
        done
        echo "-----------------------------------------------------"
        read -rp "Select card (number) : " IFACE_CHOICE

        if ! [[ "$IFACE_CHOICE" =~ ^[0-9]+$ ]] || (( IFACE_CHOICE < 1 || IFACE_CHOICE > ${#WIFI_IFACES[@]} )); then
            echo "Not valid choice." >&2
            exit 1
        fi
        IFACE="${WIFI_IFACES[$((IFACE_CHOICE-1))]}"
    fi
fi

stop_network_manager
enable_monitor_mode "$IFACE" || exit 1

echo "Scanning network with $IFACE while ${SCAN_TIME}s (network WPA/WPA2/WPA3)..."

airodump-ng --encrypt wpa --write "$TMP_PREFIX" --output-format csv "$IFACE" \
    > /tmp/airodump_scan_$$.log 2>&1 &
AIRODUMP_PID=$!

sleep "$SCAN_TIME"

kill -INT "$AIRODUMP_PID" 2>/dev/null || true
wait "$AIRODUMP_PID" 2>/dev/null || true

if [[ ! -f "$CSV_FILE" ]]; then
    echo "No CSV file found, please check monitor mode on your card." >&2
    exit 1
fi

declare -a BSSIDS=() CHANNELS=() ESSIDS=() POWERS=()

while IFS=',' read -r bssid first last channel speed privacy cipher auth power beacons iv lanip idlen essid key; do
    [[ -z "$bssid" ]] && break
    [[ "$bssid" == "Station MAC" ]] && break
    [[ "$bssid" == "BSSID" ]] && continue

    bssid_trim="$(echo "$bssid" | xargs)"
    channel_trim="$(echo "$channel" | xargs)"
    power_trim="$(echo "$power" | xargs)"
    privacy_trim="$(echo "$privacy" | xargs)"
    essid_trim="$(echo "$essid" | sed 's/^ *//;s/ *$//')"

    [[ -z "$bssid_trim" ]] && continue
    [[ "$privacy_trim" =~ WPA ]] || continue

    BSSIDS+=("$bssid_trim")
    CHANNELS+=("$channel_trim")
    POWERS+=("$power_trim")
    ESSIDS+=("$essid_trim")
done < "$CSV_FILE"

if [[ ${#BSSIDS[@]} -eq 0 ]]; then
    echo "No WPA networks found." >&2
    exit 1
fi

echo
echo -e "WPA networks found (2.4GHz) :"
echo "-----------------------------------------------------"
for i in "${!BSSIDS[@]}"; do
    printf "%2d) ESSID: %-25s BSSID: %-18s CH: %-3s PWR: %s\n" \
        "$((i+1))" "${ESSIDS[$i]:-<masqué>}" "${BSSIDS[$i]}" "${CHANNELS[$i]}" "${POWERS[$i]}"
done
echo "-----------------------------------------------------"

read -rp "Select network (number) : " CHOICE

if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || (( CHOICE < 1 || CHOICE > ${#BSSIDS[@]} )); then
    echo -e "Not valid choice." >&2
    exit 1
fi

IDX=$((CHOICE - 1))

TARGET_BSSID="${BSSIDS[$IDX]}"
TARGET_CHANNEL="${CHANNELS[$IDX]}"
TARGET_ESSID="${ESSIDS[$IDX]}"
TARGET_PWR="${POWERS[$IDX]}"

echo
echo "Network selected (2.4GHz) :"
echo "  ESSID   : $TARGET_ESSID"
echo "  BSSID   : $TARGET_BSSID"
echo "  Channel : $TARGET_CHANNEL"
echo "  PWR     : $TARGET_PWR"

OUT_DIR="${OUT_DIR:-.}"
echo "$TARGET_ESSID"   > "$OUT_DIR/essid.txt"
echo "$TARGET_BSSID"   > "$OUT_DIR/bssid.txt"
echo "$TARGET_CHANNEL" > "$OUT_DIR/channel.txt"

echo
echo " Saved in :"
echo "    $OUT_DIR/essid.txt"
echo "    $OUT_DIR/bssid.txt"
echo "    $OUT_DIR/channel.txt"

# ============================================================
# --- Phase 2 : recherche d'une carte compatible 5GHz ---
# ============================================================

echo
echo "Looking for 5GHz card..."

declare -a ALL_IFACES=()
list_wifi_ifaces ALL_IFACES

declare -a IFACES_5GHZ=()
for name in "${ALL_IFACES[@]}"; do
    if check_5ghz_compat "$name"; then
        echo "  $name -> 5GHz compatibility OK"
        IFACES_5GHZ+=("$name")
    fi
done

if [[ ${#IFACES_5GHZ[@]} -eq 0 ]]; then
    echo -e "${COLOR_ORANGE}WARNING : no 5GHz card detected.${COLOR_RESET}"
else

if [[ ${#IFACES_5GHZ[@]} -eq 1 ]]; then
    IFACE_5G="${IFACES_5GHZ[0]}"
    echo "Only one 5GHz card detected: $IFACE_5G"
else
    echo "5GHz cards available  :"
    echo "-----------------------------------------------------"
    for i in "${!IFACES_5GHZ[@]}"; do
        printf "%2d) %s\n" "$((i+1))" "${IFACES_5GHZ[$i]}"
    done
    echo "-----------------------------------------------------"
    read -rp "Select 5GHz card (number) : " IFACE5_CHOICE

    if ! [[ "$IFACE5_CHOICE" =~ ^[0-9]+$ ]] || (( IFACE5_CHOICE < 1 || IFACE5_CHOICE > ${#IFACES_5GHZ[@]} )); then
        echo "Not valid choice." >&2
        exit 1
    fi
    IFACE_5G="${IFACES_5GHZ[$((IFACE5_CHOICE-1))]}"
fi

stop_network_manager
enable_monitor_mode "$IFACE_5G" || exit 1

echo "Scanning network in 5GHz band with $IFACE_5G while ${SCAN_TIME_5GHZ}s (network WPA/WPA2/WPA3)..."

airodump-ng --band a --write "$TMP_PREFIX_5G" --output-format csv "$IFACE_5G" \
    > /tmp/airodump_scan5g_$$.log 2>&1 &
AIRODUMP_PID_5G=$!

sleep "$SCAN_TIME_5GHZ"

kill -INT "$AIRODUMP_PID_5G" 2>/dev/null || true
wait "$AIRODUMP_PID_5G" 2>/dev/null || true

if [[ ! -f "$CSV_FILE_5G" ]]; then
     echo "No CSV file found, please check monitor mode on your card." >&2
    exit 1
fi

declare -a BSSIDS_5G=() CHANNELS_5G=() ESSIDS_5G=() POWERS_5G=()

while IFS=',' read -r bssid first last channel speed privacy cipher auth power beacons iv lanip idlen essid key; do
    [[ -z "$bssid" ]] && break
    [[ "$bssid" == "Station MAC" ]] && break
    [[ "$bssid" == "BSSID" ]] && continue

    bssid_trim="$(echo "$bssid" | xargs)"
    channel_trim="$(echo "$channel" | xargs)"
    power_trim="$(echo "$power" | xargs)"
    privacy_trim="$(echo "$privacy" | xargs)"
    essid_trim="$(echo "$essid" | sed 's/^ *//;s/ *$//')"

    [[ -z "$bssid_trim" ]] && continue
    [[ "$privacy_trim" =~ WPA ]] || continue

    BSSIDS_5G+=("$bssid_trim")
    CHANNELS_5G+=("$channel_trim")
    POWERS_5G+=("$power_trim")
    ESSIDS_5G+=("$essid_trim")
done < "$CSV_FILE_5G"

if [[ ${#BSSIDS_5G[@]} -eq 0 ]]; then
    echo "No WPA networks in 5GHz found." >&2
    exit 1
fi

echo
echo "Networks detected (5GHz) :"
echo "-----------------------------------------------------"
for i in "${!BSSIDS_5G[@]}"; do
    printf "%2d) ESSID: %-25s BSSID: %-18s CH: %-3s PWR: %s\n" \
        "$((i+1))" "${ESSIDS_5G[$i]:-<masqué>}" "${BSSIDS_5G[$i]}" "${CHANNELS_5G[$i]}" "${POWERS_5G[$i]}"
done
echo "-----------------------------------------------------"

read -rp "Select a 5GHz network (number) : " CHOICE_5G

if ! [[ "$CHOICE_5G" =~ ^[0-9]+$ ]] || (( CHOICE_5G < 1 || CHOICE_5G > ${#BSSIDS_5G[@]} )); then
    echo "Not valid choice." >&2
    exit 1
fi

IDX_5G=$((CHOICE_5G - 1))

TARGET_BSSID_5G="${BSSIDS_5G[$IDX_5G]}"
TARGET_CHANNEL_5G="${CHANNELS_5G[$IDX_5G]}"
TARGET_ESSID_5G="${ESSIDS_5G[$IDX_5G]}"
TARGET_PWR_5G="${POWERS_5G[$IDX_5G]}"

echo
echo "Network selected (5GHz) :"
echo "  ESSID   : $TARGET_ESSID_5G"
echo "  BSSID   : $TARGET_BSSID_5G"
echo "  Channel : $TARGET_CHANNEL_5G"
echo "  PWR     : $TARGET_PWR_5G"

echo "$TARGET_ESSID_5G"   > "$OUT_DIR/essid5ghz.txt"
echo "$TARGET_BSSID_5G"   > "$OUT_DIR/bssid_5ghz.txt"
echo "$TARGET_CHANNEL_5G" > "$OUT_DIR/channel_5ghz.txt"

echo
echo "Saved in :"
echo "    $OUT_DIR/essid5ghz.txt"
echo "    $OUT_DIR/bssid_5ghz.txt"
echo "    $OUT_DIR/channel_5ghz.txt"
fi
# La remise en mode managed des interfaces + redémarrage de NetworkManager
# est gérée par restore_interfaces_and_nm(), appelée automatiquement via
# le trap EXIT (cleanup), donc aussi en cas d'erreur en cours de script.
exit 0
