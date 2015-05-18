<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>
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
Delete Crew Information Processing
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   String staff_num = request.getParameter("staff_num");
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   int rowsAffected = stmt.executeUpdate("delete from crew_t where staff_num = " + staff_num);
   if (rowsAffected == 1)
   { 
%>
      <h1>Successful Deletion of an Crew Information</h1>
      The record has been deleted.
      <br><a href="crewlist.jsp">See Crew List</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, deletion has failed.</h1> 
      <a href="crewlist.jsp%>">See Crew List</a>   
<%
   }
   stmt.close();
   myConn.close();
%>
</body>
</html>