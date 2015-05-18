<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,javax.sql.DataSource,javax.naming.*"%>
<%@ page errorPage="error.jsp" %>
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
Delete User
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   String userid = request.getParameter("userid");
   //DataSource
   Context initContext = null;
   DataSource ds = null;
   //DataSource
   Connection myConn = null;
   
try{ 
   initContext = new InitialContext();
   //connect to ORP3 by Datasource
   ds = (javax.sql.DataSource)initContext.lookup("CAL.DFDS01");
   myConn = ds.getConnection();
   Statement stmt = myConn.createStatement();
   int rowsAffected = stmt.executeUpdate("delete from DFTCUSR where userid = '"+userid+"'");
   if (rowsAffected == 1)
   { 
%>
      <h1>Successful Deletion of an User</h1>
      The record has been deleted.
      <br><a href="userlist.jsp">See User list</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, deletion has failed.</h1> 
      <a href="userlist.jsp">Go Back User list</a>   
<%
   }
}
catch (Exception e)
{
	  out.println(e.toString());
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(myConn != null) myConn.close();}catch(SQLException e){}
}
%>
</body>
</html>