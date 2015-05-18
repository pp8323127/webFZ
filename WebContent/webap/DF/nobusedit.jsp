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
<title>ea001</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>

<body bgcolor="#FFFFFF" text="#000000" background="clearday.jpg">
<center>
  <p><font face="Comic Sans MS" color="#333333">Crew & FlightCrew Nobus &amp; 
    BankNo-NT Edit</font></p>

<%
   String empno = request.getParameter("empno");
   
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   ResultSet myResultSet = stmt.executeQuery("select * from dftcrew where empno = '"+empno+"'");
   if (myResultSet != null)
   {
        while (myResultSet.next())
   	{
   	        String name = myResultSet.getString("name");
	        String sern = myResultSet.getString("box");
			String banknont = myResultSet.getString("banknont");
			String traf = myResultSet.getString("traf");
%>
  <form method="post" action="updnobus.jsp">
    <table border="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">EmpNo</font></b></td>
        <td> 
          <div align="center"><%= empno %> 
            <input type="hidden" name="empno" value="<%= empno %>">
          </div>
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">SerNo</font></b></td>
        <td> 
          <div align="center"><input name="sern" type="text" value="<%= sern %>"></div>
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Name</font></b></td>
        <td> 
          <div align="center"><%= name %> </div>
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">BankNoNT</font></b></td>
        <td> 
          <div align="center"> 
            <input name="banknont" type="text" width="1" value="<%= banknont %>">
          </div>
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Traf</font></b></td>
        <td> 
          <div align="center"> 
            <input name="traf" type="text" width="1" value="<%= traf %>">
          </div>
        </td>
      </tr>
      <tr> 
        <td colspan="2"> 
          <center>
            <font face="Arial, Helvetica, sans-serif" size="2"> 
            <input type="submit" value="Update Change" >
            </font> 
          </center>
        </td>
      </tr>
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
