//submit�᪺����

/*
�T�{�O�_�R������ܵ���
�a�ѼơG���W��
*/
function del(formName,checkField){	
	count = 0;
	for (i=0; i<eval("document."+formName+".length"); i++) {
		if (eval("document."+formName+".elements[i].checked")) count++;
	}
//	alert(count);
	if(count ==0 ) {
		alert("Please select delete item\n�|���Ŀ�n�R��������!!");
		return false;
	}
	
	else{
	
		if(	confirm("Do you really want to Delete??\n�T�w�n�R��������ơH?")){
				//document.form1.action = "delfri.jsp";
				//eval("document."+formName+".submit()");
				return true;
			}
		else{
				//location.reload();
				//eval("document."+formName+".reset()");
				return false;
			}
	}
}

/*
�T�{��Jempno�~����UAdd
\*/
/*
function checkEmpno(){	
	var e  = document.form2.addSern.value;
	if (e == ""){
		alert("�п�J�խ��Ǹ�\nPLease insert crew's serial number");
		document.form2.addSern.focus();
		return false;
	}
	else{
		return true;
	}
		

}
*/
function checkAdd(formName,addField,TrueGoTo){

	var e  = eval("document."+formName+"."+addField+".value");
	if (e == ""){
		alert("�п�J�խ��Ǹ�\nPLease insert crew's serial number");
		eval("document."+formName+"."+addField+".focus()");
		return false;
	}
	else{
		eval("preview('"+formName+"','"+TrueGoTo+"')");

	}

}

function preview(formName,actionPage){
		eval("document."+formName+".action='"+actionPage+"'");
		eval("document."+formName+".submit()");
}