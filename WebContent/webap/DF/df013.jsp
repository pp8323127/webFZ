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
<title>DF013</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<center>
<h2>Edit Rate Table</h2>

<%
   String rkcode = request.getParameter("RKCODE");
   
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   
   ResultSet myResultSet = stmt.executeQuery("select * from dftflrk where rkcode = '"+rkcode+"'");
   if (myResultSet != null)
   {
        while (myResultSet.next())
   	{
   	        String cabin = myResultSet.getString("cabin");
	        String occu = myResultSet.getString("occu");
	        String otrate1 = myResultSet.getString("otrate1");
	        String otrate2 = myResultSet.getString("otrate2");
	        String derate = myResultSet.getString("derate");
	        String flpa = myResultSet.getString("flpa");
	        String flpa20 = myResultSet.getString("flpa20");
	        String pocket = myResultSet.getString("pocket");
	        String rem = myResultSet.getString("rem");
%>
<form method="post" action="upddf013.jsp">
<table border="1">
<tr>
    <td><b>RKCode</b></td><td><input type="hidden" name="rkcode" value="<%= rkcode %>"><%= rkcode %></td>
</tr>
<tr>
    <td><b>Cabin</b></td><td><input name="cabin" type="text" value="<%= cabin %>"></td>
</tr>
<tr>
    <td><b>Occu</b></td><td><input name="occu" type="text" value="<%= occu %>"></td>
</tr>
<tr>
    <td><b>Otrate1</b></td><td><input name="otrate1" type="text" value="<%= otrate1 %>"></td>
</tr>
<tr>
    <td><b>Otrate2</b></td><td><input name="otrate2" type="text" value="<%= otrate2 %>"></td>
</tr>
<tr>
    <td><b>Derate</b></td><td><input name="derate" type="text" value="<%= derate %>"></td>
</tr>
<tr>
    <td><b>Flpa</b></td><td><input name="flpa" type="text" value="<%= flpa %>"></td>
</tr>
<tr>
    <td><b>Flpa20</b></td><td><input name="flpa20" type="text" value="<%= flpa20 %>"></td>
</tr>
<tr>
    <td><b>Pocket</b></td><td><input name="pocket" type="text" value="<%= pocket %>"></td>
</tr>
<tr>
    <td><b>Rem</b></td><td><input name="rem" type="text" value="<%= rem %>"></td>
</tr>
<tr>
    <td colspan="2">
         <center>
              
      <input type="submit" value="Update Change" >
         </center> 
</tr>
<tr>
</table>
</form>
<%        
    	}  
   }
   stmt.close();
   myConn.close();
%>
</center>
</body>
</html>
