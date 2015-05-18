<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*" %>

<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined
if (sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 
%>

<html>
<head>
<title>Crew Reporting Check System</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>

<frameset cols="200,*" frameborder="NO" border="0" framespacing="0">
  <frame name="leftFrame" scrolling="NO" noresize src="CRCSleft.jsp">
  <frameset rows="80,*" frameborder="NO" border="0" framespacing="0">
  <frame name="topFrame" scrolling="NO"  noresize src="CRCStop.jsp" >
  <frame name="mainFrame" scrolling="YES" src="blank.htm">
  </frameset>
</frameset>

<noframes> 
<body bgcolor="#FFFFFF" text="#000000">
</body>
</noframes> 
</html>
