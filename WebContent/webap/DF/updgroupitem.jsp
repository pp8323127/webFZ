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
<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="java.sql.Date"%>
<%@ page errorPage="error.jsp" %>
<%@ include file="../Connections/cnORP3DF.jsp" %>
<html>
<head>
<title>
Update Group Item screen
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   
   String groupcd = request.getParameter("groupcd");
   String groupname = request.getParameter("groupname");
   String comments = request.getParameter("comments");
   
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   int rowsAffected = stmt.executeUpdate("update DFTGRPI set groupname = '"+groupname+"', comments = '"+comments+"' where groupcd = '"+groupcd+"'");
   if (rowsAffected == 1)
   {
%>
      <h1>Successful Modification of Group Item</h1>
      <a href="userlist.jsp">See User list</a><br>
	  <a href="pagelist.jsp">See Page list</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, modification has failed.</h1> 
      <a href="userlist.jsp">Go back to User list</a>
	  <a href="pagelist.jsp">Go back to Page list</a>     
<%
   }
   stmt.close();
   myConn.close();
%>
</body>
</html>
