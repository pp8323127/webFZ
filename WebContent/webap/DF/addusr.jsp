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
<title>
Insert User
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>

<font face="Comic Sans MS" size="3">Insert User</font>
<form method="post" action="insusr.jsp">
    <table border="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">UserId</font></b></td>
        <td> 
          <input name="userid" type="text" width="10">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Password</font></b></td>
        <td> 
          <input name="password" type="text" width="10">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">UserName</font></b></td>
        <td> 
          <input name="username" type="text" width="10">
        </td>
      </tr>
      <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> 
            <input type="submit" value="Update Insert">
            </font> 
          </center>
      </tr>
    </table>
</form>

</center>
</body>
</html>
