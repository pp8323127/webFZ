// JavaScript Document
//檢查欄位是否空白

function checkBlank(formName,colName,msg){
	var colValue = eval("document."+formName+"."+colName+".value");
	 if(colValue ==""){
	 	alert(msg);
		eval("document."+formName+"."+colName+".focus()");
		return false;
	 }
	 else{
	 	return true;
	 }
}