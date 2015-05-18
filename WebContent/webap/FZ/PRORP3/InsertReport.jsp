<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>新增座艙長報告</title>
</head>

<body>
<%

String[] cname	= request.getParameterValues("cname");
String[] ename 	= request.getParameterValues("ename");
String[] empno 	= request.getParameterValues("empno");
String[] sern	= request.getParameterValues("sern");
String[] score	= request.getParameterValues("score");

%>
</body>
</html>
