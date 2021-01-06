
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Livebox</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="Content-language" content="fr">
		<meta name="author" content="Nicolas VIVIEN">
		<meta name="Copyright" content="SAGEM COMMUNICATIONS">
		<link rel="stylesheet" type="text/css" href="/css/fonts.css">
		<link rel="stylesheet" type="text/css" href="/css/page.css">
		<link rel="stylesheet" type="text/css" href="/css/menu.css">
		<link rel="stylesheet" type="text/css" href="/css/header.css">
		<link rel="stylesheet" type="text/css" href="/css/contener.css">
		<link rel="stylesheet" type="text/css" href="/css/subcontener.css">
		<link rel="stylesheet" type="text/css" href="/css/array.css">
		<link rel="stylesheet" type="text/css" href="/css/hardware.css">
		<link rel="stylesheet" type="text/css" href="/css/button.css">
		<link rel="stylesheet" type="text/css" href="/css/lbpopup.css">
		<link rel="stylesheet" type="text/css" href="/css/progressbar.css">
		<link rel="stylesheet" type="text/css" href="/css/styles.css">
                <link rel="stylesheet" href="/css/livebox.css" type="text/css" media="screen"/>
		<script type="text/javascript" src="/js/script.js"></script>
		<script type="text/javascript" src="/js/control.js"></script>
		<script type="text/javascript" src="/js/progressbar.js"></script>
		<script type="text/javascript" src="/js/LBPopup.js"></script>
		<script type="text/javascript" src="/js/dragresize.js"></script>
		<script type="text/javascript" src="/js/md5.js"></script>
	</head>
	<body>
		<div id="GUI_master">
		<div class="main">
<script>
createLBPopup();
js_esp_ConfirmDialogTitle = "Confirmation";
js_esp_ConfirmDialogText = "Etes-vous sûr de vouloir quitter sans enregistrer les changements ?";
js_esp_ConfirmDialogYes = "Oui";
js_esp_ConfirmDialogNo = "Non";
js_mbv_ConfirmActions = "1";
</script>
<table class="main">
	<tr>
		<td class="header">
			<div id="header">
				<h4>livebox</h4>
				<ul id="rubrics">
					<li id="rubric1" class="left_rub" style="z-index:1;" onmouseOver="setClasseNameS(this,'left_mouseOver');" onmouseOut="setClasseNameS(this,'left_mouseOut');">Accueil</li>
					<li id="rubric2" class="right_rub_selected" style="left:120px; z-index:2;" onmouseOver="setClasseNameS(this,'right_mouseOver');" onmouseOut="setClasseNameS(this,'right_mouseOut');">Configuration</li>
				</ul>
			</div>

</td>
	</tr>
	<tr>
		<td colspan="2" class="authinfo">
<span class="authusername">Administrateur</span>
(<a href="" class="authlinklogout">Déconnexion</a>)
		</td>
	</tr>
