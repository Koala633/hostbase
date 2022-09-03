#!/bin/bash
# Under licence GPLv3 http://www.gnu.org/licenses/gpl.txt
# Hostbase By Koala alias Flow

Version=1.5

# set color variable

red='\e[1;31m' 
NC='\e[0m' 
yellow='\e[1;33m'
blue='\e[1;34m'

# requierement

deplist="build-essential upgrade-system subversion wget g++ iptables pavucontrol ffmpeg sqlite3 libsqlite3-dev libssl-dev libnl-3-dev libnl-genl-3-dev dsniff hostapd isc-dhcp-server pkg-config xterm freeradius apache2 php libapache2-mod-php php-cli tcpdump python3-scapy vokoscreen wireshark bridge-utils devscripts gengetopt autoconf libtool make libatk-adaptor libgail-common toilet ruby ruby-dev libgtk2.0-dev gobject-introspection ruby-gtk2 mdk3 mdk4 berate-ap"


# run as root
if [ "$(id -u)" != "0" ]
    then
        echo -e "[$red!$NC] Ce script requiert les droits d'admin $NC" # 1>&2 inutile car il n'y a pas d'autre retour que l'echo
        exit 1
fi

Banniere(){
echo -e "$yellow 	           Hostbase version $Version By Koala alias Flow $NC"
echo -e "                        |\          )           (                        "
echo -e "                    ____| \__        )         (                         "
echo -e "                   |       @ \        )       (                          "
echo -e "~~~~~~~~~~~~~~~~~~~|~~<->    /         )     (                           "
echo -e "                   |_________\          ) | (                            "
echo -e "                    |    |                |                              "
echo -e "___________________(|)__(|)_____________  |  ____________________________"
echo -e "$blue Script utilisant berate_ap, pour plus d'infos voir: https://github.com/sensepost/berate_ap.$NC"
echo -e "$blue Installation des dépendances du script pour la version 1.5 console.$NC"
echo
echo -e "$red Merci de mettre d'agrandir cette fenetre pour une meilleure visibilité.$NC"
echo
}

mainmenu(){
Banniere
echo -e "$yellow      Installation pour kali-linux $NC \
\n\n\n $blue 1$NC.  Lancer l'installation classique: (le temps dépendra de votre connexion internet.)\
\n\n $blue 2$NC.  Installation apache2 SSL: (--> pour utiliser cette option vous devez ajouter le backport correspondant a votre distribution linux.))\
\n $blue 3$NC.  Quitter \n"
read -p "Choix: " choix

case $choix in
1) installationsuite ;;
2) sslinstall ;;
3) checkexit ;;
*) exit 1;;
esac
}

