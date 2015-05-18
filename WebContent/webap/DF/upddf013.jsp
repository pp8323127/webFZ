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
<%@ include file="../Connections/cnORP3DF.jsp" %>
<html>
<head>
<title>
Update Rate Table
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<h2>Update Rate Table</h2>
<%
    String rkcode = request.getParameter("rkcode");
    String cabin = request.getParameter("cabin");
	String occu = request.getParameter("occu");
	String otrate1 = request.getParameter("otrate1");
	String otrate2 = request.getParameter("otrate2");
	String derate = request.getParameter("derate");
	String flpa = request.getParameter("flpa");
	String flpa20 = request.getParameter("flpa20");
	String pocket = request.getParameter("pocket");
	String rem = request.getParameter("rem");
    String updsql = "Update dftflrk set " + 
                   "cabin = UPPER('" + cabin + "')" +
                   ", occu = UPPER('" + occu + "')" +
                   ", otrate1 = " + otrate1 +
                   ", otrate2 = " + otrate2 + 
                   ", derate = " + derate +
                   ", flpa = " + flpa +
                   ", flpa20 = " + flpa20 +
                   ", pocket = " + pocket +
                   ", rem = '" + rem + "'" +
                   " where rkcode = '" + rkcode + "'";
	
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();  
   int rowsAffected = stmt.executeUpdate(updsql);
   if (rowsAffected == 1)
   {
%>
      <h1>Successful Modification of Crew Record</h1>
      <a href="df012.jsp">See Rate Table List</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, modification has failed.</h1> 
      <a href="df012.jsp">Go back to Rate Table List</a>     
<%
   }
   stmt.close();
   myConn.close();
%>

</body>
</html>