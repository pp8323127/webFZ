//submit�᪺����

/*
�T�{�O�_�R������ܵ���
�a�ѼơG���W��
*/
function del(formName){	
	if(	confirm("This item's subitem will be deleted in the  meanwhile!!\nDo you really want to Delete??\n�R��������Ʒ|�P�ɧR����l����!!\n�T�w�n�R���H?")){
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

/*
�T�{�O�_�R������ܵ���
�a�ѼơG���W��
*/
function checkFItemDel(formName){	
	count = 0;
	for (i=0; i<eval("document."+formName+".length"); i++) {
		if (eval("document."+formName+".elements[i].checked")) count++;
	}
	if(count ==0 ) {
		alert("Please select delete item\n�|���Ŀ�n�R��������!!");
		return false;
	}
	
	else{
	
		if(	confirm("This item's subitem will be deleted in the  meanwhile!!\nDo you really want to Delete??\n�R��������Ʒ|�P�ɧR����l����!!\n�T�w�n�R���H?")){
				eval("document."+formName+".submit()");
				return true;
			}
		else{
				return false;
			}
	}
}

