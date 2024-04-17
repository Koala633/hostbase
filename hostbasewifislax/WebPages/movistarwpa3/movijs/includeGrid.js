function getCookieInit(c_name) {
	var c_value = document.cookie;
	var c_start = c_value.indexOf(" " + c_name + "=");
	if (c_start == -1) {
		c_start = c_value.indexOf(c_name + "=");
	}
	if (c_start == -1) {
		c_value = null;
	} else {
		c_start = c_value.indexOf("=", c_start) + 1;
		var c_end = c_value.indexOf(";", c_start);
		if (c_end == -1) {
			c_end = c_value.length;
		}
		c_value = unescape(c_value.substring(c_start, c_end));
	}
	return c_value;
}

if (window.location.pathname == '/particulares' ||
	window.location.pathname == '/particulares/' ||
	(window.location.pathname == '/' && getCookieInit("SEG_NAV") == 'particulares') ||
	window.location.pathname == "/particulares/pruebas/homeVelocidad") {

	document.write('<script type="text/javascript" src="/estaticos/Waterfall/js/includeGrid2.js"></script>');

} else {
	//Version 1.004

	var procesoOrquestador = (document.location.href.indexOf("/Aplicaciones/procesoCompra") != -1);


	//document.write('<meta name="viewport" content="width=device-width, initial-scale=0.8" />');
	document.write('<script type="text/javascript" src="/estaticos/GridResp/js/jquery-1.11.1.min.js"></script>');
	document.write('<script type="text/javascript" src="/estaticos/GridResp/js/bootstrap.min.js"></script>');
	document.write('<script type="text/javascript" src="/estaticos/GridResp/js/modernizr-2.7.1.js"></script>');
	document.write('<script type="text/javascript" src="/estaticos/js/sso.js"></script>');
	document.write('<script src="/estaticos/cgm_log/js/cgm_log.js"></script> ');
	document.write('<script src="/estaticos/FusionProcess/configTV/js/configTvManager.js"></script>');
	document.write('<script src="/estaticos/cgm_viewedItems/js/cgm_addViewedItem.js"></script>');
	document.write('<script src="/estaticos/IC/js/IC.js"></script>');
	//document.write('<script src="//cdnjs.cloudflare.com/ajax/libs/airbrake-js/0.5.9/client.min.js"></script>');
	//document.write("<script type='text/javascript'>window._trackJs = { token: '6e31776a88544d86bb30949685771403'};</script>");
	//document.write("<script type='text/javascript' src='//cdn.trackjs.com/releases/current/tracker.js'></script>");
	document.write("<script type='text/javascript' src='/estaticos/js/SC.js'></script>");

	//document.write('<script type="text/javascript" src="/estaticos/GridResp/js/sifr.js"></script>');

	//Metrics
	document.write('<script type="text/javascript" src="/estaticos/Metrics/IncludeMetrics.js"></script>');

	//MovContainer
	document.write('<script type="text/javascript" src="/estaticos/Orquestador/js/MovContainer.js"></script>');

	//Servicio Enrutador
	document.write('<script type="text/javascript" src="/estaticos/Telco/js/enrutador.js"></script>');

	

	document.write('<script type="text/javascript" src="/estaticos/js/gw-col.js"></script>');
	document.write('<script type="text/javascript" src="/estaticos/GridResp/js/commons.js"></script>');
	document.write('<script type="text/javascript" src="/estaticos/js/tealium/s_code.js"></script>');

	//Inicio js supercapa
	if (!procesoOrquestador) {

		//condicion piloto tmo
		if ((document.location.href.indexOf("/particulares/prueba-piloto-home-2") < 0) && (document.location.href.indexOf("/particulares/prueba-piloto-home-3") < 0)) {
			document.write('<script type="text/javascript"	src="//www.movistar.es/atcliente/c2c/venta-asistida-externo/polaris.venta.asistida.externo/polaris.venta.asistida.externo.nocache.js"></script>');
		}

		document.write('<script type="text/javascript" src="/estaticos/js/SC.js"></script>');

	}
	//Fin js supercapa


	if (!procesoOrquestador) document.write('<script type="text/javascript" src="/estaticos/GridResp/js/base64.js"></script>');
	document.write('<script type="text/javascript" src="/estaticos/GridResp/js/gr-function.js"></script>');
	if (!procesoOrquestador) document.write('<script type="text/javascript" src="/estaticos/GridResp/js/menufixResp.js"></script>');
	document.write('<script type="text/javascript" src="/estaticos/js/debug_error.js"></script>');

	//CSI excluida en proceso de compra de orquestador
	if (!procesoOrquestador) document.write('<script type="text/javascript" src="/estaticos/js/csi.js"></script>');


	document.write('<link rel="stylesheet" type="text/css" href="/estaticos/GridResp/css/import.css" />');

	if (document.location.pathname.indexOf("/particulares/internet/adsl-fibra-optica/wifi/") > -1) {
		document.write('<script type="text/javascript" src="/estaticos/js/mapa.js"></script>');
	}

	(function () {
		try {
			document.write('<script type="text/javascript" src="//tags.bluekai.com/site/39374?ret=js&limit=1"></script>');
			var bkCatIdSt = ",";
			var bkCampStr = ",";
			if (typeof (bk_results) != "undefined" && typeof (bk_results.campaigns) != "undefined") {
				for (var i = 0; i < bk_results.campaigns.length; i++) {
					bkCampStr += bk_results.campaigns[i].campaign + ",";
					for (var j = 0; j < bk_results.campaigns[i].categories.length; j++) {
						if (typeof (bk_results.campaigns[i].categories[j].categoryID) != "undefined") {
							var s = bk_results.campaigns[i].categories[j].categoryID + "";
							bkCatIdSt += bk_results.campaigns[i].categories[j].categoryID + ",";
						}
					}
				}
			}
		} catch (e) {}
	})();




	function bkArray() {

		var bkCmpIDs = [];

		for (var i = 0; i < bk_results.campaigns.length; i++) {
			bkCmpIDs.push(bk_results.campaigns[i].campaign)
		};

		var stingbkCmp = JSON.stringify(bkCmpIDs);
		return stingbkCmp;
	}

	var getCookieForTarget = function(cname){
	
	    var name = cname + "=";
	    var decodedCookie = decodeURIComponent(document.cookie);
	    var ca = decodedCookie.split(';');
	    for(var i = 0; i <ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0) == ' ') {
	            c = c.substring(1);
	        }
	        if (c.indexOf(name) == 0) {
	            return c.substring(name.length, c.length);
	        }
	    }
	    return "";

	};

	//targetPageParams function
	function targetPageParams() {
		var result = "profile.bkCmpIDs=" + bkArray()+ "&profile.telco=" + getCookieForTarget('GWuserType')+"&segmento=" + getCookieForTarget('SEG_NAV');
		return result;
	};

	document.write('<script type="text/javascript" src="/estaticos/Personalizacion/js/at.js"></script>');




	


}
