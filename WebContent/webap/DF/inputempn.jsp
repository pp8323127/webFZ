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
<title>Input Empn</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<form name="form" method="post" action="crewdetail.jsp">
Empno<input type="text" name="empno" size="12">
<input type="submit" name="Submit" value="Submit">
</form>
</body>
</html>
