# Hostbase
A bash script for advanced rogue AP attack (Update of 11 august 2017: Added tracked channel.

(download the hostbase folder and launch the newinstall.sh script into hostbase folder)(don't use the hostbase english version cause it's an old version)

The script is able to:

Disconnect quickly the target station from the target network

Create encrypted fake WPA AP

Create heavy interference and replace the target AP by your fake (work only again windows system)

Ask to push te WPS button instead of ask the key which is very suspicious...

Switch between local and internet rogue AP

DoS attack tracking target AP on the master channel's


Included airbase-ng cafe-latte fake AP attack again routers with hexadecimal passwords

Included hostapd multi AP option, that allow you to create multi fake AP (WARNING: to use this attack, CONFIGURE_DYNAMIC_WLAN must be compiled with hostapd install), if you only use the reposity version and not the latest version of hostapd you will have to change your MAC adress before use the multi AP option, please take note of that and see the manual.
Included redirect option if you want to use your computer as an evil AP and a dd-wrt router as a repeater with a configured chilispot inside.

Included a PDF for documentation

Once you entered the data of target network, the script is autonomous and can work alone, just go take a cup of tea :)
French most popular router pages are included

Tool used are hostapd and airbase-ng for a final result of hostbase.

French project but also open as other to make this more fun.

How use it ?
Go inside the hostbase folder and launch the installation script dependency:

bash newinstall.sh

Then when install finished, you will have the choice between hostbase1.0 and hostbase0.9.

The 0.9 ask for the key
The 1.0 ask for wps push button

At the first install all is going to do automaticaly but for the next use copy the hostbase folder into /tmp and start it like that:
cd /tmp/hostbase
bash hostbase1.0.sh

For 0.9 version:
cd /tmp/hostbase/hostbaseV0.9
bash hostbase0.9.sh

If you want to use the phishing page of your country, you will have to change the name on the script.Don't forget to start with the passive scan (option 5) for scan around and for kill any trouble process (network-manager etc...)

This script is a rogue AP based script and use WPA rogue AP with wps open session to let the victim come to us.
Also a new DoS is incorpored to track every second you want the channel of the target AP.




----> PLEASE, LOOK THE MANUAL AND PDF BEFORE USE <----

Sample video of how it work here:
https://www.youtube.com/channel/UCeWPrv3C8UxHzCsjTjbjKrQh

Youtube channel moved here:
https://www.youtube.com/channel/UCeWPrv3C8UxHzCsjTjbjKrQ  (other vidéo coming soon)


Coming in future:

Freeradius rogue AP attack based on the login only to directly grab the key without webserver or redirection (NOT TESTED YET).

Maybe i will include a WPS attacks too.

--> Not for beginner usage <--

