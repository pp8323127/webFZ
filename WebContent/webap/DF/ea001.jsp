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
<title>ea001</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center"><font face="Comic Sans MS" color="#0066FF">Please Input EmpNo</font></p>
<form name="form1" method="post" action="nobusedit.jsp">
  <div align="center">
    <p>
      <input type="text" name="empno">
    </p>
    <p>
      <input type="submit" name="Submit" value="Submit">
    </p>
  </div>
</form>
<p align="center">&nbsp;</p>
</body>
</html>
