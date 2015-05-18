//submit後的驗證

/*
確認是否刪除的對話視窗
帶參數：表單名稱
*/
function del(formName){	
	if(	confirm("This item's subitem will be deleted in the  meanwhile!!\nDo you really want to Delete??\n刪除此筆資料會同時刪除其子項目!!\n確定要刪除？?")){
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
確認是否刪除的對話視窗
帶參數：表單名稱
*/
function checkFItemDel(formName){	
	count = 0;
	for (i=0; i<eval("document."+formName+".length"); i++) {
		if (eval("document."+formName+".elements[i].checked")) count++;
	}
	if(count ==0 ) {
		alert("Please select delete item\n尚未勾選要刪除的項目!!");
		return false;
	}
	
	else{
	
		if(	confirm("This item's subitem will be deleted in the  meanwhile!!\nDo you really want to Delete??\n刪除此筆資料會同時刪除其子項目!!\n確定要刪除？?")){
				eval("document."+formName+".submit()");
				return true;
			}
		else{
				return false;
			}
	}
}

