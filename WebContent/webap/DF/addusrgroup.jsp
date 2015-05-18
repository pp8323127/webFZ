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
<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%@ include file="../Connections/cnORP3DF.jsp" %>
<%
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   ResultSet myResultSet = stmt.executeQuery("select * from DFTGRPI order by groupcd");
%>
<html>
<head>
<title>
Insert User Group
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>

<font face="Comic Sans MS" size="3">Insert User Group</font>
<form method="post" action="insusrgroup.jsp">
    <table border="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">UserId</font></b></td>
        <td> 
          <input name="userid" type="text" width="10">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">GroupCd</font></b></td>
        <td> 
        <select name="groupcd" size="1">
        <%
        if (myResultSet != null)
        {
   		while (myResultSet.next())
		{
   			String groupcd = myResultSet.getString("groupcd");
	%>				
                            <option value="<%= groupcd %>"><%= groupcd %></option>
                           
	<%	}
        }
        %>
        </select>
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
<%        
stmt.close();
myConn.close();
%>
