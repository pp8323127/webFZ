// JavaScript Document
function checkDel(formName,checkField){	
	count = 0;
	for (i=0; i<eval("document."+formName+".length"); i++) {
		if (eval("document."+formName+".elements[i].checked")) count++;
	}
	if(count ==0 ) {
		alert("Please select item\n請勾選所需的項目!!");
		return false;
	}
	
	else{
		return true;
	}
}