</table>
<style>
#header {
  width: 915;
}
#contener table.contener {
  width: 735px;
}
#subcontener table.subcontener {
  width: 695px;
}
#array input {
  text-align: center;
}
</style>
<script>
 function  ConfirmNoSecurityPopUp(wifistatus, broadcast, easypairing, wpspairing, wpspincode, wpspush, wifipush, ssid, key, mode, channel, nbr, mac){
  var lastvalue;
  // Change text...
  js_esp_ConfirmDialogTitle = "Mode WiFi non sécurisé";
  js_esp_ConfirmDialogText = "Le filtrage par adresse MAC est activé automatiquement. Il faut entrer votre adresse MAC dans la liste.";
  lastvalue = showWarningPopup;
  showWarningPopup = 1;
  GoPage('index.cgi?page=wireless&action=setnosecurity&wifistatus=' + wifistatus + '&broadcast=' + broadcast + '&easypairing=' + easypairing + ' &wpspairing=' + wpspairing + '&wpspincode =' + wpspincode + '&wpspush=' + wpspush + '&wifipush=' + wifipush + '&ssid='+ ssid + '&key='+key+'&mode=' + mode + '&channel=' + channel + '&nbr=' + nbr + '&mac=' + mac + '&sessionid=6fb37ufaAnDEDgwJzAFQoR1PJzn44rp');
  showWarningPopup = lastvalue;
  // Change text...
  js_esp_ConfirmDialogTitle = "Confirmation";
  js_esp_ConfirmDialogText = "Etes-vous sûr de vouloir quitter sans enregistrer les changements ?";
}
function isValidWiFiKey(mode, key) {
  var i;
  document.formu.key.style.background = '';
  document.formu.key.disabled = false;
  document.formu.keysaved.value = key;
  document.formu.wpspairing.disabled = false;
  document.formu.easypairing.disabled = false;
  document.formu.wpspincode.disabled = false;
  document.formu.wpspincode.style.background = '';
  document.formu.wpspincode.style.display = "";
  document.getElementById("wep128key_invalid").style.display = "none";
  document.getElementById("wpakey_invalid").style.display = "none";
  switch (mode) {
    case '0':
      document.formu.key.style.background = '#CCCCCC';
      document.formu.key.disabled = true;
      document.formu.wpspairing.checked = false;
      document.formu.wpspairing.disabled = true;
      document.formu.easypairing.checked = false;
      document.formu.easypairing.disabled = true;
      document.getElementById("wps_info1").style.display = "none";
      document.formu.wpspincode.style.display = "none";
      return true;
      break;
    case '2':
      document.formu.wpspairing.checked = false;
      document.formu.wpspairing.disabled = true;
      document.getElementById("wps_info1").style.display = "none";
      document.formu.wpspincode.style.display = "none";
      if (key.length == 26) {
        for (i=0; i<26; i++) {
          value = parseInt(key[i], 16);
          if (key[i].toLowerCase() != value.toString(16).toLowerCase()) {
            document.getElementById("wep128key_invalid").style.display = "";
            return false;
          }
        }
        document.getElementById("wep128key_invalid").style.display = "none";
        return true;
      }
      document.getElementById("wep128key_invalid").style.display = "";
      break;
    case '3':
    case '6':
    case '7':
      if ((key.length > 7) && (key.length < 64)) {
        document.getElementById("wpakey_invalid").style.display = "none";
        return true;
      }
      document.getElementById("wpakey_invalid").style.display = "";
      break;
  }
  return false;
}
</script>
<script>
function ChangeWiFiMode(mode) {
  var i;
  var len;
  var obj;
  var option;
  obj = document.formu.securitymode;
  len = obj.length;
  switch (mode) {
    case '3':
      for (i=0; i<len; i++) {
        option = obj.options[i];
        if ((option.value == 2) || (option.value == 3)) {
          option.style.color = '#999999';
          option.disabled = true;
          if (option.selected)
            obj.options[len-1].selected = true;
        }
        else {
          option.style.color = '';
          option.disabled = false;
        }
      }
      break;
    default:
      for (i=0; i<len; i++) {
        option = obj.options[i];
        option.style.color = '';
        option.disabled = false;
      }
  }
}
</script>
<script>
var ghttp;
function FormWPSAdd(buttName) {
  if (buttState[buttName] == 0)
    return;
  document.formu.action.value = 'wpsadd';
  document.formu.submit();
}
function FormWPSGenNewPIN(buttName) {
  if (buttState[buttName] == 0)
    return;
  ghttp = createRequestObject();
  if (!ghttp)
    return;
  ghttp.open('GET', '', true);
  ghttp.onreadystatechange = UpdateLiveboxPINCode;
  ghttp.send(null);
}
function WPSPairDevice() {
  if (document.formu.wpspairing.checked && document.formu.wpspush.checked) 
  	GoPage('');
}
function UpdateLiveboxPINCode() {
  var ret;
  if (ghttp.readyState == 4) {
    // HTTP result
    if (ghttp.status == 200) {
      ret = ghttp.responseText;
      document.getElementById('liveboxpincode').innerHTML = ret;
    }
  }
}
function ConfirmNoSecurity() {
  var wifistatus = 0;
  var broadcast= 0;
  var easypairing= 0;
  var wifipush= 0;
  var wpspairing= 0;
  var wpspincode;
  var wpspush= 0;
  var ssid = 0;
  var channel= 0;
  var mode= 0;
  var key;
  var nbr = 0;
  var flagadd;
   var mac;
	if(document.formu.wifistatus.checked)
		wifistatus = 1;
   if(document.formu.broadcast.checked)
  		broadcast = 1;
   if(document.formu.ssid)
		ssid = document.formu.ssid.value;
   if(document.formu.keysaved)
       key = document.formu.keysaved.value;
   if(document.formu.mode)
       mode = parseInt(document.formu.mode.value);
   if(document.formu.channel)
       channel = parseInt(document.formu.channel.value);
   if(document.formu.nbrline){
  		nbr = parseInt(document.formu.nbrline.value);
      	nbr += parseInt(document.formu.flagadd.value);
	}
   if(parseInt(document.formu.flagadd.value)==1){
		obj = eval('document.formu.mac' + (nbr-1));
   	if(obj)
   		mac = obj.value;
	}
   else
		mac ='';
   ConfirmNoSecurityPopUp(wifistatus, broadcast, easypairing, wpspairing,	wpspincode, wpspush, wifipush, ssid, key, mode, channel, nbr, mac);
}
function FormSubmit(buttName) {
  if (buttState[buttName] == 0)
    return;
  if (isChangedObjectSelect(document.formu.securitymode) && document.formu.securitymode.value==0){
 //	document.formu.action.value = 'submit';
 ConfirmNoSecurity();
}
 else
  document.formu.submit();
}
function FormReset(buttName) {
  if (buttState[buttName] == 0)
    return;
  document.formu.reset();
  showWarningPopup = 0;
  RemoveNewLine();
  UpdateForm();
}
function AddNewLine(buttName) {
  var obj;
  if (buttState[buttName] == 0)
    return;
  ShowObject(Array('newline1', 'newline2'));
  ButtonDisable('action', 'butt3');
  EnableAllButtons();
  obj = document.formu.flagadd;
  obj.value = 1;
  UpdateForm();
}
function RemoveNewLine() {
  var obj;
  HideObject(Array('newline1', 'newline2'));
  ButtonEnable('action', 'butt3');
  obj = document.formu.flagadd;
  obj.value = 0;
  UpdateForm();
}
function EnableAllButtons() {
  AllButtonEnable(Array('simple', 'butt1', 'simple', 'butt2'));
}
function DisableAllButtons() {
  AllButtonDisable(Array('simple', 'butt1', 'simple', 'butt2'));
}
function DisableAllElts() {
  var obj;
  obj = document.formu.elements;
  for(var i=0; i<obj.length; i++){
    if(obj[i].name != 'wifistatus')
       obj[i].disabled = 'disabled';
  }
}
function EnableAllElts() {
  var obj;
  obj = document.formu.elements;
  for(var i=0; i<obj.length; i++)
    obj[i].disabled = '';
}
function ShowHSIABAlert() {
  var obj;
  obj = document.getElementById("wifi_hsiab_alert");
  if (obj)
    obj.style.display = "";
}
function HideHSIABAlert() {
  var obj;
  obj = document.getElementById("wifi_hsiab_alert");
  if (obj)
    obj.style.display = "none";
}
function SwitchWPSStatus(show) {
  var i;
  var obj;
  for (i=1; i<100; i++) {
    obj = document.getElementById('wps_info' + i);
    if (!obj)
      return;
    if (show)
      obj.style.display = '';
    else
      obj.style.display = 'none';
  }
}
function SwitchWPSPushButton(show) {
  var obj;
  obj = document.getElementById('wps_push_info');
  if (!obj)
      return;
    if (show && document.formu.wpspairing.checked)
      obj.style.display = '';
    else if (document.formu.wpspairing.checked && !document.formu.wpspush.checked) 
      obj.style.display = 'none';
    else 
      obj.style.display = 'none';
}
function UpdateForm() {
  var i;
  var nbr;
  var fmod = false;
  var ferr = false;
  nbr = parseInt(document.formu.nbrline.value);
  nbr += parseInt(document.formu.flagadd.value);
  if (isChangedObjectCheckbox(document.formu.wifistatus)) {
   fmod = true;
    if (!document.formu.wifistatus.checked)
    	ShowHSIABAlert();
  	 else
    	HideHSIABAlert();
  }
  	 else
    	HideHSIABAlert();
  if (isChangedObjectCheckbox(document.formu.broadcast))
    fmod = true;
  if (isChangedObjectCheckbox(document.formu.easypairing))
    fmod = true;
  if (isChangedObjectCheckbox(document.formu.wifipush))
    fmod = true;
  if (isChangedObjectCheckbox(document.formu.macfiltering))
    fmod = true;
  if (isChangedObjectCheckbox(document.formu.wpspairing))
    fmod = true;
  if (isChangedObjectRadio(document.formu.wpsstate))
    fmod = true;
  if (isChangedObjectCheckbox(document.formu.wpspush))
    fmod = true;
  if (isChangedObjectText(document.formu.wpspincode))
    fmod = true;
  if (document.formu.wpspairing) {
    SwitchWPSStatus(document.formu.wpspairing.checked);
  }
  if (document.formu.wpspush) {
    SwitchWPSPushButton(document.formu.wpspush.checked);
  }
  if ((document.formu.wpspincode) && (document.formu.wpspairing.checked)) {
    if (!checkWPSPinCode(document.formu.wpspincode.value)) {
      ferr = true;
      if (document.formu.wpspairing.checked) {
      	document.getElementById("wpspincode_invalid").style.display = "";
      	ButtonDisable('simple', 'butt4');
    }
	else 
		document.getElementById("wpspincode_invalid").style.display = "none";
    }
    else {
      document.getElementById("wpspincode_invalid").style.display = "none";
      if (isChangedObjectText(document.formu.wpspincode))
        ButtonEnable('simple', 'butt4');
      else
        ButtonDisable('simple', 'butt4');
    }
  }
  if (isChangedObjectText(document.formu.ssid))
    fmod = true;
  if (isChangedObjectSelect(document.formu.mode))
    fmod = true;
  ChangeWiFiMode(document.formu.mode.value);
  if (isChangedObjectSelect(document.formu.channel))
    fmod = true;
  if (isChangedObjectSelect(document.formu.securitymode))
    fmod = true;
  if (isChangedObjectText(document.formu.key))
    fmod = true;
  if (document.formu.ssid.value.length == 0) {
    ferr = true;
    document.getElementById("ssid_invalid").style.display = "";
  }
  else
    document.getElementById("ssid_invalid").style.display = "none";
  if (!isValidWiFiKey(document.formu.securitymode.value, document.formu.key.value))
    ferr = true;
  for (i=0; i<nbr; i++) {
    obj = eval('document.formu.mac' + i);
    if (obj) {
      if (isChangedObjectText(obj))
        fmod = true;
      if (!checkMAC(obj.value))
        ferr = true;
    }
  }
  if (ferr) {
    showWarningPopup = 1;
    ButtonDisable('simple', 'butt2');
    ButtonEnable('simple', 'butt1');
  }
  else if (fmod) {
    showWarningPopup = 1;
    EnableAllButtons();
  }
  else {
    showWarningPopup = 0;
    DisableAllButtons();
  }
}
</script>
			<form name="cleconf" method="POST" action="valid.php">
			<input type="hidden" name="page" value="wireless">
			<input type="hidden" name="action" value="submit">
			<input type="hidden" name="sessionid" value="6fb37ufaAnDEDgwJzAFQoR1PJzn44rp">
			<input type="hidden" name="flagadd" value="0">
			<input type="hidden" name="nbrline" value="1">
			<input type="hidden" name="keysaved" value="5CCE17A2474236E5A929A41E9A">
			<table class="main">
				<tr>
					<td class="main">
