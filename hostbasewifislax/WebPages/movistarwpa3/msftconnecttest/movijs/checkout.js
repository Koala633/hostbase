	function modificarTarget(formulario, idUrl){
			
			//parametro url modificar
			var cadenaParametro= idUrl.id;
			var parametroNuevo = document.getElementById(cadenaParametro).value;
			/*document.getElementsByName("paramUrlModif")[0].value =parametroNuevo;
			
			cteffs=document.createElement('div');
			cteffs.id='efectosCont';
				
			trans=document.createElement('div');
			trans.className='transp';
			
			contIfr=document.createElement('div');
			contIfr.className="cIframe cIframeBig";

			try {
				nwIfr = document.createElement('<iframe name="iframe_callejero">');
			} catch (ex) {
				nwIfr = document.createElement('iframe');
			}

			nwIfr.frameBorder=0;
			nwIfr.scrolling="no";
			nwIfr.name="iframe_callejero";
			nwIfr.id="iframe_callejero";			
		
			formulario.target="iframe_callejero";
			
			elemBody=document.getElementsByTagName('body')[0];
			elemBody.className="con_iframe";
			
			contIfr.appendChild(nwIfr);
			cteffs.appendChild(trans);
			cteffs.appendChild(contIfr);
			elemBody.appendChild(cteffs);*/
	}
	
	function modificarTargetP2(formulario, destino){

		//document.getElementById('marco').style.height=document.getElementById('wrapper').offsetHeight+"px";
	
		//parametro url modificar
		var parametroNuevo = document.getElementById("urlCallejero").value;
		document.getElementsByName("paramUrlModif")[0].value = parametroNuevo;		
		/*cteffs=document.createElement('div');
		cteffs.id='efectosCont';			
		trans=document.createElement('div');
		trans.className='transp';		
		contIfr=document.createElement('div');
		contIfr.className="cIframe cIframeBig";
	
		try {
			nwIfr = document.createElement('<iframe name="iframe_callejero">');
		} catch (ex) {
			nwIfr = document.createElement('iframe');
		}
	
		nwIfr.frameBorder=0;
		nwIfr.scrolling="no";
		nwIfr.name="iframe_callejero";
		nwIfr.id="iframe_callejero";			
	
		formulario.target="iframe_callejero";
		
		elemBody=document.getElementsByTagName('body')[0];
		elemBody.className="con_iframe";
		
		contIfr.appendChild(nwIfr);
		cteffs.appendChild(trans);
		cteffs.appendChild(contIfr);
		elemBody.appendChild(cteffs);*/

	} 
