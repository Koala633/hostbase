
var popupDisplayed = false;

var lesSelect = null;
var lesIframes = null;

var headCornerWidth = 20;
var footCornerWidth = 20;


var saveKeyDown = null;

function kb_block(){
	saveKeyDown = document.onkeydown;
	document.onkeydown = block;
}

function kb_unblock(){
	document.onkeydown = saveKeyDown;
}

var block = function(event){
	return false;
}


/*
function that creates the LBPopup at page loading
The LBPopup is hidden when not used but exists
*/

function createLBPopup() {
	if (document.getElementById('modal') == null) {	
		/* Modal frame and popup global frame */
		document.writeln('<div id="modal"><div id="popup">');

		/* popup header */
		document.writeln('<div id="popupHead">');
			document.writeln('<div class="popupTL"></div>');
				document.writeln('<div id="popupHeadContent" class="popupHeadContent">');
				document.writeln('<span id="popupHeadMsg">Attention</span>');
				document.writeln('</div>');
			document.writeln('<div class="popupTR"></div>');
		document.writeln('</div>');

			
		document.writeln('<div id="popupBody">');
			document.writeln('<div class="popupBodyL"></div>');
			document.writeln('<div class="popupBodyR"></div>');
			document.writeln('<div id="popupMsg"></div>');
			document.writeln('<div id="popupCslArea">');
				document.writeln('<div class="LBButton" id="LBBBG1" onmouseup="PopupButtonUp(this)" onmousedown="PopupButtonDown(this)" onmouseover="PopupButtonOver(this)" onmouseout="PopupButtonOut(this)">Non</div>');
			document.writeln('</div>')

			document.writeln('<div id="popupOKArea">');
				document.writeln('<div class="LBButton" id="LBBBG2" onmouseup="PopupButtonUp(this)" onmousedown="PopupButtonDown(this)" onmouseover="PopupButtonOver(this)" onmouseout="PopupButtonOut(this)">Oui</div>');
			document.writeln('</div>');
		document.writeln('</div>');

		document.writeln('<div id="popupFoot">');
			document.writeln('<div class="popupBL"></div>');
			document.writeln('<div id="popupFootContent" class="popupFootContent"></div>');
			document.writeln('<div class="popupBR"></div>');
		document.writeln('</div>');

		document.writeln('</div></div>');
	}
}





/*
function that display the LBPopup
the principle is to put it on the foreground and to specify:
    - a width and a height
    - several strings for the messages
    - the functions that will be called when pressing the buttons
    - the container in which the popup will appear (The modal div will fit to the width and height of the container)
    This function hides the select elements du correct an IE bug
*/

function LB_popup(LBPmaster,
					title,
					width, height,
					msg,
					okFct,
					cslFct,
					yesText, noText) {


	leModal = document.getElementById('modal');

	if (leModal) {
	    popupDisplayed = true;

		/* blocking keyboard events */
		kb_block();

		/* displaying the popup */
        lePopup = document.getElementById('popup');
        lePopupHead = document.getElementById('popupHead');
        lePopupHeadContent = document.getElementById('popupHeadContent');
        lePopupBody = document.getElementById('popupBody');
        lePopupFoot = document.getElementById('popupFoot');
        lePopupFootContent = document.getElementById('popupFootContent');
        headMsg = document.getElementById('popupHeadMsg');
        lePopupMsg = document.getElementById('popupMsg');
	
		yesMsg = document.getElementById('LBBBG2');
		noMsg  = document.getElementById('LBBBG1');

 	 	Drag.init(lePopupHead, lePopup, 0, LBPmaster.offsetWidth-width, 0, LBPmaster.offsetHeight-height);

        /* Setting the prefered size for the elements */
        leModal.style.display='block';
        leModal.style.width = LBPmaster.offsetWidth+'px';
        leModal.style.height = LBPmaster.offsetHeight+'px';

        lePopup.style.width = width+'px';
        lePopup.style.height = height+'px';

        lePopupBody.style.height = (height-(lePopupHead.offsetHeight + lePopupFoot.offsetHeight))+'px';

        lePopupMsg.style.height = (height-(lePopupHead.offsetHeight + lePopupFoot.offsetHeight))+'px';

        lePopupHeadContent.style.width = (width-headCorn