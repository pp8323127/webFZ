// ����form��action page
/**
*	�ݱa�ѼơG���W�١B���ܴ���action page
*   �ϥνd��: <input type="button" onClick="preview('form1','ChangeToActionPage.jsp')">
*/
	function newAction(formName,actionPage){
		eval("document."+formName+".action=\""+actionPage+"\"");
		eval("document."+formName+".submit()");
	}