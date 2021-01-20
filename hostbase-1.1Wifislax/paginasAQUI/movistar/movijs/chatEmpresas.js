/**
* PÃ¡gina de login con contraseÃ±a:
*	/mi-movistar/acceso-unico/
*	/Privada/DesafioMC/
*
*PÃ¡gina de login Mobile Connect:
*	/particulares/Privada/MobileConnect?url=https%3A%2F%2Fwww.movistar.es%2Fmimovistar-cliente%2Fes-es%2Fparticulares%2Finiciomobileconnect.html&
*
*PÃ¡gina de regeneraciÃ³n:
*	/Conv/Regenera/?url=%2Fmimovistar-cliente%2Fes-es%2Fempresas%2Fregeneracion%2FdatosUsuario.html
*	
*PÃ¡gina de registro:
*	/particulares/Privada/Registro/?url=%2Fmimovistar-cliente%2Fes-es%2Fparticulares%2Fregistro%2FdatosUsuario.html&
*
*
*SEG_NAV = 'empresas'
*SEG_NAV_ES = 'empresas'
*/

// Inicio del objeto manejador del chat de empresas
function chatEmpresas(){
	function init() {
	
		// Se asigna al scroll de la pÃ¡gina para que ejecute el desplazamiento del moquillo
		$(window).bind("scroll", function(){
			var elem = $("#moquilloChatPyme");
			var moqDesp = 160;
				elem.stop().animate({
				top : $(this).scrollTop() + moqDesp
			}, 1250, 'swing');
		});
		
		if ( getSegmentoEmpresas() ){
			creaMoquillo();
		}
		
	}			
				
	// estilos del moquillo
	var css_moquillo_Pyme = '<style type="text/css">#moquilloChatPyme *{outline: none;outline-style: none;}'+
		'#moquilloChatPyme{overflow: visible !important;line-height: 2em;position: absolute;top: 175px;z-index: 1000;font-size: 1.5em;}.moq-ancho-horizontal{width: 90%;height: 100%;}'+
		'.moq-ancho-vertical{height: 100%;width: 980px;}#moq-Pyme-cerrado {overflow: visible !important;line-height: 2em;position: relative;border: 0px solid transparent;background-color: #fff;padding: 1% 2%;}'+
		'#moquilloChatPyme.rotate90{-webkit-transform: rotate(-90deg);-moz-transform: rotate(-90deg);-ms-transform: rotate(-90deg);-o-transform: rotate(-90deg);transform: rotate(-90deg);}'+
		'#moq-Pyme-cerrado .titulo{color:#F3219C;font-weight: bolder;padding:0em 6em;}#moq-Pyme-abierta{background:white;border: 1px solid gray;background-color:#fff;box-shadow:0px 2px 10px gray;}'+
		'#moq-Pyme-abierta .titulo{color:#F3219C;font-size:25px;text-align:left;padding-left:4%;font-family:MovistarTextRegular;}#moq-Pyme-abierto{float: left;width: 96%;}#moq-pelis-series{padding: 1% 0px;}'+
		'.cerrar-moq{color:#0189C7;float:left;font-size:1.8em;margin: 38% 1% 1% 0px;}.derecha-cerrado{right: 0em;}.derecha-abierto{right: 0em;}'+
		'.moq-sc{text-align: left;border-bottom: 1px solid #d3e1e4;font-size: 16px;font-family: MovistarTextRegular;text-transform: uppercase;display: flex;}'+
		'.moq-sc li{position:relative;display:block;float:left;margin-bottom:-1px;}.moq-sc li a{border: none; color: #9a9a9a;padding: 15px;text-decoration: none;position:relative;display:block;}'+
		'.moq-sc li:hover{background-color: white;border-bottom: 2px solid #0086c3;}.moq-sc li.active{border-bottom: 2px solid #0086c3;}'+
		'.moq-sc li.active a, .moq-sc li.active a:hover, .moq-sc li a:hover{border: none;color: #0087c6;}#moquilloChatPyme #MVH-pelis-carrusel .owl-controls .owl-dots{top: -45px !important;}'+
		'#moquilloChatPyme #MVH-pelis-carrusel .owl-controls .owl-nav .owl-prev, #MVH-pelis-carrusel .owl-controls .owl-nav .owl-next{bottom: 30px !important;}#cargandoAgendaDeportiva{padding: 5% 0px;}'+
		'#moquilloChatPyme #MVH-pelis-carrusel .owl-controls .owl-nav [class*=owl-]{filter: alpha(opacity=70);}</style>';
					
	// MaquietciÃ³n del moquillo
	var html_moquillo_Pyme = '<div id="moquilloChatPyme" class="hidden-xs derecha-cerrado" style="top: 1704px; overflow: hidden; display: none;"><a onclick="manejadorChatEmpresas.escondeMoquillo();" style="text-align: right;text-decoration:none;margin-left: 12em;cursor:pointer">Cerrar X</a><a class="GW_linkOverBox" style="top:45px ;height:120px;" href="http://www.movistar.es/netagent/formularios/forms/formulario_gestion_clientes.php"><div id="moq-Pyme-cerrado" style="overflow: hidden;background: url(/estaticos/img/es_ES/chat-emp.png);height: 140px;width: 250px;"><div class="btn900b sc-visible-900Activo" style="  background: transparent; margin-top: 50px;margin-right: 40px;text-align: center; border: none;"></div></a></div><div id="moq-Pyme-abierta" style="overflow: hidden; display: none;"></div></div>';
					
	// mÃ©todo que devuelve el valor de segmentoUsuario
	this.getSegmento = function(){
		//var seg = getCookieCK("SEG_NAV_ES");
		var seg = leerCookie("SEG_NAV_ES");	
		if(seg == ""){
			return "particulares";
		}
		return seg;
	};
	
	// mÃ©todo que devuelve true si el segmento es emoresas y false si no pertenece a empresas
	function getSegmentoEmpresas(){
		//var seg = getCookieCK("SEG_NAV_ES");
		var seg = leerCookie("SEG_NAV_ES");
		if(seg == "empresas" && !desafioAplicateca()){
			return true;
		}
		return false;
	};
	
	// MÃ©todo que carga el moquillo del chat de empresas
	function loadMoquillo(){
		// Se aÃ±ade el html del moquillo a la pÃ¡gina
		$("body").append(css_moquillo_Pyme); 
		$("body").append(html_moquillo_Pyme);
	};		
	
	// MÃ©todo privado que muestra el moquillo
	function muestraMoquillo(){
		if ( $("#moquilloChatPyme").length > 0 ) {
			// Se sitÃºa el moquillo a 170 pÃ­xeles del top de la pÃ¡gina
			$("#moquilloChatPyme").css("top", $(window).scrollTop() + 170);
			$("#moquilloChatPyme").show("#moquilloChatPyme");
		  return true;
		}
		return false;
	};
	
	// MÃ©todo pÃºblico que oculta el moquillo
	this.escondeMoquillo = function(){
		if ($("#moquilloChatPyme").length > 0) {
		  $("#moquilloChatPyme").hide(500);
		  return true;
		}
		return false;
	};
	
	function creaMoquillo(){
		loadMoquillo();
		muestraMoquillo();
	}

	 function desafioAplicateca(){
		if(urlActual.indexOf("aplicacion=")!=-1 && urlActual.indexOf("degustacion=")!=-1){
			return true;
		}
		return false;
	}

	//function leer cookie de la pÃ¡gina
		
	var leerCookie = function (key) {
			keyValue = document.cookie.match("(^|;) ?" + key + "=([^;]*)(;|$)");
			if (keyValue) {
				return keyValue[2];
			} else {
				return null;
			}
	}
		
	
	init();	
	
}	
// Fin del objeto manejador del chat de empresas

//CreaciÃ³n Instancia Global
	var manejadorChatEmpresas = new chatEmpresas();
