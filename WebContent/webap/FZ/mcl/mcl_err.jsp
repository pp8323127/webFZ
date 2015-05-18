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
<link rel="stylesheet" type="text/css" href="crewcar.css">
</head>
<body class = "general" bgcolor="#FFFFFF" text="#000000">
<table width="100%"  border="0">
  <tr>
    <td height="50"><div align="center">
      <h1>Error</h1>
    </div></td>
  </tr>
</table>
<hr>
<p>&nbsp;</p>
<p align="center"><font face="Arial, Helvetica, sans-serif" size="4"><b><%=ms%></b></font></p>
</body>
</html>

