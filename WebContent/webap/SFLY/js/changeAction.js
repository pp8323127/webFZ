// 改變form的action page
/**
*	需帶參數：表單名稱、欲變換的action page
*   使用範例: <input type="button" onClick="preview('form1','ChangeToActionPage.jsp')">
*/
	function newAction(formName,actionPage){
		eval("document."+formName+".action=\""+actionPage+"\"");
		eval("document."+formName+".submit()");
	}