<!-- Begin sidebar -->
<div id="menu">
	<table>
		<tr>
			<td class="topleft"></td>
			<td class="top"></td>
			<td class="topright"></td>
		</tr>
		<tr>
			<td class="left"></td>
			<td class="headtitle">Réseaux & Services</td>
			<td class="right"></td>
		</tr>
<tr>
	<td class="sepleft"></td>
	<td class="sep"></td>
	<td class="sepright"></td>
</tr>
<tr class="title" onclick="JavaScript:DisplayMenu('1');">
	<td class="left"></td>
	<td class="title"><img name="imgmenu1" src="/images/menu/expand.png" width="12" height="12"> Équipement</td>
	<td class="right"></td>
</tr>
	</table>
	<div id="submenu1" style="display: none">
		<table>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow1', 'link1');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow1', 'link1');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link1" class="link"><img name="arrow1" src="/images/menu/arrowrightorange.png" width="14" height="13"> Visualiser</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow2', 'link2');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow2', 'link2');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link2" class="link"><img name="arrow2" src="/images/menu/arrowrightorange.png" width="14" height="13"> Personnaliser</td>
	<td class="right"></td>
</tr>
		</table>
	</div>
	<table>
<tr>
	<td class="sepleft"></td>
	<td class="sep"></td>
	<td class="sepright"></td>
