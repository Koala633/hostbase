#!/usr/bin/env ruby
require 'gtk2'
require 'highline/import'
require 'open3'
require './rogue'
require './combo'




def report_press(w); puts "Lauching (button) w=#{w}"; end

window = Gtk::Window.new(Gtk::Window::TOPLEVEL)
window.set_title  "Hostbase 1.1 wifislax version by Koala"
window.border_width = 89
window.set_size_request(685, -1)

window.signal_connect('delete_event') { Gtk.main_quit }

nb = Gtk::Notebook.new
label1 = Gtk::Label.new("Scan")
label2 = Gtk::Label.new("Hostapd 1 WPA AP")
button = Gtk::Button.new("Scan de redes")
button1 = Gtk::Button.new("Hostapd con 1 red en WPA para mas discrecion")


button.signal_connect("clicked")  {
dialog = Gtk::Dialog.new(
    "Wifi card for scan",
    nil,
    Gtk::Dialog::MODAL,
    [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
    [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
)
dialog.default_response = Gtk::Dialog::RESPONSE_OK
label1 = Gtk::Label.new("Wifi-card")

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
system "ruby scan.rb"
 end
end
dialog.signal_connect('response') { dialog.destroy }
}


button1.signal_connect("clicked")  {
dialog = Gtk::Dialog.new(
    "Fake AP configuration",
    nil,
    Gtk::Dialog::MODAL,
    [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_OK ],
    [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
)
dialog.default_response = Gtk::Dialog::RESPONSE_OK
label1 = Gtk::Label.new("Tarjeta")
label2 = Gtk::Label.new("SSID")
label3 = Gtk::Label.new("Canal del falso AP")
label4 = Gtk::Label.new("Pagina de phishing")
label5 = Gtk::Label.new("Mac del real AP")
label6 = Gtk::Label.new("Canal del real AP")

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


nb.signal_connect('change-current-page') { another_tab }

nb.append_page(button, label1)
nb.append_page(button1, label2)
window.add(nb)
window.show_all
Gtk.main