#########################################################
installationsuite(){
clear
Banniere
echo -e "\n\e[1;33m[*] Please wait...\e[0m\n"
echo -n "Recherche de mise a jours"
apt-get -qq update
	
for app in $deplist
do
  dpkg --get-selections "$app" | grep install >/dev/null || apt install -y "$app"
done

echo -e "$blue Installation des ruby gems servant a faire fonctionner hostbase.$NC"
gem install highline && gem install rake && gem install bundler && gem install colorize

echo -e "\t\e[1;32m[+] Configuration de apache2 et des pages de phishing... PATIENTEZ....\e[0m"
cp -R $(pwd) /tmp/
sleep 8;
cp -R /tmp/hostbase-1.5FR/PagesFR/* /etc/
sleep 5;
cd /etc/apache2/
rm -rf apache2.conf
cd /etc/apache2/sites-available/
rm -rf 000-default.conf
cp -R /tmp/hostbase-1.5FR/apache2.conf /etc/apache2/
cp -R /tmp/hostbase-1.5FR/000-default.conf /etc/apache2/sites-available/
service apache2 restart
sleep 2;
echo -e "\t\e[1;32m[+] Configuration de hostapd... PATIENTEZ....\e[0m"
cd /root/
wget https://w1.fi/cgit/hostap/snapshot/hostap_2_9.tar.gz && tar -zxf hostap_2_9.tar.gz
cd /root/hostap_2_9/hostapd
cp defconfig .config
cat <<-EOF > /root/hostap_2_9/hostapd/.config
# Example hostapd build time configuration
#
# This file lists the configuration options that are used when building the
# hostapd binary. All lines starting with # are ignored. Configuration option
# lines must be commented out complete, if they are not to be included, i.e.,
# just setting VARIABLE=n is not disabling that variable.
#
# This file is included in Makefile, so variables like CFLAGS and LIBS can also
# be modified from here. In most cass, these lines should use += in order not
# to override previous values of the variables.

# Driver interface for Host AP driver
CONFIG_DRIVER_HOSTAP=y

# Driver interface for wired authenticator
#CONFIG_DRIVER_WIRED=y

# Driver interface for drivers using the nl80211 kernel interface
CONFIG_DRIVER_NL80211=y

# QCA vendor extensions to nl80211
#CONFIG_DRIVER_NL80211_QCA=y

# driver_nl80211.c requires libnl. If you are compiling it yourself
# you may need to point hostapd to your version of libnl.
#
#CFLAGS += -I$<path to libnl include files>
#LIBS += -L$<path to libnl library files>

# Use libnl v2.0 (or 3.0) libraries.
#CONFIG_LIBNL20=y

# Use libnl 3.2 libraries (if this is selected, CONFIG_LIBNL20 is ignored)
CONFIG_LIBNL32=y


# Driver interface for FreeBSD net80211 layer (e.g., Atheros driver)
#CONFIG_DRIVER_BSD=y
#CFLAGS += -I/usr/local/include
#LIBS += -L/usr/local/lib
#LIBS_p += -L/usr/local/lib
#LIBS_c += -L/usr/local/lib

# Driver interface for no driver (e.g., RADIUS server only)
#CONFIG_DRIVER_NONE=y

# IEEE 802.11F/IAPP
CONFIG_IAPP=y

# WPA2/IEEE 802.11i RSN pre-authentication
CONFIG_RSN_PREAUTH=y

# IEEE 802.11w (management frame protection)
CONFIG_IEEE80211W=y

# Support Operating Channel Validation
#CONFIG_OCV=y

# Integrated EAP server
CONFIG_EAP=y

# EAP Re-authentication Protocol (ERP) in integrated EAP server
CONFIG_ERP=y

# EAP-MD5 for the integrated EAP server
CONFIG_EAP_MD5=y

# EAP-TLS for the integrated EAP server
CONFIG_EAP_TLS=y

# EAP-MSCHAPv2 for the integrated EAP server
CONFIG_EAP_MSCHAPV2=y

# EAP-PEAP for the integrated EAP server
CONFIG_EAP_PEAP=y

# EAP-GTC for the integrated EAP server
CONFIG_EAP_GTC=y

# EAP-TTLS for the integrated EAP server
CONFIG_EAP_TTLS=y

# EAP-SIM for the integrated EAP server
#CONFIG_EAP_SIM=y

# EAP-AKA for the integrated EAP server
#CONFIG_EAP_AKA=y

# EAP-AKA' for the integrated EAP server
# This requires CONFIG_EAP_AKA to be enabled, too.
#CONFIG_EAP_AKA_PRIME=y

# EAP-PAX for the integrated EAP server
#CONFIG_EAP_PAX=y

# EAP-PSK for the integrated EAP server (this is _not_ needed for WPA-PSK)
#CONFIG_EAP_PSK=y

# EAP-pwd for the integrated EAP server (secure authentication with a password)
CONFIG_EAP_PWD=y

# EAP-SAKE for the integrated EAP server
#CONFIG_EAP_SAKE=y

# EAP-GPSK for the integrated EAP server
#CONFIG_EAP_GPSK=y
# Include support for optional SHA256 cipher suite in EAP-GPSK
#CONFIG_EAP_GPSK_SHA256=y

# EAP-FAST for the integrated EAP server
#CONFIG_EAP_FAST=y

# EAP-TEAP for the integrated EAP server
# Note: The current EAP-TEAP implementation is experimental and should not be
# enabled for production use. The IETF RFC 7170 that defines EAP-TEAP has number
# of conflicting statements and missing details and the implementation has
# vendor specific workarounds for those and as such, may not interoperate with
# any other implementation. This should not be used for anything else than
# experimentation and interoperability testing until those issues has been
# resolved.
#CONFIG_EAP_TEAP=y

# Wi-Fi Protected Setup (WPS)
CONFIG_WPS=y
# Enable UPnP support for external WPS Registrars
CONFIG_WPS_UPNP=y
# Enable WPS support with NFC config method
CONFIG_WPS_NFC=y

# EAP-IKEv2
#CONFIG_EAP_IKEV2=y

# Trusted Network Connect (EAP-TNC)
#CONFIG_EAP_TNC=y

# EAP-EKE for the integrated EAP server
#CONFIG_EAP_EKE=y

# PKCS#12 (PFX) support (used to read private key and certificate file from
# a file that usually has extension .p12 or .pfx)
CONFIG_PKCS12=y

# RADIUS authentication server. This provides access to the integrated EAP
# server from external hosts using RADIUS.
CONFIG_RADIUS_SERVER=y

# Build IPv6 support for RADIUS operations
CONFIG_IPV6=y

# IEEE Std 802.11r-2008 (Fast BSS Transition)
#CONFIG_IEEE80211R=y

# Use the hostapd's IEEE 802.11 authentication (ACL), but without
# the IEEE 802.11 Management capability (e.g., FreeBSD/net80211)
#CONFIG_DRIVER_RADIUS_ACL=y

# IEEE 802.11n (High Throughput) support
CONFIG_IEEE80211N=y

# Wireless Network Management (IEEE Std 802.11v-2011)
# Note: This is experimental and not complete implementation.
#CONFIG_WNM=y

# IEEE 802.11ac (Very High Throughput) support
CONFIG_IEEE80211AC=y

# IEEE 802.11ax HE support
# Note: This is experimental and work in progress. The definitions are still
# subject to change and this should not be expected to interoperate with the
# final IEEE 802.11ax version.
#CONFIG_IEEE80211AX=y

# Remove debugging code that is printing out debug messages to stdout.
# This can be used to reduce the size of the hostapd considerably if debugging
# code is not needed.
#CONFIG_NO_STDOUT_DEBUG=y

# Add support for writing debug log to a file: -f /tmp/hostapd.log
# Disabled by default.
CONFIG_DEBUG_FILE=y

# Send debug messages to syslog instead of stdout
#CONFIG_DEBUG_SYSLOG=y

# Add support for sending all debug messages (regardless of debug verbosity)
# to the Linux kernel tracing facility. This helps debug the entire stack by
# making it easy to record everything happening from the driver up into the
# same file, e.g., using trace-cmd.
#CONFIG_DEBUG_LINUX_TRACING=y

# Remove support for RADIUS accounting
#CONFIG_NO_ACCOUNTING=y

# Remove support for RADIUS
#CONFIG_NO_RADIUS=y

# Remove support for VLANs
#CONFIG_NO_VLAN=y

# Enable support for fully dynamic VLANs. This enables hostapd to
# automatically create bridge and VLAN interfaces if necessary.
CONFIG_FULL_DYNAMIC_VLAN=y

# Use netlink-based kernel API for VLAN operations instead of ioctl()
# Note: This requires libnl 3.1 or newer.
#CONFIG_VLAN_NETLINK=y

# Remove support for dumping internal state through control interface commands
# This can be used to reduce binary size at the cost of disabling a debugging
# option.
#CONFIG_NO_DUMP_STATE=y

# Enable tracing code for developer debugging
# This tracks use of memory allocations and other registrations and reports
# incorrect use with a backtrace of call (or allocation) location.
#CONFIG_WPA_TRACE=y
# For BSD, comment out these.
#LIBS += -lexecinfo
#LIBS_p += -lexecinfo
#LIBS_c += -lexecinfo

# Use libbfd to get more details for developer debugging
# This enables use of libbfd to get more detailed symbols for the backtraces
# generated by CONFIG_WPA_TRACE=y.
#CONFIG_WPA_TRACE_BFD=y
# For BSD, comment out these.
#LIBS += -lbfd -liberty -lz
#LIBS_p += -lbfd -liberty -lz
#LIBS_c += -lbfd -liberty -lz

# hostapd depends on strong random number generation being available from the
# operating system. os_get_random() function is used to fetch random data when
# needed, e.g., for key generation. On Linux and BSD systems, this works by
# reading /dev/urandom. It should be noted that the OS entropy pool needs to be
# properly initialized before hostapd is started. This is important especially
# on embedded devices that do not have a hardware random number generator and
# may by default start up with minimal entropy available for random number
# generation.
#
# As a safety net, hostapd is by default trying to internally collect
# additional entropy for generating random data to mix in with the data
# fetched from the OS. This by itself is not considered to be very strong, but
# it may help in cases where the system pool is not initialized properly.
# However, it is very strongly recommended that the system pool is initialized
# with enough entropy either by using hardware assisted random number
# generator or by storing state over device reboots.
#
# hostapd can be configured to maintain its own entropy store over restarts to
# enhance random number generation. This is not perfect, but it is much more
# secure than using the same sequence of random numbers after every reboot.
# This can be enabled with -e<entropy file> command line option. The specified
# file needs to be readable and writable by hostapd.
#
# If the os_get_random() is known to provide strong random data (e.g., on
# Linux/BSD, the board in question is known to have reliable source of random
# data from /dev/urandom), the internal hostapd random pool can be disabled.
# This will save some in binary size and CPU use. However, this should only be
# considered for builds that are known to be used on devices that meet the
# requirements described above.
#CONFIG_NO_RANDOM_POOL=y

# Should we attempt to use the getrandom(2) call that provides more reliable
# yet secure randomness source than /dev/random on Linux 3.17 and newer.
# Requires glibc 2.25 to build, falls back to /dev/random if unavailable.
#CONFIG_GETRANDOM=y

# Should we use poll instead of select? Select is used by default.
#CONFIG_ELOOP_POLL=y

# Should we use epoll instead of select? Select is used by default.
#CONFIG_ELOOP_EPOLL=y

# Should we use kqueue instead of select? Select is used by default.
#CONFIG_ELOOP_KQUEUE=y

# Select TLS implementation
# openssl = OpenSSL (default)
# gnutls = GnuTLS
# internal = Internal TLSv1 implementation (experimental)
# linux = Linux kernel AF_ALG and internal TLSv1 implementation (experimental)
# none = Empty template
#CONFIG_TLS=openssl

# TLS-based EAP methods require at least TLS v1.0. Newer version of TLS (v1.1)
# can be enabled to get a stronger construction of messages when block ciphers
# are used.
CONFIG_TLSV11=y

# TLS-based EAP methods require at least TLS v1.0. Newer version of TLS (v1.2)
# can be enabled to enable use of stronger crypto algorithms.
#CONFIG_TLSV12=y

# Select which ciphers to use by default with OpenSSL if the user does not
# specify them.
#CONFIG_TLS_DEFAULT_CIPHERS="DEFAULT:!EXP:!LOW"

# If CONFIG_TLS=internal is used, additional library and include paths are
# needed for LibTomMath. Alternatively, an integrated, minimal version of
# LibTomMath can be used. See beginning of libtommath.c for details on benefits
# and drawbacks of this option.
#CONFIG_INTERNAL_LIBTOMMATH=y
#ifndef CONFIG_INTERNAL_LIBTOMMATH
#LTM_PATH=/usr/src/libtommath-0.39
#CFLAGS += -I$(LTM_PATH)
#LIBS += -L$(LTM_PATH)
#LIBS_p += -L$(LTM_PATH)
#endif
# At the cost of about 4 kB of additional binary size, the internal LibTomMath
# can be configured to include faster routines for exptmod, sqr, and div to
# speed up DH and RSA calculation considerably
#CONFIG_INTERNAL_LIBTOMMATH_FAST=y

# Interworking (IEEE 802.11u)
# This can be used to enable functionality to improve interworking with
# external networks.
#CONFIG_INTERWORKING=y

# Hotspot 2.0
#CONFIG_HS20=y

# Enable SQLite database support in hlr_auc_gw, EAP-SIM DB, and eap_user_file
#CONFIG_SQLITE=y

# Enable Fast Session Transfer (FST)
#CONFIG_FST=y

# Enable CLI commands for FST testing
#CONFIG_FST_TEST=y

# Testing options
# This can be used to enable some testing options (see also the example
# configuration file) that are really useful only for testing clients that
# connect to this hostapd. These options allow, for example, to drop a
# certain percentage of probe requests or auth/(re)assoc frames.
#
#CONFIG_TESTING_OPTIONS=y

# Automatic Channel Selection
# This will allow hostapd to pick the channel automatically when channel is set
# to "acs_survey" or "0". Eventually, other ACS algorithms can be added in
# similar way.
#
# Automatic selection is currently only done through initialization, later on
# we hope to do background checks to keep us moving to more ideal channels as
# time goes by. ACS is currently only supported through the nl80211 driver and
# your driver must have survey dump capability that is filled by the driver
# during scanning.
#
# You can customize the ACS survey algorithm with the hostapd.conf variable
# acs_num_scans.
#
# Supported ACS drivers:
# * ath9k
# * ath5k
# * ath10k
#
# For more details refer to:
# http://wireless.kernel.org/en/users/Documentation/acs
#
#CONFIG_ACS=y

# Multiband Operation support
# These extentions facilitate efficient use of multiple frequency bands
# available to the AP and the devices that may associate with it.
#CONFIG_MBO=y

# Client Taxonomy
# Has the AP retain the Probe Request and (Re)Association Request frames from
# a client, from which a signature can be produced which can identify the model
# of client device like "Nexus 6P" or "iPhone 5s".
CONFIG_TAXONOMY=y

# Fast Initial Link Setup (FILS) (IEEE 802.11ai)
#CONFIG_FILS=y
# FILS shared key authentication with PFS
#CONFIG_FILS_SK_PFS=y

# Include internal line edit mode in hostapd_cli. This can be used to provide
# limited command line editing and history support.
#CONFIG_WPA_CLI_EDIT=y

# Opportunistic Wireless Encryption (OWE)
# Experimental implementation of draft-harkins-owe-07.txt
#CONFIG_OWE=y

# Airtime policy support
#CONFIG_AIRTIME_POLICY=y

# Override default value for the wpa_disable_eapol_key_retries configuration
# parameter. See that parameter in hostapd.conf for more details.
#CFLAGS += -DDEFAULT_WPA_DISABLE_EAPOL_KEY_RETRIES=1
CONFIG_SAE=y
EOF
sleep 2
make && make install && hostapd -v


echo -e "\t\e[1;32m[+] Lancement de hostbase...\e[0m"
cd /tmp/hostbase-1.5FR/
ruby hostbase.rb
mainmenu
}

################################################
sslinstall(){
echo -e "NOTE: cette option ne marchera pas si vous ajoutez pas dans le fichier sources.list le backport correspondant a votre distribution linux et vous devez installer python-certbot-apache"
sleep 10;
echo -e "L'installation débutera dans 5s... commande pour renouveller le certificat: certbot renew --dry-run"
sleep 10;
certbot --apache
}
################################################

checkexit(){
echo "Goodbye..."
exit 0
}
mainmenu
