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
Insert User Group
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">

<%
   
   String userid = request.getParameter("userid");
   String groupcd = request.getParameter("groupcd");
   String comments = request.getParameter("comments");
   
   String u1 = "insert into DFTUSGP (";
   String u2 = "userid, groupcd, comments";
   String u3 = ") values(";
   String u4 = "'"+userid+"', '"+groupcd+"', '"+comments+"')";
   
   if (userid.trim().equals("") || groupcd.trim().equals(""))
   {
%>
        <h4>column:userid, groupcd</h4>
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
      <h1>Successful Addition of User Group</h1>
      <a href="userlist.jsp">See User list</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
	stmt.close();
    myConn.close();
   }  catch(Exception e) {   
  // else
   //{
%>
      <h1>Sorry, addition has failed.</h1> 
      <a href="userlist.jsp"><%=e.toString()%></a>     
<%
   }
   
%>
</body>
</html>