// JavaScript Document
//�ˬd���O�_�ť�

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