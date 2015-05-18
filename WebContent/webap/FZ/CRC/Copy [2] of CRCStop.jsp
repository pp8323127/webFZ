<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Reporting Check System</title>
<style type="text/css">
<!--
.style7 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 18px; color: #000099; }
-->
</style>
</head>
<body>
<%
String msg = request.getParameter("msg");
if(msg == null) msg = "Welcome to Crew Reporting Check System";
%>
<div align="center">
  <p class="style7"><%=msg%></p>
</div>
</body>
</html>
