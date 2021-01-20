var buttState = new Array();

js_mbv_ConfirmActions = 0;
showWarningPopup = 0;

imgexpand = new Image();
imgexpand.src = '/images/menu/expand.png';

imgcollapse = new Image();
imgcollapse.src = '/images/menu/collapse.png';

imgarrowrightwhite = new Image();
imgarrowrightwhite.src = '/images/menu/arrowrightwhite.png';

imgarrowrightorange = new Image();
imgarrowrightorange.src = '/images/menu/arrowrightorange.png';


function OpenHelp(help, sessionid)
{
    var x = 590;
    var y = 650;

	var px = screen.width - x - 10;
	var py = (screen.height - y) / 2;

    if (document.all || document.getElementById)
        options = "scrollbars=yes, resizable=yes, width="+x+", height="+y+", left="+px+", top="+py;
    if (document.layers)
        options = 'scrollbars=yes,resizable=yes,outerWidth='+x+',outerHeight='+y+',screenX='+px+',screenY='+py;

    window.open('index.cgi?page=help&help=' + help + '&sessionid=' + sessionid, 'HelpEmbedded', options);
}


function ButtonGoPage(buttName, url)
{
	if (buttState[buttName] == 0)
		return;

	GoPage(url);
}


function GoPage(url)
{
	if ((js_mbv_ConfirmActions==1) && (showWarningPopup) && (document.getElementById('modal') != null) && (window.parent.LB_popup)) {
		popupContent1 = "<span style='font-weight: bold; font-family: verdana, arial, sans-serif; font-size: 12px;'>";
		popupContent1 += js_esp_ConfirmDialogText;
		popupContent1 += "</span>"; 

		window.parent.LB_popup(window.parent.document.getElementById ("GUI_master"),
				js_esp_ConfirmDialogTitle,
				300, 200,
				popupContent1,
				function() { GoPageConfirm(url); },
				function() { GoPageUnConfirm(url); },
				js_esp_ConfirmDialogYes,js_esp_ConfirmDialogNo);
	}
	else 
		GoPageConfirm(url);
}


function ButtonGoPageConfirm(buttName, url)
{
	if (buttState[buttName] == 0)
		return;

	GoPageConfirm(url);
}


function GoPageConfirm(url)
{
	document.location.href = url;
}

function GoPageUnConfirm(url)
{
	if (window.parent.LB_popup) {
		window.parent.LB_hidePopup();
	}

	FTDialogDisplayed=false;
	doingAConfirmedCancel = false;
	confirmedOK = false;
}

function ShowObject(liste)
{
	var i;
	var obj;

	for (i=0; i<liste.length; i++) {
		obj = document.getElementById(liste[i]);

		obj.style.display = '';
	}
}

function HideObject(liste)
{
	var i;
	var obj;

	for (i=0; i<liste.length; i++) {
		obj = document.getElementById(liste[i]);

		obj.style.display = 'none';
	}
}

function DisplayMenu(menuID)
{
	var i;
	var divobj;
	var imgobj;

	for (i = 1; i <= 3; i++) {
		divobj = document.getElementById('submenu' + i);

		if (!divobj)
			continue;

		imgobj = eval('document.imgmenu' + i);

		if (!imgobj)
			continue;

		if (i == menuID) {
			if (divobj.style.display == 'block') {
				divobj.style.display = 'none';
				imgobj.src = imgexpand.src;
			}
			else {
				divobj.style.display = 'block';
				imgobj.src = imgcollapse.src;
			}
		}
		else {
			divobj.style.display = 'none';
			imgobj.src = imgexpand.src;
		}
	}
}

function MouseOnArrow(row, imgName, cellName) {
	var obj;

	obj = eval('document.' + imgName);

	row.style.background = '#FF6600';
	obj.src = imgarrowrightwhite.src;

	obj = document.getElementById(cellName);

	obj.style.color = '#FFFFFF';
	obj.style.fontWeight = 'bold';
}

function MouseOutArrow(row, imgName, cellName) {
	var obj;

	obj = eval('document.' + imgName);

	row.style.background = '#FFFFFF';
	obj.src = imgarrowrightorange.src;

	obj = document.getElementById(cellName);

	obj.style.color = '#000000';
	obj.style.fontWeight = 'normal';
}


function ButtonOver(type, buttName) {
	var linkobj;

	if (buttState[buttName] == 0)
		return;

	linkobj = document.getElementById('link' + buttName);

	linkobj.style.color = '#FF6600';
}

function ButtonOut(type, buttName) {
	var linkobj;

	if (buttState[buttName] == 0)
		return;

	ButtonUp(type, buttName);

	linkobj = document.getElementById('link' + buttName);

	linkobj.style.color = '#000000';
}

function ButtonDown(type, buttName) {
	var rowobj;
	var imgobj;
	var linkobj;

	if (buttState[buttName] == 0)
		return;
	
	rowobj = document.getElementById('row' + buttName);
	imgobj = docum