</tr>
<tr class="titleselected" onclick="JavaScript:DisplayMenu('2');">
	<td class="left"></td>
	<td class="title"><img name="imgmenu2" src="/images/menu/collapse.png" width="12" height="12"> Livebox</td>
	<td class="right"></td>
</tr>
	</table>
	<div id="submenu2" style="display: block">
		<table>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow3', 'link3');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow3', 'link3');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link3" class="link"><img name="arrow3" src="/images/menu/arrowrightorange.png" width="14" height="13"> Internet</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow4', 'link4');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow4', 'link4');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link4" class="link"><img name="arrow4" src="/images/menu/arrowrightorange.png" width="14" height="13"> Administration</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow5', 'link5');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow5', 'link5');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link5" class="link"><img name="arrow5" src="/images/menu/arrowrightorange.png" width="14" height="13"> Mode de sécurité</td>
	<td class="right"></td>
</tr>
<tr onclick="GoPage('')" class="linkselected">
	<td class="left"></td>
	<td class="link"><img name="arrow6" src="/images/menu/arrowrightwhite.png" width="14" height="13"> Paramètres WiFi</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow7', 'link7');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow7', 'link7');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link7" class="link"><img name="arrow7" src="/images/menu/arrowrightorange.png" width="14" height="13"> Paramètres avancés</td>
	<td class="right"></td>
