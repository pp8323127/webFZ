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
Update Crew Record
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<h2>Update Crew Record</h2>
<%
   String mywhere = (String)session.getValue("MM_Where");
   String ca = request.getParameter("ca");
   String fo = request.getParameter("fo");
   String fe = request.getParameter("fe");
   String inst = request.getParameter("inst");
   String night = request.getParameter("night");
   String dutyip = request.getParameter("dutyip");
   String dutysf = request.getParameter("dutysf");
   String dutyca = request.getParameter("dutyca");
   String dutyfo = request.getParameter("dutyfo");
   String dutyife = request.getParameter("dutyife");
   String dutyfe = request.getParameter("dutyfe");
   String today = request.getParameter("today");
   String tonit = request.getParameter("tonit");
   String ldday = request.getParameter("ldday");
   String ldnit = request.getParameter("ldnit");
   String pic = request.getParameter("pic");
   String updsql = "Update DFTCREC set " + 
                   "ca = " + ca +
                   ", fo = " + fo + 
                   ", fe = " + fe +
                   ", inst = " + inst + 
                   ", night = " + night +
                   ", dutyip = " + dutyip +
                   ", dutysf = " + dutysf +
                   ", dutyca = " + dutyca +
                   ", dutyfo = " + dutyfo +
                   ", dutyife = " + dutyife +
                   ", dutyfe = " + dutyfe +
                   ", today = " + today +
                   ", tonit = " + tonit + 
                   ", ldday = " + ldday + 
                   ", ldnit = " + ldnit +
                   ", pic = " + pic +
                   mywhere;
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);  
   Statement stmt = myConn.createStatement();  
   int rowsAffected = stmt.executeUpdate(updsql);
   if (rowsAffected == 1)
   {
%>
      <h1>Successful Modification of Crew Record</h1>
      <a href="crewreclist.jsp?empno=<%=(String)session.getValue("MM_empno")%>">See Crew Records</a><br>
      <a href="login.jsp" target="_top">Go back to Login page</a>
<%  
   }    
   else
   {
%>
      <h1>Sorry, modification has failed.</h1> 
      <a href="crewreclist.jsp?empno=<%=(String)session.getValue("MM_empno")%>">Go back to Crew Records</a>     
<%
   }
   stmt.close();
   myConn.close();
%>

</body>
</html>