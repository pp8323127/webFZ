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
Insert Crew Page Authorize
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   
   String pageid = request.getParameter("pageid");
   String groupcd = request.getParameter("groupcd");
   String auth = request.getParameter("auth");
   String comments = request.getParameter("comments");
   
   String u1 = "insert into DFTPAGE (";
   String u2 = "pageid, groupcd, auth, comments";
   String u3 = ") values(";
   String u4 = "'"+pageid+"', '"+groupcd+"', '"+auth+"', '"+comments+"')";
   
   if (pageid.trim().equals("") || groupcd.trim().equals("") || auth.trim().equals(""))
   {
%>
        <h4>column:pageid, groupcd, auth</h4>
        <br>These columns are not NULL value, please check your data!!
<%
        return;
   }
   String aa = u1 + u2 + u3 + u4;
try{ 
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();

   int rowsAffected = stmt.executeUpdate(aa);
   //if (rowsAffected == 1)
   //{
%>
      <h1>Successful Addition of Page Authorize</h1>
      <a href="pagelist.jsp">See Page list</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
	stmt.close();
   myConn.close();
   }    
   //else
   catch(Exception e) {
   //{
%>
      <h1>Sorry, addition has failed.</h1> 
      <a href="pagelist.jsp"><%=e.toString()%></a>     
<%
   }
   //stmt.close();
   //myConn.close();
%>
</body>
</html>