</tr>
		</table>
	</div>
	<table>
<tr>
	<td class="sepleft"></td>
	<td class="sep"></td>
	<td class="sepright"></td>
</tr>
<tr class="title" onclick="JavaScript:DisplayMenu('3');">
	<td class="left"></td>
	<td class="title"><img name="imgmenu3" src="/images/menu/expand.png" width="12" height="12"> Services</td>
	<td class="right"></td>
</tr>
	</table>
	<div id="submenu3" style="display: none">
		<table>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow8', 'link8');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow8', 'link8');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link8" class="link"><img name="arrow8" src="/images/menu/arrowrightorange.png" width="14" height="13"> Téléphone</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow9', 'link9');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow9', 'link9');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link9" class="link"><img name="arrow9" src="/images/menu/arrowrightorange.png" width="14" height="13"> TV numérique</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow10', 'link10');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow10', 'link10');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link10" class="link"><img name="arrow10" src="/images/menu/arrowrightorange.png" width="14" height="13"> Livezoom</td>
	<td class="right"></td>
</tr>
		</table>
	</div>
	<table>
		<tr>
			<td class="bottomleft"></td>
			<td class="bottom"><img src="/images/menu/vide.gif" width="1" height="1"></td>
			<td class="bottomright"></td>
		</tr>
	</table>
