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
Insert Page Item
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>

<font face="Comic Sans MS" size="3">Insert Page Item</font>
<form method="post" action="inspageitem.jsp">
    <table border="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">PageId</font></b></td>
        <td> 
          <input name="pageid" type="text" width="10">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">PageName</font></b></td>
        <td> 
          <input name="pagename" type="text" width="40">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Comments</font></b></td>
        <td> 
          <input name="comments" type="text" width="50">
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
