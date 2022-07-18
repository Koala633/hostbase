#!/usr/bin/env ruby
require 'gtk2'
require "highline/import"
require 'open3'
require 'monitor'
require './rogue'
require './ghz'
require './berate'
require './berateghz'
require './wps'


def report_press(w); puts "Lauching (button) w=#{w}"; end

window = Gtk::Window.new(Gtk::Window::TOPLEVEL)
window.set_title  "Hostbase 1.5 par Koala CodeName: Eucalyptus"
window.border_width = 100
window.set_size_request(950, -1)

window.signal_connect('delete_event') { Gtk.main_quit }

nb = Gtk::Notebook.new
label1 = Gtk::Label.new("Scan")
label2 = Gtk::Label.new("Hostapd WPA 2.4GHz")
label3 = Gtk::Label.new("Hostapd WPA 5GHz")
label4 = Gtk::Label.new("Berate_ap 2.4GHz")
label5 = Gtk::Label.new("Berate_ap 5GHz")
label6 = Gtk::Label.new("WPS PBC loop")
button = Gtk::Button.new("Scan de réseau")
button1 = Gtk::Button.new("Faire un AP EN WPA/2 avec DoS en 2.4GHz")
button2 = Gtk::Button.new("Faire un AP EN WPA/2 avec DoS en 2.4GHz et 5GHz")
button3 = Gtk::Button.new("Faire un AP ouvert avec DoS en 2.4GHz")
button4 = Gtk::Button.new("Faire un AP ouvert avec DoS en 2.4GHz et 5GHz")
button5 = Gtk::Button.new("Lancer en boucle le WPS PBC pour tenter d'avoir une clé WPA")

