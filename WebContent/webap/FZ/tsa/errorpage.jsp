<%@page contentType="text/html; charset=big5" language="java"%>
<%@ page import="fz.*" %>

<%
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader ("Expires", 0);
	
	String ms = request.getParameter("messagestring");
%>
<html>
<head>
<title>Error Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>

<body bgcolor="#FFFFFF" text="#000000">

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center"><font face="Arial, Helvetica, sans-serif" size="3"><b><%=ms%></b></font></p>
<p align="center"><font face="Arial, Helvetica, sans-serif" size="3"><a href="sendredirect.jsp"><font size="2"><b>Back 
  Login</b></font></a></font></p>
</body>
</html>
