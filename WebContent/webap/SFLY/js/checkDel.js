//submit�᪺����

/*
�T�{�O�_�R������ܵ���
�a�ѼơG���W��
*/
function del(formName){	
	if(	confirm("Do you really want to Delete??\n�T�w�n�R��������ơH?")){
			//document.form1.action = "delfri.jsp";
			eval("document."+formName+".submit()");
			return true;
		}
	else{
			//location.reload();
			eval("document."+formName+".reset()");
			return false;
		}

}

function delItem(formName){	
	count = 0;
	for (i=0; i<eval("document."+formName+".length"); i++) {
		if (eval("document."+formName+".elements[i].checked")) count++;
	}
//	alert(count);
	if(count ==0 ) {
		alert("Please select delete item\n�|���Ŀ�n�R��������!!");
		return false;
	}
	
	else{}
}

/*
�T�{�O�_�R������ܵ���
�a�ѼơG���W��
*/
function checkDel(formName){	
	count = 0;
	for (i=0; i<eval("document."+formName+".length"); i++) {
		if (eval("document."+formName+".elements[i].checked")) count++;
	}
	if(count ==0 ) {
		alert("Please select delete item\n�|���Ŀ�n�R��������!!");
		return false;
	}
	
	else{
	
		if(	confirm("Do you really want to Delete??\n�T�w�n�R��������ơH?")){
				eval("document."+formName+".submit()");
				return true;
			}
		else{
				return false;
			}
	}
}

