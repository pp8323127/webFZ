//submit後的驗證

/*
確認是否刪除的對話視窗
帶參數：表單名稱
*/
function del(formName,checkField){	
	count = 0;
	for (i=0; i<eval("document."+formName+".length"); i++) {
		if (eval("document."+formName+".elements[i].checked")) count++;
	}
//	alert(count);
	if(count ==0 ) {
		alert("Please select delete item\n尚未勾選要刪除的項目!!");
		return false;
	}
	
	else{
	
		if(	confirm("Do you really want to Delete??\n確定要刪除此筆資料？?")){
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
確認輸入empno才能按下Add
\*/
/*
function checkEmpno(){	
	var e  = document.form2.addSern.value;
	if (e == ""){
		alert("請輸入組員序號\nPLease insert crew's serial number");
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
		alert("請輸入組員序號\nPLease insert crew's serial number");
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