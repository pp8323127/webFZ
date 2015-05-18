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
Update nobus screen
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   
   String empno = request.getParameter("empno");
   String sern = request.getParameter("sern");
   String banknont = request.getParameter("banknont");
   String traf = request.getParameter("traf");
   
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   int rowsAffected = stmt.executeUpdate("update dftcrew set chgtime = sysdate, chgid = '"+sGetUsr+"', box = '"+sern+"', banknont = '"+banknont+"', traf = UPPER('"+traf+"') where empno = '"+empno+"'");
   if (rowsAffected == 1)
   {
%>
      <h1>Successful Modification of Page Authorize</h1>
      <a href="nobusedit.jsp?empno=<%=empno%>">See Crew list</a><br>
	  <a href="ea001.jsp">Edit Next Crew</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, modification has failed.</h1> 
      <a href="nobusedit.jsp?empno=<%=empno%>">Go back to Page list</a>     
<%
   }
   stmt.close();
   myConn.close();
%>
</body>
</html>
