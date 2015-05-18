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
<html>
<head>
<title>
User Detail
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>
  <p><font face="Comic Sans MS" color="#333333">User Detail</font></p>

<%
   String userid = request.getParameter("userid");
     
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   ResultSet myResultSet = stmt.executeQuery("select * from DFTCUSR where userid = '" + userid + "'");
   if (myResultSet != null)
   {
   		while (myResultSet.next())
		{
   			String password = myResultSet.getString("password");
			String username = myResultSet.getString("username");
%>
  <form method="post" action="updusr.jsp">
    <table border="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">UserId</font></b></td>
        <td><%= userid %> 
          <input type="hidden" name="userid" value="<%= userid %>">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Password</font></b></td>
        <td><input type="text" name="password" value="<%= password %>">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">UserName</font></b></td>
        <td><input name="username" type="text" width="10" value="<%= username %>">
        </td>
      </tr>
      <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> 
            <input type="submit" value="Update Change" >
            </font> 
          </center>
        </td>
      </tr> 
	  <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> <a href="delusr.jsp?userid=<%=userid%>">Delete 
            Record </a> </font> 
          </center>
        </td>
      </tr> 
    </table>
</form>
<%        
    	}  
   }
   stmt.close();
   myConn.close();
%>
</center>
</body>
</html>