button.signal_connect("clicked")  {
dialog = Gtk::Dialog.new(
    "Interface pour le scan",
    nil,
    Gtk::Dialog::MODAL,
    [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
    [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
)
dialog.default_response = Gtk::Dialog::RESPONSE_OK
label1 = Gtk::Label.new("Interface")
label2 = Gtk::Label.new("5GHz")



carte = Gtk::Entry.new
ghz = Gtk::Entry.new

table = Gtk::Table.new(4, 2, false)
table.attach_defaults(label1, 0, 1, 0, 1)
table.attach_defaults(label2, 0, 1, 1, 2)
table.attach_defaults(carte,   1, 2, 0, 1)
table.attach_defaults(ghz,   1, 2, 1, 2)
table.row_spacings = 5
table.column_spacings = 5
table.border_width = 10

dialog.vbox.add(table)
dialog.show_all

# Run the dialog and output the data if user okays it
dialog.run do |response|
case response
  when Gtk::Dialog::RESPONSE_OK
system "echo > carte.txt %s\n" % [carte.text] 
system "echo > ghz.txt %s\n" % [ghz.text] 
system "ruby scan.rb"
  end
end
dialog.signal_connect('response') { dialog.destroy }
}

button1.signal_connect("clicked")  {
dialog = Gtk::Dialog.new(
    "Configuration du fake AP",
    nil,
    Gtk::Dialog::MODAL,
    [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
    [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
)
dialog.default_response = Gtk::Dialog::RESPONSE_OK
label1 = Gtk::Label.new("Interface du fake AP")
label2 = Gtk::Label.new("SSID")
label3 = Gtk::Label.new("Canal du fake AP")
label4 = Gtk::Label.new("Page de phishing")
label5 = Gtk::Label.new("Bssid de l'AP réel")
label6 = Gtk::Label.new("Canal del' AP réel")

carte = Gtk::Entry.new
nomreseau = Gtk::Entry.new
canal = Gtk::Entry.new
page = Gtk::Entry.new
apmac = Gtk::Entry.new
apcanal = Gtk::Entry.new

table = Gtk::Table.new(4, 2, false)
table.attach_defaults(label1, 0, 1, 0, 1)
table.attach_defaults(label2, 0, 1, 1, 2)
table.attach_defaults(label3, 0, 1, 2, 3)
table.attach_defaults(label4, 0, 1, 3, 4) 
table.attach_defaults(label5, 0, 1, 4, 5)
table.attach_defaults(label6, 0, 1, 5, 6)
table.attach_defaults(carte,   1, 2, 0, 1)
table.attach_defaults(nomreseau,   1, 2, 1, 2)
table.attach_defaults(canal,   1, 2, 2, 3)
table.attach_defaults(page,   1, 2, 3, 4)
table.attach_defaults(apmac,   1, 2, 4, 5)
table.attach_defaults(apcanal,   1, 2, 5, 6)
table.row_spacings = 5
table.column_spacings = 5
table.border_width = 10

dialog.vbox.add(table)
dialog.show_all

# Run the dialog and output the data if user okays it
dialog.run do |response|
case response
  when Gtk::Dialog::RESPONSE_OK
system "echo > carte.txt %s\n" % [carte.text] 
    system "echo > ssid.txt %s\n" % [nomreseau.text]
    system "echo > canal.txt %s\n" % [canal.text]
    system "echo > page.txt %s\n" % [page.text] 
    system "echo > apmac.txt %s\n" % [apmac.text] 
    system "echo > apcanal.txt %s\n" % [apcanal.text] 
Rogue.hostapdNormal 
end
end
dialog.signal_connect('response') { dialog.destroy }
}

button2.signal_connect("clicked")  {
dialog = Gtk::Dialog.new(
    "Configuration du fake AP",
    nil,
    Gtk::Dialog::MODAL,
    [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
    [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
)
dialog.default_response = Gtk::Dialog::RESPONSE_OK
label1 = Gtk::Label.new("Interface du fake AP")
label2 = Gtk::Label.new("SSID")
label3 = Gtk::Label.new("Canal du fake AP")
label4 = Gtk::Label.new("Page de phishing")
label5 = Gtk::Label.new("Bssid de l'AP réel")
label6 = Gtk::Label.new("Canal de l'AP réel")
label7 = Gtk::Label.new("Interface dos 5GHz")
label8 = Gtk::Label.new("Bssid 5GHz de l'ap réeal")
label9 = Gtk::Label.new("Canal 5GHz de l'ap réel")
label10 = Gtk::Label.new("Interface dos 2.4GHz")


carte = Gtk::Entry.new
nomreseau = Gtk::Entry.new
canal = Gtk::Entry.new
page = Gtk::Entry.new
apmac = Gtk::Entry.new
apcanal = Gtk::Entry.new
cartef = Gtk::Entry.new
bssidf = Gtk::Entry.new
canalf = Gtk::Entry.new
cartebis = Gtk::Entry.new

table = Gtk::Table.new(4, 2, false)
table.attach_defaults(label1, 0, 1, 0, 1)
table.attach_defaults(label2, 0, 1, 1, 2)
table.attach_defaults(label3, 0, 1, 2, 3)
table.attach_defaults(label4, 0, 1, 3, 4) 
table.attach_defaults(label5, 0, 1, 4, 5)
table.attach_defaults(label6, 0, 1, 5, 6)
table.attach_defaults(label7, 0, 1, 6, 7)
table.attach_defaults(label8, 0, 1, 7, 8)
table.attach_defaults(label9, 0, 1, 8, 9)
table.attach_defaults(label10, 0, 1, 9, 10)
table.attach_defaults(carte,   1, 2, 0, 1)
table.attach_defaults(nomreseau, 1, 2, 1, 2)
table.attach_defaults(canal, 1, 2, 2, 3)
table.attach_defaults(page, 1, 2, 3, 4)
table.attach_defaults(apmac, 1, 2, 4, 5)
table.attach_defaults(apcanal, 1, 2, 5, 6)
table.attach_defaults(cartef, 1, 2, 6, 7)
table.attach_defaults(bssidf, 1, 2, 7, 8)
table.attach_defaults(canalf, 1, 2, 8, 9)
table.attach_defaults(cartebis, 1, 2, 9, 10)
table.row_spacings = 5
table.column_spacings = 5
table.border_width = 10

dialog.vbox.add(table)
dialog.show_all

# Run the dialog and output the data if user okays it
dialog.run do |response|
case response
  when Gtk::Dialog::RESPONSE_OK
system "echo > carte.txt %s\n" % [carte.text] 
    system "echo > ssid.txt %s\n" % [nomreseau.text]
    system "echo > canal.txt %s\n" % [canal.text]
    system "echo > page.txt %s\n" % [page.text] 
    system "echo > apmac.txt %s\n" % [apmac.text] 
    system "echo > apcanal.txt %s\n" % [apcanal.text] 
    system "echo > cartef.txt %s\n" % [cartef.text] 
    system "echo > bssidf.txt %s\n" % [bssidf.text] 
    system "echo > canalf.txt %s\n" % [canalf.text] 
    system "echo > cartedos.txt %s\n" % [cartebis.text] 
Frequence.hostapdGhz # A définir
end
end
dialog.signal_connect('response') { dialog.destroy }
}

button3.signal_connect("clicked")  {
dialog = Gtk::Dialog.new(
    "Configuraction du fake AP",
    nil,
    Gtk::Dialog::MODAL,
    [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
    [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
)
dialog.default_response = Gtk::Dialog::RESPONSE_OK
label1 = Gtk::Label.new("Interface du fake AP")
label2 = Gtk::Label.new("SSID")
label3 = Gtk::Label.new("Canal du fake AP")
label4 = Gtk::Label.new("Page de phishing")
label5 = Gtk::Label.new("Bssid de l'AP réel")
label6 = Gtk::Label.new("Canal de l'AP réel")

carte = Gtk::Entry.new
nomreseau = Gtk::Entry.new
canal = Gtk::Entry.new
page = Gtk::Entry.new
apmac = Gtk::Entry.new
apcanal = Gtk::Entry.new

table = Gtk::Table.new(4, 2, false)
table.attach_defaults(label1, 0, 1, 0, 1)
table.attach_defaults(label2, 0, 1, 1, 2)
table.attach_defaults(label3, 0, 1, 2, 3)
table.attach_defaults(label4, 0, 1, 3, 4) 
table.attach_defaults(label5, 0, 1, 4, 5)
table.attach_defaults(label6, 0, 1, 5, 6)
table.attach_defaults(carte,   1, 2, 0, 1)
table.attach_defaults(nomreseau,   1, 2, 1, 2)
table.attach_defaults(canal,   1, 2, 2, 3)
table.attach_defaults(page,   1, 2, 3, 4)
table.attach_defaults(apmac,   1, 2, 4, 5)
table.attach_defaults(apcanal,   1, 2, 5, 6)
table.row_spacings = 5
table.column_spacings = 5
table.border_width = 10

dialog.vbox.add(table)
dialog.show_all

# Run the dialog and output the data if user okays it
dialog.run do |response|
case response
  when Gtk::Dialog::RESPONSE_OK
system "echo > carte.txt %s\n" % [carte.text] 
    system "echo > ssid.txt %s\n" % [nomreseau.text]
    system "echo > canal.txt %s\n" % [canal.text]
    system "echo > page.txt %s\n" % [page.text] 
    system "echo > apmac.txt %s\n" % [apmac.text] 
    system "echo > apcanal.txt %s\n" % [apcanal.text] 
Berate.berateNormal 
end
end
dialog.signal_connect('response') { dialog.destroy }
}

button4.signal_connect("clicked")  {
dialog = Gtk::Dialog.new(
    "Configuration du fake AP",
    nil,
    Gtk::Dialog::MODAL,
    [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
    [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
)
dialog.default_response = Gtk::Dialog::RESPONSE_OK
label1 = Gtk::Label.new("Interface du fake AP")
label2 = Gtk::Label.new("SSID")
label3 = Gtk::Label.new("Canal du fake AP")
label4 = Gtk::Label.new("Page de phishing")
label5 = Gtk::Label.new("Bssid de l'AP réel")
label6 = Gtk::Label.new("Canal de l'AP réel")
label7 = Gtk::Label.new("Interface dos 5GHz")
label8 = Gtk::Label.new("Bssid 5GHz de l'ap réel")
label9 = Gtk::Label.new("Canal 5GHz de l'ap réel")
label10 = Gtk::Label.new("Interface dos 2.4GHz")


carte = Gtk::Entry.new
nomreseau = Gtk::Entry.new
canal = Gtk::Entry.new
page = Gtk::Entry.new
apmac = Gtk::Entry.new
apcanal = Gtk::Entry.new
cartef = Gtk::Entry.new
bssidf = Gtk::Entry.new
canalf = Gtk::Entry.new
cartebis = Gtk::Entry.new

table = Gtk::Table.new(4, 2, false)
table.attach_defaults(label1, 0, 1, 0, 1)
table.attach_defaults(label2, 0, 1, 1, 2)
table.attach_defaults(label3, 0, 1, 2, 3)
table.attach_defaults(label4, 0, 1, 3, 4) 
table.attach_defaults(label5, 0, 1, 4, 5)
table.attach_defaults(label6, 0, 1, 5, 6)
table.attach_defaults(label7, 0, 1, 6, 7)
table.attach_defaults(label8, 0, 1, 7, 8)
table.attach_defaults(label9, 0, 1, 8, 9)
table.attach_defaults(label10, 0, 1, 9, 10)
table.attach_defaults(carte,   1, 2, 0, 1)
table.attach_defaults(nomreseau, 1, 2, 1, 2)
table.attach_defaults(canal, 1, 2, 2, 3)
table.attach_defaults(page, 1, 2, 3, 4)
table.attach_defaults(apmac, 1, 2, 4, 5)
table.attach_defaults(apcanal, 1, 2, 5, 6)
table.attach_defaults(cartef, 1, 2, 6, 7)
table.attach_defaults(bssidf, 1, 2, 7, 8)
table.attach_defaults(canalf, 1, 2, 8, 9)
table.attach_defaults(cartebis, 1, 2, 9, 10)
table.row_spacings = 5
table.column_spacings = 5
table.border_width = 10

dialog.vbox.add(table)
dialog.show_all

# Run the dialog and output the data if user okays it
dialog.run do |response|
case response
  when Gtk::Dialog::RESPONSE_OK
system "echo > carte.txt %s\n" % [carte.text] 
    system "echo > ssid.txt %s\n" % [nomreseau.text]
    system "echo > canal.txt %s\n" % [canal.text]
    system "echo > page.txt %s\n" % [page.text] 
    system "echo > apmac.txt %s\n" % [apmac.text] 
    system "echo > apcanal.txt %s\n" % [apcanal.text] 
    system "echo > cartef.txt %s\n" % [cartef.text] 
    system "echo > bssidf.txt %s\n" % [bssidf.text] 
    system "echo > canalf.txt %s\n" % [canalf.text] 
    system "echo > cartedos.txt %s\n" % [cartebis.text] 
Ghz.berateGhz # A définir
end
end
dialog.signal_connect('response') { dialog.destroy }
}

button5.signal_connect("clicked")  {
dialog = Gtk::Dialog.new(
    "Interface",
    nil,
    Gtk::Dialog::MODAL,
    [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
    [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
)
dialog.default_response = Gtk::Dialog::RESPONSE_OK
label1 = Gtk::Label.new("Interface")



carte = Gtk::Entry.new

table = Gtk::Table.new(4, 2, false)
table.attach_defaults(label1, 0, 1, 0, 1)
table.attach_defaults(carte,   1, 2, 0, 1)
table.row_spacings = 5
table.column_spacings = 5
table.border_width = 10

dialog.vbox.add(table)
dialog.show_all

# Run the dialog and output the data if user okays it
dialog.run do |response|
case response
  when Gtk::Dialog::RESPONSE_OK
system "echo > carte.txt %s\n" % [carte.text] 
Wps.wpsSuck 
end
end
dialog.signal_connect('response') { dialog.destroy }
}

nb.signal_connect('change-current-page') { another_tab }

nb.append_page(button, label1)
nb.append_page(button1, label2)
nb.append_page(button2, label3)
nb.append_page(button3, label4)
nb.append_page(button4, label5)
nb.append_page(button5, label6)
window.add(nb)
window.show_all
Gtk.main
