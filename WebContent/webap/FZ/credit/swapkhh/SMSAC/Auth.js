// JavaScript Document
function del(){	//確認是否刪除的對話視窗
	if(	confirm("Do you really want to Delete??\n確定要刪除此筆資料？?")){
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

function checkEmpno(){	//輸入empno才能按下Add
	var e  = document.form2.addEmpno.value;
	if (e == ""){
		alert("請輸入員工號\nPLease insert Employee number");
		document.form2.addEmpno.focus();
		return false;
	}
	else{
		return true;
	}
		

}

//至少需選擇一個
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