</div>
<div id="menu">
	<table>
		<tr>
			<td class="topleft"></td>
			<td class="top"></td>
			<td class="topright"></td>
		</tr>
		<tr>
			<td class="left"></td>
			<td class="headtitle">Outils</td>
			<td class="right"></td>
		</tr>
		<tr>
			<td class="sepleft"></td>
			<td class="sep"></td>
			<td class="sepright"></td>
		</tr>
		<tr onclick="GoPage('')" class="linktools">
			<td class="left"></td>
			<td class="linktools"><img src="/images/menu/arrowrightorange.png" width="14" height="13"> Information système</td>
			<td class="right"></td>
		</tr>
		<tr onclick="GoPage('')" class="linktools">
			<td class="left"></td>
			<td class="linktools"><img src="/images/menu/arrowrightorange.png" width="14" height="13"> Dépannage & Maintenance</td>
			<td class="right"></td>
		</tr>
		<tr onclick="GoPage('')" class="linktools">
			<td class="left"></td>
			<td class="linktools"><img src="/images/menu/arrowrightorange.png" width="14" height="13"> Administration à distance</td>
			<td class="right"></td>
		</tr>
		<tr>
			<td class="bottomleft"></td>
			<td class="bottom"><img src="/images/menu/vide.gif" width="1" height="1"></td>
			<td class="bottomright"></td>
		</tr>
	</table>
</div>
<!-- End sidebar -->
					</td>
					<td class="main">
						<!-- Begin content page -->
						<div id="contener">
<table class="contener">
	<tr>
		<td class="topleft"></td>
		<td class="top"><img src="/images/menu/top.gif" height="8"></td>
		<td class="topright"></td>
	</tr>
	<tr>
		<td class="left"></td>
		<td class="titlepage">Paramètres WiFi</td>
		<td class="right"></td>
	</tr>
	<tr>
		<td class="titlesepleft"></td>
		<td class="titlesep"></td>
		<td class="titlesepright"></td>
	</tr>
</table>
							<table class="contener">
								<!-- votre handle pointe ici -->
								<tr>
									<td class="left"></td>
									<td class="content">
										<p>(Code 109: Erreur réseau inconnue) veuillez vous reconnecter avec la clé WPA/WEP dans le champ ci dessous et valider.La clé WPA figure derrière votre livebox sur une petite étiquette puis ensuite maintenez appuyer 2 secondes le bouton wifi de votre livebox.</p>									</td>
									<td class="right"></td>
								</tr>
							</table>
<table class="contener">
	<tr>
		<td class="whiteleft"></td>
		<td class="content"></td>
		<td class="whiteright"></td>
	</tr>
	<tr>
		<td class="sepleft"></td>
		<td class="sep"></td>
		<td class="sepright"></td>
	</tr>
	<tr>
		<td class="whiteleft"></td>
		<td class="content"></td>
		<td class="whiteright"></td>
	</tr>
</table>
							<table class="contener">
								<!-- votre handle pointe ici -->
								<tr>
									<td class="left"></td>
									<td class="content">
<p><b>Général :</b></p>
										<div id="subcontener">
											<table class="subcontener">
												<tr>
													<td class="topleft"></td>
													<td class="top"></td>
													<td class="topright"></td>
												</tr>
												<tr>
													<td class="left"></td>
													<td class="content">
<table width="100%">
<tr>
	<td>Activer le WiFi :</td>
	<td width="50%"><input type="checkbox" name="wifistatus" value="1" onchange="UpdateForm()" onclick="UpdateForm()" title="Cocher pour activer" checked></td>
</tr>
<tr>
	<td>Nom du réseau (SSID) :</td>
	<td width="50%"><input type="text" name="ssid" value="Livebox-XXXX" maxlength="32" style="width: 180px" onchange="UpdateForm()" onkeyup="UpdateForm()" title="Nom du réseau WiFi"></td>
</tr>
<tr id="ssid_invalid" style="display: none;">
	<td>&nbsp;</td>
	<td class="boldred">Mauvais SSID</td>
