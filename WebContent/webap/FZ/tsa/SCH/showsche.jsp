<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*, sch.MonthlySch" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
/*String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("../sendredirect.jsp");
} */
%>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Monthly Schedule</title>
<link href="../../menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<%
String yy = request.getParameter("yy");
String mm = request.getParameter("mm");
String fleet = request.getParameter("fleet");
String rank = request.getParameter("rank");
String filename = yy + mm + fleet + rank;
//out.println(yy + "," + mm + "," + fleet + "," + rank);

MonthlySch ms = new MonthlySch();
String rs = ms.schFile(yy+mm, fleet, rank);
if("0".equals(rs)){
%>
  <p class="txttitletop">�ɮפU��/Download File</p>
  <p><a href="../../sample6.jsp?filename=<%=filename%>.csv"><img src="../../images/floder2.gif" width="31" height="27" border="0"><%=filename%> download</a></p>
<%
}
else{
%>
  <p class="txttitletop">�ɮ׻s�@���� : <%=rs%></p>
<%
}
%>
</div>
</body>
</html>