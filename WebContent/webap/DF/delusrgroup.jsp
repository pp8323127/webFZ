<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%@ page errorPage="error.jsp" %>
<%@ include file="../Connections/cnORP3DF.jsp" %>
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
Delete User Group
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   String userid = request.getParameter("userid");
   String groupcd = request.getParameter("groupcd");
   
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD); 
   Statement stmt = myConn.createStatement();
   int rowsAffected = stmt.executeUpdate("delete from DFTUSGP where userid = '"+userid+"' and groupcd = '"+groupcd+"'");
   if (rowsAffected == 1)
   { 
%>
      <h1>Successful Deletion of an User Group</h1>
      The record has been deleted.
      <br><a href="userlist.jsp">See User list</a><br>
	  <a href="pagelist.jsp">See Page list</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, deletion has failed.</h1> 
      <a href="userlist.jsp">Go Back User list</a><br>  
	  <a href="pagelist.jsp">Go Back Page list</a> 
<%
   }
   stmt.close();
   myConn.close();
%>
</body>
</html>