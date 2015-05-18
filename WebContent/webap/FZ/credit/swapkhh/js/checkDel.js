/*
確認是否刪除的對話視窗
帶參數：表單名稱
*/
function checkDel(formName){	
	count = 0;
	for (i=0; i<eval("document."+formName+".length"); i++) {
		if (eval("document."+formName+".elements[i].checked")) count++;
	}
	if(count ==0 ) {
		alert("Please select delete item\n尚未勾選要刪除的項目!!");
		return false;
	}
	
	else{
	
		if(	confirm("Do you really want to Delete??\n確定要刪除此筆資料？?")){
				eval("document."+formName+".submit()");
				return true;
			}
		else{
				return false;
			}
	}
}
