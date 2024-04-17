if(window.location.pathname == '/particulares' 
	|| window.location.pathname == '/particulares/' 
	|| (window.location.pathname == '/' && getCookieInit("SEG_NAV") == 'particulares')
	|| window.location.pathname == "/particulares/pruebas/homeVelocidad")
{
	document.write('<link rel="stylesheet" type="text/css" href="/estaticos/GridResp/css/import.css" />');
	importJS('/estaticos/Waterfall/js/gw-col_footer.js', true, true);
	if (!procesoOrquestador){
		importJS('//www.movistar.es/atcliente/c2c/venta-asistida-externo/polaris.venta.asistida.externo/polaris.venta.asistida.externo.nocache.js', false, true);
		importJS('/estaticos/js/SC.js', false, true);
	}
	importJS('/estaticos/Waterfall/js/sso.js', true, true);
	//Enrutador
	importJS('/estaticos/Telco/js/enrutador.js', false, true);

	//CSI excluida en proceso de compra de orquestador
	if (!procesoOrquestador)
		importJS('/estaticos/js/csi.js', false, true);

	importJS('/estaticos/js/debug_error.js', false, true);

	if (!procesoOrquestador)
		importJS('/estaticos/GridResp/js/menufixResp.js', false, true);
}


