<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew()) 
{		//check user session start first
  %> <jsp:forward page="login.jsp" /> <%
} 
if (sGetUsr == null) 
{		//check if not login
  %> <jsp:forward page="login.jsp" /> <%
} 
%>
<html>
<head>
<title>DF001</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<ul>
  <li><font face="Arial, Helvetica, sans-serif">Flypay Main</font></li>
  <li><font face="Arial, Helvetica, sans-serif"><a href="ckauthorized.jsp?pageid=dffp030&linkpage=fptax.jsp">Flypay Taxable</a></font></li>
  <li><font face="Arial, Helvetica, sans-serif" color="#000099"><a href="ckauthorized.jsp?pageid=df010&linkpage=dfcrewquery.jsp">Edit 
    Payroll Crew for OS</a></font></li>
  <li><font face="Arial, Helvetica, sans-serif" color="#000099"><a href="ckauthorized.jsp?pageid=df011&linkpage=df011.jsp">Edit 
    Payroll Crew for Account - Staff</a></font></li>
  <li><font face="Arial, Helvetica, sans-serif" color="#000099"><a href="ckauthorized.jsp?pageid=df012&linkpage=df012.jsp">Edit 
    Rate Table </a></font></li>
</ul>
</body>
</html>
