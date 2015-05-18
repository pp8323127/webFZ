
/*disabled Button*/
function disabledButton(itemID){
	if(document.getElementById(itemID) != null){
		document.getElementById(itemID).disabled=1;
	}
}

/* enabled Button*/
function enableButton(itemID){
	if(document.getElementById(itemID) != null){
		document.getElementById(itemID).disabled=0;
	}
}
