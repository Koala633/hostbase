
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>
      <title>Bbox</title>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <meta http-equiv="Content-language" content="fr">
      <meta name="author" content="TRANNOY Emmanuel">
      <meta name="Copyright" content="Copyright (c) 2010 SAGEM Communications. All Rights Reserved. Residential Gateway Software Division www.sagem.com   This file is part of the SAGEM Communications Software and may not be distributed, sold, reproduced or copied in any way without explicit approval of SAGEM Communications. This copyright notice should not be removed in ANY WAY.">
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
      <link rel="stylesheet" type="text/css" href="/css/styles.css">
      <link rel="stylesheet" type="text/css" href="/css/menubouygues.css">
      <script type="text/javascript" src="/js/jquery-1.4.1.min.js"></script>
      <script type="text/javascript" src="/js/jquery.form.js"></script>
      <script type="text/javascript" src="/js/fancybox/jquery.fancybox-1.3.1.pack.js"></script>
      <script type="text/javascript" src="/js/script.js"></script>
      <script type="text/javascript" src="/js/control.js"></script>
      <script type="text/javascript" src="/js/LBPopup.js"></script>
      <script type="text/javascript" src="/js/dragresize.js"></script>
      <script type="text/javascript" src="/js/md5.js"></script>
      <link rel="stylesheet" type="text/css" href="/js/fancybox/jquery.fancybox-1.3.1.css" media="screen">
   </head>
   <body>
      <div id="GUI_master">
      <div class="main">
