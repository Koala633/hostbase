
Hostbase-1.8

WPA2/3 downgrade


Work on Kali. 
Step 1 : download and exec : bash install.sh


Step 2 : go to the folder and run : bash hostbase.sh



--> please SEE the file READ_THAT_php_conf into the WebPages folder <---

This file explain how to configure your php.ini on apache2 to be able to use the qrcode mode.


------> FULL README BELOW


Nobody know me there but im also on other forums, especially on french and spanish forums.


I made a evil-twin bash script called hostbase (current version is hostbase-1.8)


So i see your question coming… why use this script instead of Airgeddon, Fluxion, Wifiphisher etc... ?


Because hostbase is dedicated only for evil-twin in WPA2/3 mode and really specialized on that.Let me explain :


- WPA3 can't be DDos efficiently with the MFP protocol alive but who said we can't stop the next incoming the connection ?


- since the last version (hostbase-1.8) there is no DDos option because we don't need it… thrust me


- also this script use QR code login system for mobile user, the user is redirected to the captive portal and we ask to him to take a picture from his router QR code or wifi key then, with ajax we upload the picture to us (this part was not easy to do beacause by default Android system doesn't allow to open in primary process as a php webpage, but i found a trick) for Windows user QR code is disabled, the user will be redirected to another page).


- this script can manage 2 or 3 wifi cards at the same time (the internal one and then two others usb cards can be added).This is very helpfull when you want to downgrade 2,4GHz and 5GHz frequencies at the same time.


- and finaly, Hostbase is a serious homemade project with 10 years of update and tricks.


I started to build it on 2016 with completely new methods combined with evil-twin in WPA mode to bypass IDS and WPS-PBC mode.It was also the first script to do a DDos pursuit mode avoiding channel hopping.


This script is not a joke, it can be very helpfull and has been approuved by security students.Im not a pentester or anything like that, im just a guy fascinated by network security (Wi-Fi, reverse Tools and other…).


Now that the presentation is done, i will explain a little bit how to use this script.


First it will scan the networks with airodump-ng in 2,4GHz and then in 5GHz.You will have to choose your wifi card to do that.If the wifi cars doesn't support hostapd or 5GHz frequency the script will tell you it.This script use hostapd with custom configuration file wich are changed according to the target AP network.


Second, once the scan is done, select the network by typing his number.Then you will be prompted to choose what fake networks you want to do (evil-twin is the last so just for a test, skip the other networks with 0).Evil-twin AP is mentioned as


`AP 3/3 hostapdd.conf (Evil twin)`
` `


My tips to use the script :


- if you have 2 wifi cards and you know that there is a lot of users connected on the target networks in 2,4GHz frequency, Don't skip AP1/3, select it and chose your wifi card according to this example :


`AP 1/3 : hostapd.conf (WPA network)`


- Now if you have 2 wifi cards but you know that there is a lot of users connected on the target network in 5GHz frequency, skip AP1/3 with 0 and go for AP2/3 :


`AP 2/3 hostaghz.conf (WPA 5 GHz network)`


- Finaly, choose your wifi card to make the evil-twin on AP3/3 :


`AP 3/3 hostapdd.conf (Evil twin)`


Now if you have 3 wifi cards like me, you can choose every network AP1/3 AP2/3 AP3/3 to make a combo.The script will show you at every stage if the cards support hostapd, 5GHz or if the device is already used.


By default, this is script is made for french router but it has a default page if the router doesn't match.

Current version to download is hostabse-1.8 forget the other.


It is a beta version so any feedback is appreciated.


This script has been tested on Kali-2026.2


If you have a problem, please post here the full log of the shell.


Enjoys guys.


you can try to use the older versions of hostbase but there is no update since 2 years, better going to the last hostbase-1.8



