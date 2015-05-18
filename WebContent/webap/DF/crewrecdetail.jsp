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
<title>
Edit Crew Record Detail
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>
<h2>Edit Crew Record</h2>

<%
   String empno = request.getParameter("empno");
   session.putValue("MM_empno", empno);
   String fleet = request.getParameter("fleet");
   String rectype = request.getParameter("rectype");
   String mm = request.getParameter("mm");
   String yy = request.getParameter("yy");

   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   
   ResultSet myResultSet = stmt.executeQuery("select * from DFTCREC where rectype = '"+rectype+"' and yy = "+yy+" and mm = "+mm+" and staff_num = "+empno+" and fleet_cd = '"+fleet+"'");
   if (myResultSet != null)
   {
        while (myResultSet.next())
   	{
   	        String ca = myResultSet.getString("ca");
	        String fo = myResultSet.getString("fo");
	        String fe = myResultSet.getString("fe");
	        String inst = myResultSet.getString("inst");
	        String night = myResultSet.getString("night");
	        String dutyip = myResultSet.getString("dutyip");
	        String dutysf = myResultSet.getString("dutysf");
	        String dutyca = myResultSet.getString("dutyca");
	        String dutyfo = myResultSet.getString("dutyfo");
	        String dutyife = myResultSet.getString("dutyife");
	        String dutyfe = myResultSet.getString("dutyfe");
	        String today = myResultSet.getString("today");
	        String tonit = myResultSet.getString("tonit");
	        String ldday = myResultSet.getString("ldday");
	        String ldnit = myResultSet.getString("ldnit");
	        String pic = myResultSet.getString("pic");
	        session.putValue("MM_Where"," where rectype = '"+rectype+"' and yy = "+yy+" and mm = "+mm+" and staff_num = "+empno+" and fleet_cd = '"+fleet+"'");
%>
<form method="post" action="updcrewrec.jsp">
<table border="1">
<tr>
    <td><b>RecType</b></td><td><%= rectype %></td>
</tr>
<tr>
    <td><b>YY</b></td><td><%= yy %></td>
</tr>
<tr>
    <td><b>MM</b></td><td><%= mm %></td>
</tr>
<tr>
    <td><b>Staff_num</b></td><td><%= empno %></td>
</tr>
<tr>
    <td><b>Fleet_cd</b></td><td><%= fleet %></td>
</tr>
<tr>
    <td><b>CA</b></td><td><input name="ca" type="text" width="10" value="<%= ca %>"></td>
</tr>
<tr>
    <td><b>FO</b></td><td><input name="fo" type="text" width="10" value="<%= fo %>"></td>
</tr>
<tr>
    <td><b>FE</b></td><td><input name="fe" type="text" width="10" value="<%= fe %>"></td>
</tr>
<tr>
    <td><b>Inst</b></td><td><input name="inst" type="text" width="10" value="<%= inst %>"></td>
</tr>
<tr>
    <td><b>Night</b></td><td><input name="night" type="text" width="10" value="<%= night %>"></td>
</tr>
<tr>
    <td><b>DutyIP</b></td><td><input name="dutyip" type="text" width="10" value="<%= dutyip %>"></td>
</tr>
<tr>
    <td><b>DutySF</b></td><td><input name="dutysf" type="text" width="10" value="<%= dutysf %>"></td>
</tr>
<tr>
    <td><b>DutyCA</b></td><td><input name="dutyca" type="text" width="10" value="<%= dutyca %>"></td>
</tr>
<tr>
    <td><b>DutyFO</b></td><td><input name="dutyfo" type="text" width="10" value="<%= dutyfo %>"></td>
</tr>
<tr>
    <td><b>DutyIFE</b></td><td><input name="dutyife" type="text" width="10" value="<%= dutyife %>"></td>
</tr>
<tr>
    <td><b>DutyFE</b></td><td><input name="dutyfe" type="text" width="10" value="<%= dutyfe %>"></td>
</tr>
<tr>
    <td><b>ToDay</b></td><td><input name="today" type="text" width="5" value="<%= today %>"></td>
</tr>
<tr>
    <td><b>ToNit</b></td><td><input name="tonit" type="text" width="5" value="<%= tonit %>"></td>
</tr>
<tr>
    <td><b>LdDay</b></td><td><input name="ldday" type="text" width="5" value="<%= ldday %>"></td>
</tr>
<tr>
    <td><b>LdNit</b></td><td><input name="ldnit" type="text" width="5" value="<%= ldnit %>"></td>
</tr>
<tr>
    <td><b>PIC</b></td><td><input name="pic" type="text" width="10" value="<%= pic %>"></td>
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