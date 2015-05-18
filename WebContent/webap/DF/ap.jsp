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
<title>AP</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<div align="center"> 
  <p align="left"><font face="Comic Sans MS" size="3" color="#006633">Application 
    Program</font></p>
</div>
<ul>
  <li> 
    <div align="left"><font face="Comic Sans MS" color="#6666FF"><a href="updlog.jsp?linkpage=selectpage.jsp&sysname=Crew Record Report System"><font face="Arial, Helvetica, sans-serif">Crew 
      Record Report System</font></a></font></div>
  </li>
  <li><font face="Arial, Helvetica, sans-serif" color="#6666FF"><a href="updlog.jsp?linkpage=df001.jsp&sysname=Crew Payroll for flight">Crew 
    Payroll for flight</a></font></li>
  <!--<li><font face="Arial, Helvetica, sans-serif" color="#6666FF"><a href="frame3.jsp">FlightCrew Blk Time Report</a></font></li>
  <li><font face="Arial, Helvetica, sans-serif" color="#6666FF"><a href="ckauthorized.jsp?linkpage=ea001.jsp&pageid=ea001">Crew 
    &amp; FlightCrew Nobus &amp; BankNo-NT Edit</a></font></li>
  <li><font face="Arial, Helvetica, sans-serif" color="#6666FF"><a href="sendmail.htm">Java 
    Mail test</a></font></li>
  <li><font face="Arial, Helvetica, sans-serif" color="#6666FF"><a href="loginscreen.jsp">Auth 
    test</a></font></li>-->
</ul>
<div align="center"> 
  <p align="left">&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p align="left"><font face="Comic Sans MS" size="3" color="#CC0033">System Administrator 
    Management</font></p>
</div>
<ul>
  <li><font face="Arial, Helvetica, sans-serif" color="#6666FF"><a href="ckauthorized.jsp?linkpage=userlist.jsp&pageid=p0004">User 
    Management</a></font></li>
  <li><font face="Arial, Helvetica, sans-serif" color="#6666FF"><a href="ckauthorized.jsp?linkpage=pagelist.jsp&pageid=p0005">Page 
    Management</a></font></li>
</ul>
<div align="center">
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
</div>
</body>
</html>
