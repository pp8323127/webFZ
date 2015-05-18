<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined
if ((sGetUsr == null) || (session.isNew()) )
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="javascript" src="js/frameset.js" type="text/javascript"></script>
<title>Next 3</title>
<style type="text/css">
<!--
.style1 {font-family: Arial, Helvetica, sans-serif}
-->
</style>
</head>

<body>
<div align="center" class="style1">
  <h3><a href="#" class="txtblue" onClick='javascript:load("next4.jsp","http://tpeweb03.china-airlines.com:9901/webdz/eLearning/eLearningList.jsp?empno=<%=sGetUsr%>")'>NEXT</a>
  </h3>
</div>
</body>
</html>