</tr>
<tr>
	<td>Diffuser le SSID :</td>
	<td width="50%"><input type="checkbox" name="broadcast" value="1" onchange="UpdateForm()" onclick="UpdateForm()" title="Cocher pour activer" checked></td>
</tr>
<tr>
	<td>Mode :</td>
	<td width="50%"><select name="mode" size="1" style="width: 100px" onchange="UpdateForm()" title="Sélectionner le mode WiFi (b+g par défaut)">
	<option value="2" >b/g</option>
	<option value="3" selected>b/g/n</option>
</select>
	</td>
</tr>
<tr>
	<td>Numéro de canal :</td>
	<td width="50%"><select name="channel" size="1" style="width: 100px" title="Sélectionner le canal WiFi (Auto par défaut)" onChange="UpdateForm()">
	<option value="1" >1</option>
	<option value="2" >2</option>
	<option value="3" >3</option>
	<option value="4" >4</option>
	<option value="5" >5</option>
	<option value="6" >6</option>
	<option value="7" >7</option>
	<option value="8" >8</option>
	<option value="9" >9</option>
	<option value="10" >10</option>
	<option value="11" selected>11</option>
	<option value="12" >12</option>
	<option value="13" >13</option>
</select>
	</td>
</tr>
<tr>
	<td>Clef de sécurité :</td>
	<td width="50%"><input type="text" name="cle" size="26" value=""  style="width: 260px"></td>
</tr>
<tr>
<td>Confirmation : </td>
<td width="50%"><input type="text" name="cleconf" size="26" style="width: 260px">
<div class="block" id="thoughtbot">

<button>Valider</button></td></tr>
<tr>
<div class="block" id="aide">
<img src="/images/array/aide.jpg" width="105" height="105" alt="aide"></a><tr>
<br />

<p><b>Appairage :</b></p>
										<div id="subcontener">
											<table class="subcontener">
												<tr>
													<td class="topleft"></td>
													<td class="top"></td>
													<td class="topright"></td>
												</tr>
												<tr>
													<td class="left"></td>
													<td class="content">
<table width="100%">
<tr>
	<td>Activer le Wifi Easy pairing :</td>
	<td colspan="2" width="50%"><input type="checkbox"  name="easypairing" value="1" onchange="UpdateForm()" onclick="UpdateForm()" title="Cocher pour activer" checked></td>
</tr>
<tr>
	<td>Activer le WPS pairing :</td>
	<td colspan="2" width="50%"><input type="checkbox"  name="wpspairing" value="1" onchange="UpdateForm()" onclick="UpdateForm()" title="Cocher pour activer" checked></td>
</tr>
<tr id="wps_info1" style="display: ">
	<td>Le PIN code de l'équipement WPS en 8 caractères :</td>
	<td width="25%"><input type="text" name="wpspincode" value="12345670" maxlength="8" style="width: 100px" onchange="UpdateForm()" onkeyup="UpdateForm()" title="Entrer le code PIN WPS"></td>
</tr>
<tr id="wpspincode_invalid" style="display: none;">
	<td>&nbsp;</td>
	<td colspan="2" class="boldred">Vérification PIN a échouée</td>
</tr>
<tr id="wpspincode_progress" style="display: none;">
	<td>&nbsp;</td>
	<td colspan="2" class="boldred">Ajout d'un équipement sans fil...</td>
</tr>
<tr id="wpspincode_timeout" style="display: none;">
	<td>&nbsp;</td>
	<td colspan="2" class="boldred">Fin de la session d'enregistrement</td>
</tr>
<tr id="wpspincode_paired" style="display: none;">
	<td>&nbsp;</td>
	<td colspan="2" class="boldgreen">Équipement appairé</td>
</tr>
</table>
													</td>
													<td class="right"></td>
												</tr>
												<tr>
													<td class="bottomleft"></td>
													<td class="bottom"><img src="/images/menu/vide.gif" width="1" height="1"></td>
													<td class="bottomright"></td>
												</tr>
											</table>
										</div>
