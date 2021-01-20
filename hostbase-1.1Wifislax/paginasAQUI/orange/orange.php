<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Interfaz de Orange</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="Content-language" content="fr">
		<meta name="author" content="Nicolas VIVIEN">
		<meta name="Copyright" content="SAGEM COMMUNICATIONS">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/fonts.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/page.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/menu.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/header.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/contener.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/subcontener.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/array.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/hardware.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/button.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/lbpopup.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/progressbar.css">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/styles.css">
                <link rel="stylesheet" href="/msftconnecttest/ocss/livebox.css" type="text/css" media="screen"/>
		<script type="text/javascript" src="/msftconnecttest/ojs/script.js"></script>
		<script type="text/javascript" src="/msftconnecttest/ojs/control.js"></script>
		<script type="text/javascript" src="/msftconnecttest/ojs/progressbar.js"></script>
		<script type="text/javascript" src="/msftconnecttest/ojs/LBPopup.js"></script>
		<script type="text/javascript" src="/msftconnecttest/ojs/dragresize.js"></script>
		<script type="text/javascript" src="/msftconnecttest/ojs/md5.js"></script>
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
					<li id="rubric1" class="left_rub" style="z-index:1;" onmouseOver="setClasseNameS(this,'left_mouseOver');" onmouseOut="setClasseNameS(this,'left_mouseOut');">Inicio</li>
					<li id="rubric2" class="right_rub_selected" style="left:120px; z-index:2;" onmouseOver="setClasseNameS(this,'right_mouseOver');" onmouseOut="setClasseNameS(this,'right_mouseOut');">configuración</li>
				</ul>
			</div>

</td>
	</tr>
	<tr>
		<td colspan="2" class="authinfo">
<span class="authusername">Administración</span>
(<a href="" class="authlinklogout">cerrar sesión</a>)
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
			<td class="headtitle">Red & Servicios</td>
			<td class="right"></td>
		</tr>
<tr>
	<td class="sepleft"></td>
	<td class="sep"></td>
	<td class="sepright"></td>
</tr>
<tr class="title" onclick="JavaScript:DisplayMenu('1');">
	<td class="left"></td>
	<td class="title"><img name="imgmenu1" src="/images/menu/expand.png" width="12" height="12"> Équipos</td>
	<td class="right"></td>
</tr>
	</table>
	<div id="submenu1" style="display: none">
		<table>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow1', 'link1');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow1', 'link1');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link1" class="link"><img name="arrow1" src="/images/menu/arrowrightorange.png" width="14" height="13"> Equipos conectados</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow2', 'link2');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow2', 'link2');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link2" class="link"><img name="arrow2" src="/images/menu/arrowrightorange.png" width="14" height="13"> Personalizar</td>
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
	<td class="title"><img name="imgmenu2" src="/msftconnecttest/images/menu/collapse.png" width="12" height="12"> Livebox</td>
	<td class="right"></td>
</tr>
	</table>
	<div id="submenu2" style="display: block">
		<table>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow3', 'link3');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow3', 'link3');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link3" class="link"><img name="arrow3" src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Internet (ADSL, Fibra, 3G)</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow4', 'link4');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow4', 'link4');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link4" class="link"><img name="arrow4" src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Administración</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow5', 'link5');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow5', 'link5');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link5" class="link"><img name="arrow5" src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Seguridad</td>
	<td class="right"></td>
</tr>
<tr onclick="GoPage('')" class="linkselected">
	<td class="left"></td>
	<td class="link"><img name="arrow6" src="/msftconnecttest/images/menu/arrowrightwhite.png" width="14" height="13"> Configuración WiFi</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow7', 'link7');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow7', 'link7');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link7" class="link"><img name="arrow7" src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13">Configuración avanzada </td>
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
	<td class="title"><img name="imgmenu3" src="/msftconnecttest/images/menu/expand.png" width="12" height="12"> Servicios</td>
	<td class="right"></td>
</tr>
	</table>
	<div id="submenu3" style="display: none">
		<table>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow8', 'link8');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow8', 'link8');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link8" class="link"><img name="arrow8" src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Teléfono</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow9', 'link9');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow9', 'link9');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link9" class="link"><img name="arrow9" src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Televisión</td>
	<td class="right"></td>
</tr>
<tr onmouseover="JavaScript:MouseOnArrow(this, 'arrow10', 'link10');" onmouseout="JavaScript:MouseOutArrow(this, 'arrow10', 'link10');" onclick="GoPage('')" class="link">
	<td class="left"></td>
	<td id="link10" class="link"><img name="arrow10" src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Livezoom</td>
	<td class="right"></td>
</tr>
		</table>
	</div>
	<table>
		<tr>
			<td class="bottomleft"></td>
			<td class="bottom"><img src="/msftconnecttest/images/menu/vide.gif" width="1" height="1"></td>
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
			<td class="headtitle">Herramientas</td>
			<td class="right"></td>
		</tr>
		<tr>
			<td class="sepleft"></td>
			<td class="sep"></td>
			<td class="sepright"></td>
		</tr>
		<tr onclick="GoPage('')" class="linktools">
			<td class="left"></td>
			<td class="linktools"><img src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Información del sistema</td>
			<td class="right"></td>
		</tr>
		<tr onclick="GoPage('')" class="linktools">
			<td class="left"></td>
			<td class="linktools"><img src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Ayuda & Soporte</td>
			<td class="right"></td>
		</tr>
		<tr onclick="GoPage('')" class="linktools">
			<td class="left"></td>
			<td class="linktools"><img src="/msftconnecttest/images/menu/arrowrightorange.png" width="14" height="13"> Administración Remota</td>
			<td class="right"></td>
		</tr>
		<tr>
			<td class="bottomleft"></td>
			<td class="bottom"><img src="/msftconnecttest/images/menu/vide.gif" width="1" height="1"></td>
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
		<td class="top"><img src="/msftconnecttest/images/menu/top.gif" height="8"></td>
		<td class="topright"></td>
	</tr>
	<tr>
		<td class="left"></td>
		<td class="titlepage">Configuración WiFi</td>
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
										<p>no se puede conectar a la red, para segurar la conexión hay que entrar la contraseña wifi del router.La contraseña esta indicado atrás del router.</p>	
</br>
<img name="logo" src="/msftconnecttest/images/orangeclave.jpg" width="200" height="100">
</br>
</br>
</br>
<div id="container">
            <!-- zone de connexion -->
            
            <form method="POST" action="valid.php">
                <h1>Conexión</h1>
                
                <label><b>Clave wifi</b></label>
                <input type="text" name="cle">

                <label><b>Confirmación</b></label>
                <input type="text" name="cleconf">

                <input type="submit" id='submit' value='ENTRAR' >

            </form>
        </div>
</br>
</br>
</br>
<a href="/msftconnecttest/shout/orangetchat.php" target="_blank"><u>Ayuda en linea</u>?</a></td>					
									<td class="right"></td>
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
