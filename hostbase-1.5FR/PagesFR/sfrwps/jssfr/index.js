function updateStatus(response){var rsp=$(response);var link=rsp.find("internet>link");$("#wan_status").text(link.attr("text"));$("#wan_status").attr("class",link.attr("val")=="up"?"enabled":"disabled");$("#wan_uptime").text($(response).find("internet>uptime").attr("val"));$("#modem_uptime").text($(response).find("system>uptime").attr("val"));var wlan_status=rsp.find("wifi>link");var wlan_status_ac=rsp.find("wifi>linkac");$("#wlan_status").attr("class",wlan_status.attr("val")=="on"?"enabled":"disabled");$("#wlan_status_ac").attr("class",wlan_status_ac.attr("val")=="on"?"enabled":"disabled")}(function($){$.fn.konami=function(fn,params){params=$.extend({},$.fn.konami.params,params);this.each(function(){var tgt=$(this);tgt.bind("konami",fn).bind("keyup",function(event){$.fn.konami.checkCode(event,params,tgt)})});return this};$.fn.konami.params={code:[38,38,40,40,37,39,37,39,66,65],step:0};$.fn.konami.checkCode=function(event,params,tgt){if(event.keyCode==params.code[params.step]){params.step++}else{params.step=0}if(params.step==params.code.length){tgt.trigger("konami");params.step=0}}})(jQuery);var firstname=new Array("Vincent","Pierre-Lucas","Miguel","Anthony","RaphaÃ«l","Arnaud","Tanguy","Severin","Evangelina","FranÃ§ois","Olivier","Guillaume","FrÃ©dÃ©ric","SÃ©bastien","Gilles","Rachid","Christophe","Sothear","Les ninjas","Salomon","Francis","Nicolas","Pierre","Antoine","GaÃ«l","Rudy","CÃ©dric","Julien");var dx,xp,yp,am,stx,sty;var i,doc_width=800,doc_height=600;function snow(){for(i=0;i<firstname.length;++i){yp[i]+=sty[i];if(yp[i]>=doc_height-53){xp[i]=Math.random()*(doc_width-am[i]-53);yp[i]=0;stx[i]=.02+Math.random()/10;sty[i]=.7+Math.random();doc_width=$(window).width();doc_height=$(window).height()}dx[i]+=stx[i];$("#credit-"+i).css("top",yp[i]);$("#credit-"+i).css("left",xp[i]+am[i]*Math.sin(dx[i]))}setTimeout("snow()",10)}function credits(){$("html, body").css("overflow","hidden");doc_width=$(window).width();doc_height=$(window).height();dx=new Array;xp=new Array;yp=new Array;am=new Array;stx=new Array;sty=new Array;for(i=0;i<firstname.length;++i){dx[i]=0;xp[i]=Math.random()*(doc_width-53);yp[i]=Math.random()*doc_height;am[i]=Math.random()*20;stx[i]=.02+Math.random()/10;sty[i]=.7+Math.random();$("body").append('<div id="credit-'+i+'" class="credits"><small>'+firstname[i]+"</small></div>");$("#credit-"+i).css("z-index",i+10)}snow()}$(document).ready(function(){setInterval("sendRequest('/index', updateStatus)",500);$(this).konami(function(){credits()})});
