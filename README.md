# Hostbase
A bash script for advanced rogue AP attack  

The script is able to:

Disconnect quickly the target station from the target network,
Create encrypted fake WPA AP,
Create heavy interference and replace the target AP by your fake (work only again windows system),
Ask to push te WPS button instead of ask the key which is very suspicious...
Switch between local and internet rogue AP


Included airbase-ng cafe-latte fake AP attack again routers with hexadecimal passwords,
Included hostapd multi AP option, that allow you to create multi fake AP (WARNING: to use this attack, CONFIGURE_DYNAMIC_WLAN must be compiled with hostapd install), if you only use the reposity version and not the latest version of hostapd you will have to change your MAC adress before use the multi AP option, please take note of that and see the manual.
Included redirect option if you want to use your computer as an evil AP and a dd-wrt router as a repeater with a configured chilispot inside.


Once you entered the data of target network, the script is autonomous and can work alone, just go take a cup of tea :)
French most popular router pages are included

Tool used are hostapd and airbase-ng for a final result of hostbase.

French project but also open as other to make this more fun.

----> PLEASE, LOOK THE MANUAL BEFORE USE <----