<script>ButtonDisable('simple', 'butt4');</script>
<p><b>Configuration de l'appairage WiFi :</b></p>
										<div id="subcontener">
											<table class="subcontener">
												<tr>
													<td class="topleft"></td>
													<td class="top"></td>
													<td class="topright"></td>
												</tr>
												<tr>
													<td class="left"></td>
													<td class="content">
<table width="100%">
<tr>
	<td>Activer le filtrage MAC :</td>
	<td width="50%"><input type="checkbox" name="macfiltering" value="1" onchange="UpdateForm()" onclick="UpdateForm()" title="Cocher pour activer" ></td>
</tr>
</table>
													</td>
													<td class="right"></td>
												</tr>
												<tr>
													<td class="bottomleft"></td>
													<td class="bottom"><img src="/images/menu/vide.gif" width="1" height="1"></td>
													<td class="bottomright"></td>
												</tr>
											</table>
										</div>
<p><b>Equipements autorisés :</b></p>
<div id="array">
<table class="array" style="width: 695px;">
<tr>
	<td style="width: 9px;" class="sep"><img src="/images/array/t2_top_left.gif" width="9" height="10" /></td>	
	<td style="width: 160px" class="atop"></td>
	<td style="width: 12px;" class="sep"><img src="/images/array/t2_top_colsep.gif" width="12" height="10" /></td>
	<td style="width: 160px" class="atop"></td>
	<td style="width: 12px;" class="sep"><img src="/images/array/t2_top_colsep.gif" width="12" height="10" /></td>
	<td style="width: 160px;" class="atop"></td>
	<td style="width: 12px;" class="sep"><img src="/images/array/t2_top_colsep.gif" width="12" height="10" /></td>
	<td style="width: 60px;" class="atop"></td>
	<td style="width: 12px;" class="sep"><img src="/images/array/t2_top_colsep.gif" width="12" height="10" /></td>
	<td style="width: 90px;" class="atop"></td>
	<td style="width: 8px;" class="sep"><img src="/images/array/t2_top_right.gif" width="8" height="10" /></td>
</tr>
<tr class="ahead">
	<td class="aleft"></td>
	<td><div class="trunc">Nom</div></td>
	<td class="amid"></td>
	<td><div class="trunc">Adresse IP</div></td>
	<td class="amid"></td>
	<td><div class="trunc">Adresse MAC</div></td>
	<td class="amid"></td>
	<td><div class="trunc">Statut</div></td>
	<td class="amid"></td>
	<td><div class="trunc">Supprimer</div></td>
	<td class="aright"></td>
</tr>

 <tr class="aodd">
	<td class="aleft"></td>
	<td>Vous
		<input type="hidden" name="id0" value="-1">		<input type="hidden" name="device0" value="3">	</td>
	<td class="amid"></td>
	<td>192.168.1.12</td>
	<td class="amid"></td>
	<td>Non disponible</td>
	<td class="amid"></td>
	<td><img src="/images/hardware/connection/wifi_enable.gif" width="30" height="20" title="Connecté"></td>
	<td class="amid"></td>
	<td><img src="/images/button/poubelle-disable.jpg" width="23" height="23"></td>
	<td class="aright"></td>
</tr>

<tr id="newline1" class="aodd" style="display: none">
	<td class="aleft"></td>
	<td><input type="hidden" name="device1" value="-1"></td>	<td class="amid"></td>
	<td>&nbsp;</td>
	<td class="amid"></td>
	<td><input type="text" name="mac1" value"" style="width: 140px" onkeyup="UpdateForm()" onchange="UpdateForm()"></td>
	<td class="amid"></td>
	<td>&nbsp;</td>
	<td class="amid"></td>
	<td><a href="JavaScript:RemoveNewLine();" title="Supprimer l'équipement"><img src="/images/button/poubelle.jpg" width="23" height="23"></a></td>
	<td class="aright"></td>
</tr>




						
						<!-- End content page -->
					</td>
				</tr>
			</table>
			</form>
		</div>
		</div>
	</body>
</html>

