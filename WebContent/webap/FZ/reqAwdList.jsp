<%@ page contentType="text/html; charset=big5" language="java" import="df.log.*"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>mail Award List</title>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body>

<%
String userid = (String) session.getAttribute("userid") ;
if(userid == null){
	response.sendRedirect("sendredirect.jsp");
}else{
	String year = request.getParameter("year");
	String month =request.getParameter("month");

	AwardList awd = new AwardList(year, month, userid);
	
	//�g�Jlog txt��
	awd.setLogFile(application.getRealPath("/")+"/Log/reqAwdLog.txt");
	awd.selectData();
	if(	! awd.isHasData()){
%>
<p align="center" class="txtblue" >����L���!!</p>
<%	
	}else{
		awd.SendLogList(application.getRealPath("/"));		

	//�g�Jlog table		
		fz.writeLog wl = new fz.writeLog();
		wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ345");

			
%>
<p align="center" class="txtblue" >�H�e���\!!<br>
�Ц�<a href="http://mail.cal.aero" target="_blank">�����H�c</a>�����H��.</p>
<%		
	}
%>

 <p align="center" class="txtblue" > <a href="reqAwdListQuery.jsp" target="topFrame" ><span class="txtxred"><u>�H�e��L���</u></span></a> </p>

<%	
}
%>

</body>
</html>