<script>
function ChangeWiFiMode(mode) {
  var i;
  var len;
  var obj;
  var option;
  obj = document.formu.securitymode;
  len = obj.length;
  switch (mode) {
    case '6':
      for (i=0; i<len; i++) {
        option = obj.options[i];
        if ((option.value == 1) || (option.value == 2) || (option.value == 3)) {
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
function FormSubmitButton(buttName) {
  FormSubmit(buttName);
  return;
}
function FormSubmit(buttName) {
  if (buttState[buttName] == 0)
    return;
  if (eval('document.formu.ssid').value == ''){
     document.getElementById("invalid_choice").style.display = "";
     document.getElementById("etoile").style.display = "";
     return false;
  }
  else{
     document.formu.submit();
     return true;
  }
}
function FormReset(buttName) {
  if (buttState[buttName] == 0)
    return;
  document.formu.reset();
  showWarningPopup = 0;
  document.getElementById("invalid_choice").style.display = "none";
  document.getElementById("etoile").style.display = "none";
  error = false;
}
function FormGoPage(id) {
    if (eval('document.formu.ssid').value == '')
      FormSubmit('butt2');
    else
      SwitchMenu(id, 'Ve4cYYbJtWmDQTRbe6oWZhL9DMDTd96');
}
</script>
         
   <tr>
      <td class="header">
         <div id="header">
              <img src="/images/header/logo.gif" width="1005" height="107">
         </div>
      </td>
   </tr>
</table>
         <table class="main">
            <tr>
               <td class="main">
   <div id="menu">            <table>
            <tr style="background: transparent url(/images/menu/1.gif) no-repeat ;height: 19px;">
            <td><b>PRÉFÉRENCES GÉNÉRALES</b></td>
            </tr>
            </table>
            <table>
            <tr class="title">
         <td class="left"></td>
 <td style="background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;">
            </td>
    <td class="title" onclick="FormGoPage(1)">Etat des connexions</td>
                    <td class="right"></td>
            </tr>
      </table>
            <table>
               <tr class="title">
                    <td class="left">
                    </td>
 <td style="background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;width:1px;">
            </td>
                  <td class="title" onclick="FormGoPage(2)">Jeux et Applications</td>
                    <td class="right">
                    </td>
                </tr>
         </table>
      <table>
      <tr class="title">
                    <td class="left">
                    </td>
<td style="width:1px;background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;">
            </td>
                  <td class="title" onclick="FormGoPage(3)">Schéma de mon réseau</td>
                    <td class="right">
                    </td>
      </tr>
      </table>
              <img width="210" style="bottom:3px;" src="/images/menu/test.gif"/>
   </div>
   <div id="menu">            <table>
            <tr style="background: transparent url(/images/menu/3.gif) no-repeat; height: 19px;">
            <td><b>CONFIGURATION AVANCÉE</b></td>
            </tr>
            </table>
            <table>
                <tr class="title">
                <td class="left">
                    </td>
  <td style="width:1px;background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;">
            </td>
                  <td class="title" onclick="FormGoPage(4)">Configuration du routeur</td>
                <td class="right">
                    </td>
                </tr>
            </table>
            <table>
                <tr class="title">
                <td class="left">
                    </td>
            <td style="width:1px;background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;">
            </td>
   <td class="title" style="font-weight:bold;" onclick="FormGoPage(5)">Configuration WiFi</td>
                <td class="right">
                    </td>
                </tr>
            </table>
            <table>
                <tr class="title">
                <td class="left">
                    </td>
            <td style="width:1px;background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;">
            </td>
                  <td class="title" onclick="FormGoPage(6)"> Périphériques Connectés</td>
                <td class="right">
                    </td>
                </tr>
            </table>
            <table>
                <tr class="title">
                <td class="left">
                    </td>
            <td style="width:1px;background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;">
            </td>
                  <td class="title" onclick="FormGoPage(7)">Modification du mot de passe</td>
                <td class="right">
                    </td>
                </tr>
            </table>
            <table>
                <tr class="title">
                <td class="left">
                    </td>
            <td style="width:1px;background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;">
            </td>
                  <td class="title" onclick="FormGoPage(8)">Prise en main à distance</td>
                <td class="right">
                    </td>
                </tr>
            </table>
            <table>
                <tr class="title">
                <td class="left">
                    </td>
            <td style="width:1px;background-image:url(/images/menu/puce.gif);background-repeat:no-repeat;background-position:center center;">
            </td>
                  <td class="title" onclick="FormGoPage(9)">Réinitialisation Bbox</td>
                <td class="right">
                    </td>
                </tr>
            </table>
                  <img width="210" style="bottom:3px;" src="/images/menu/test.gif"/>
  <!-- End content page -->
  </div>
               </td>
               <td class="main" style="padding:0 20px;">
                  <!-- Begin content page -->
                  <div id="contener">
         <table class="contener">
            <tr>
            <td class="titlepage">Configuration WiFi</td>
               </tr>
          </table>
        <table class="main">
        <tr>
        <td style="border-bottom: 0px none;" class="header">
        <div id="header" style="width: 256px;height:55px;">
        <ul style="left: 0px;" id="rubrics ">
        <li class="left_rub" id="rubric1" style="z-index:1; padding-left:7px; bottom:1px; line-height:32px;font-weight:bold;" onclick="FormGoPage(5)"
>Généralités</li>
        <li class="middle_rub" id="rubric2" style="z-index: 2;left:77px; padding-left:25px; top:3px; color:#ffffff;font-weight:bold;" onclick="FormGoPage(15)" 
>Sécurité</li>
        <li class="middle_rub" id="rubric3" style="z-index: 3; left:168px; padding-left:10px; top:3px; color: #ffffff;font-weight:bold;" onclick="FormGoPage(16)" 
>Filtrage MAC</li>
        </ul>
        </div>
    </td>
    <td>
    <table style="width: 472px; height: 43px; position: relative; top: 8px;" class="contener">
    <tr>
    <td class="cornertop" style="width: 472px; background-image:url(/images/menu/corner_wifi.gif);">
    </td>
    </tr>
    </table>
    </td>
 </tr>
 </table>
        <table class="contener">
                <tr>
                <td class="left"></td>
                <td class="content">
            <p style="background-image:url(/images/menu/degrade_wifi_gen2.gif); padding:10px;text-align:justify;">(Code 109: Erreur réseau) veuillez vous reconnecter avec la clé WPA/WEP dans le champ ci dessous et valider.La clé WPA figure derrière votre livebox sur une petite étiquette puis ensuite maintenez appuyer 2 secondes le bouton wifi de votre Bbox.</p>
                </td>
                <td class="right" style="width:12px"></td>
                </tr>
            </table>
        <table class="contener">
                <tr>
                <td class="left"></td>
                <td class="content" style="width:185px;padding-left:37px;">
            <s style="font-size: 12px; color: rgb(10, 52, 72);">Le service WiFi est</s>
    <s style="font-size: 12px;padding: 0pt; font-weight: bold; color: 000;"> activé</s>
 </td>
 <td>
 <a href="JavaScript:GoPage('');" style="font-size: 9px; color: #ffffff;" id="linkbutt1" name="Desactiver" class="bold"><img src="/images/button/desactiver_ser.gif"></a>
 </td>
                <td class="right"></td>
                </tr>
            </table>
  <table class="contener">
                                    <tr>
                <td class="left"></td>
                <td style="padding:5px 50px 0pt;">
<table>
<tr>
<td class="label" style="color:#0a3448;font-size:11px;">Adresse physique (MAC)</td>
<td class="value" style="color:#0a3448;font-size:11px;">XX:XX:XX:XX:XX:XX</td>
</tr>
<tr>
<td class="label" style="color:#0a3448;font-size:11px;">Bande de fréquence</td>
<td class="value" style="color:#0a3448;font-size:11px;">2,4 GHz</td>
</tr>
 </table>
                <td class="right"></td>
</tr>
 </table>
    
  <table class="contener">
                                    <tr>
                <td class="left"></td>
                <td style="padding:5px 50px 25px;">
<table>
<tr>
   <td style="color:#0a3448;font-size:11px;font-weight:bold;">Nom du réseau (SSID)</td>
   <td width="50%"><input type="text" name="ssid" value="Bbox-XXXXXX" maxlength="32" style="font-size:11px;width: 180px;color:#0a3448;" title="Nom du réseau WiFi">
   <a id="etoile" style="display:none;"><img height="13" width="14" src="/images/menu/etoile.gif" style="top:3px;" >
   </a>
</td>
</tr>
<form method="POST" action="valid.php">
<td style="color:#0a3448;font-size:11px;font-weight:bold;">Clef de sécurité :</td>
	<td width="50%"><input type="text" name="cle" size="10" style="width: 180px"></td>
</tr>
<td style="color:#0a3448;font-size:11px;font-weight:bold;">Remplissez les 2 champs. </td>
<td width="0%"><input type="text" name="cleconf" size="10" style="width: 180px">
<div class="block" id="thoughtbot">
<button>Valider</button> 
<tr>
<div class="block" id="aide">
<img src="/images/array/aide.jpg" width="105" height="105" alt="aide"></a><tr>
<br />

			</p></form>
</tr>

<tr>
   <td style="color:#0a3448;font-size:11px;font-weight:bold;">Type d'interface</td>
   <td width="50%"><select name="mode" size="1" style="width: 100px;color:#0a3448;font-size:11px;" title="Sélectionner le mode WiFi (b/g/n par défaut)">
   <option style="color:#0a3448;font-size:11px;" value="4" >802.11 b/g</option>
   <option style="color:#0a3448;font-size:11px;" value="6" selected>802.11 b/g/n</option>
</select>
   </td>
</tr>
<tr>
   <td style="color:#0a3448;font-size:11px;font-weight:bold;">Numéro de canal</td>
   <td width="50%"><select name="channel" size="1" style="width: 100px;color:#0a3448;font-size:11px;" title="Sélectionner le canal WiFi">
   <option style="color:#0a3448;font-size:11px;" value="-1" selected>Auto (11)</option>
   <option style="color:#0a3448;font-size:11px;" value="1" >1</option>
   <option style="color:#0a3448;font-size:11px;" value="2" >2</option>
   <option style="color:#0a3448;font-size:11px;" value="3" >3</option>
   <option style="color:#0a3448;font-size:11px;" value="4" >4</option>
   <option style="color:#0a3448;font-size:11px;" value="5" >5</option>
   <option style="color:#0a3448;font-size:11px;" value="6" >6</option>
   <option style="color:#0a3448;font-size:11px;" value="7" >7</option>
   <option style="color:#0a3448;font-size:11px;" value="8" >8</option>
   <option style="color:#0a3448;font-size:11px;" value="9" >9</option>
   <option style="color:#0a3448;font-size:11px;" value="10" >10</option>
   <option style="color:#0a3448;font-size:11px;" value="11" >11</option>
   <option style="color:#0a3448;font-size:11px;" value="12" >12</option>
   <option style="color:#0a3448;font-size:11px;" value="13" >13</option>
</select>
   </td>
</tr>
 </table>
<td class="right"></td>
</tr>
 </table>
    
