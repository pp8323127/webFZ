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
Update Page Item screen
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   
   String pageid = request.getParameter("pageid");
   String pagename = request.getParameter("pagename");
   String comments = request.getParameter("comments");
   
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD); 
   Statement stmt = myConn.createStatement();
   int rowsAffected = stmt.executeUpdate("update DFTPAGI set pagename = '"+pagename+"', comments = '"+comments+"' where pageid = '"+pageid+"'");
   if (rowsAffected == 1)
   {
%>
      <h1>Successful Modification of Page Item</h1>
      <a href="pagelist.jsp">See Page list</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, modification has failed.</h1> 
      <a href="pagelist.jsp">Go back to Page list</a>     
<%
   }
   stmt.close();
   myConn.close();
%>
</body>
</html>
