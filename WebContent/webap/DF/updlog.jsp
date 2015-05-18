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
<title>Check Authorized</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>
<body background="clearday.jpg">
<center>
<%
String linkpage = request.getParameter("linkpage");
String sysname = request.getParameter("sysname");
String userid = (String)session.getValue("MM_Username");
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();

Class.forName(MM_cnORP3DF_DRIVER);
Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
Statement stmt = myConn.createStatement();
//不寫入log 記錄 2004/11/10
//int rowsAffected = stmt.executeUpdate("insert into DFTCLOG (login_time, userid, userip, userhost, sysname, status) values (sysdate, '" + userid + "', '" + userip + "', '" + userhost + "', '" + sysname + "', 'Pass')");
int rowsAffected = 1;
if (rowsAffected == 1)
{
     stmt.close();
     myConn.close();
     %><jsp:forward page="<%= linkpage %>" /><%
}
else
{
     out.println("Login System Fail !!");
}

stmt.close();
myConn.close();
%>
</center>
</body>
</html>