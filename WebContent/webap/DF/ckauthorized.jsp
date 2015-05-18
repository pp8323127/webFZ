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
String pageid = request.getParameter("pageid");
String linkpage = request.getParameter("linkpage");
String userid = (String)session.getValue("MM_Username");

String mysql = "select sum(auth) c_auth, count(*) c_row from DFTPAGE where pageid = '" + 
pageid + "' and groupcd in (select groupcd from DFTUSGP where userid = '" + 
userid + "')";

Class.forName(MM_cnORP3DF_DRIVER);
Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
Statement stmt = myConn.createStatement();
ResultSet myResultSet = stmt.executeQuery(mysql);

if (myResultSet.next())
{       
        int auth = myResultSet.getInt("c_auth");
        int countrow = myResultSet.getInt("c_row");
        if (auth >= 100)
        {
                session.setAttribute("cs55.auth", "U");
                stmt.close();
                myConn.close();
                %><jsp:forward page="<%= linkpage %>" /><%
        }
        else if (countrow >= 1)
        { 
                session.setAttribute("cs55.auth", "R");
                stmt.close();
                myConn.close();
                %><jsp:forward page="<%= linkpage %>" /><%
        }
        else
        {
                
                stmt.close();
                myConn.close();
                %><jsp:forward page="notauth.jsp" /><%
        }
        
}
else
{
        stmt.close();
        myConn.close();
        %><jsp:forward page="notauth.jsp" /><%
}
%>
</center>
</body>
</html>
