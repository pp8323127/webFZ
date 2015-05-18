<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="swap3ackhh.*,fz.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
} 
//write log

fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ284K");



//variables
String[] formno = request.getParameterValues("formno");
String[] confirmStatus = request.getParameterValues("cf");
String[] comments = request.getParameterValues("comm");
String[] textComm =request.getParameterValues("addcomm");
String[] aempno = request.getParameterValues("aempno");
String[] rempno = request.getParameterValues("rempno");
String  message = "";
swap3ackhh.SwapFormConfirm sfc = new swap3ackhh.SwapFormConfirm();
try {
		sfc.UpdateConfirm(formno, confirmStatus, textComm, comments, sGetUsr);		

} catch (Exception e) {	
}



%>
<html>
<head>
<title>Send Crew Duty</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../style/menu.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="../style/errStyle.css" type="text/css">

</head>
<body>
<div class="errStyle1">
<%
	if (!sfc.isUpdSuccess()) {
		out.print("��s�ӽг���~�G<br>"+sfc.getErrorMessage()+"<br>");
	} else {
		out.print("�ӽг�B�z����!!<br>");
	//�H�eEMAIL
		
		
		
		
		mailSwapForm ms = new mailSwapForm();	//�ﴫ��192.168.2.4 Server
		ms.sendSwapFormMail(formno, aempno, rempno, confirmStatus, comments,textComm);
/*		message = ms.sendForm(formno, aempno, rempno, confirmStatus, comments,textComm);
		if("0".equals(message)){
			out.print("�w�N�T���o�ܥ����H�c");
		}else{
			out.print("�ӽг�B�z����!!<br>�H��H�e�ɲ��Ϳ��~.<br>");
		}
*/
		if(ms.isMailStatus()){
			out.print("�w�N�T���o�ܥ����H�c<br>");
		}else{
			out.print("�H��H�e�ɲ��Ϳ��~.<br>"+ms.getErrMsg());
		}
		
		
		
	}

%>
</div>
</body>
</html>