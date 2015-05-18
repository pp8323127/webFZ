// JavaScript Document
	function preview(formName,actionPage){
		eval("document."+formName+".action='"+actionPage+"'");
		eval("document."+formName+".submit()");
	}