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
