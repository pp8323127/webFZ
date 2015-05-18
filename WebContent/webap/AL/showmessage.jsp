<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="al.*,java.sql.*"%>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("login.jsp");
} 

String message1 = request.getParameter("message1");
String message2 = request.getParameter("message2");
String gdyear = request.getParameter("gdyear");
String empn = request.getParameter("empn");
%>
<html>
<head>
<title>Show Message</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>

<body bgcolor="#FFFFFF" text="#000000">

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<div align="center"><font face="Comic Sans MS" size="3" color="#FF0000"><%=message1%></font><font face="Comic Sans MS" size="3" color="#000099"></font><br>
<font face="Comic Sans MS" size="3" color="#000099"><%=message2%></font><br>
<A HREF='javascript:history.go(-1);'><font face="Arial, Helvetica, sans-serif" size="2">Back 
  to previous (ReEnter)</font></A><br><font face="Arial, Helvetica, sans-serif" size="2" color="#000066"><a href="viewoffsheet.jsp?offyear=<%=gdyear%>&empn=<%=empn%>">view 
  offsheet</a></font>
<br>
  <font face="Arial, Helvetica, sans-serif"><font size="3" color="#000066"> <a href="sendredirect.jsp"><font size="2"><b>logout</b></font></a></font></font> 
</div>
</body>
</html>
