// JavaScript Document
function del(){	//�T�{�O�_�R������ܵ���
	if(	confirm("Do you really want to Delete??\n�T�w�n�R��������ơH?")){
			//document.form1.action = "delfri.jsp";
			document.form1.submit();
			return true;
		}
	else{
			//location.reload();
			document.form1.reset();
			return false;
		}

}

function checkEmpno(){	//��Jempno�~����UAdd
	var e  = document.form2.addEmpno.value;
	if (e == ""){
		alert("�п�J���u��\nPLease insert Employee number");
		document.form2.addEmpno.focus();
		return false;
	}
	else{
		return true;
	}
		

}

//�ܤֻݿ�ܤ@��
function checkSelect(formName,checkBoxName){
	var cb = eval("document."+formName+"."+checkBoxName);
	var xCount = 0;

	for(var i=0;i<cb.length;i++){
		if(cb[i].checked){
			xCount ++;
		}
	}
	if(xCount == 0){
		alert("Please select one");
		return false;
	}else{
		return true;
	}		
}