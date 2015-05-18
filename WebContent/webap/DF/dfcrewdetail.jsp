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
DFCrew detail Information
</title>
<meta http-equiv="pragma" content="no-cache">
</head>

<body background="clearday.jpg">
<center>
  <p><font face="Comic Sans MS" color="#333333">Crew Detail Information</font></p>

<%
   String empno = request.getParameter("EMPNO");
     
   Class.forName(MM_cnORP3DF_DRIVER);
   Connection myConn = DriverManager.getConnection(MM_cnORP3DF_STRING,MM_cnORP3DF_USERNAME,MM_cnORP3DF_PASSWORD);
   Statement stmt = myConn.createStatement();
   ResultSet myResultSet = stmt.executeQuery("select * from dftcrew where empno = '" + empno + "'");
   if (myResultSet != null)
   {
   		while (myResultSet.next())
		{
   			String name = myResultSet.getString("name");
			String ename = myResultSet.getString("ename");
			String sex = myResultSet.getString("sex");
			String flag = myResultSet.getString("flag");
			String cabin = myResultSet.getString("cabin");
			String box = myResultSet.getString("box");
			String nflrk = myResultSet.getString("nflrk");
			String oflrk = myResultSet.getString("oflrk");
			String ovrk = myResultSet.getString("ovrk");
			String indt = myResultSet.getString("indt");
			String poid = myResultSet.getString("poid");
			String podt = myResultSet.getString("podt");
			String pout = myResultSet.getString("pout");
			String post = myResultSet.getString("post");
			String occu = myResultSet.getString("occu");
			String fleet = myResultSet.getString("fleet");
			String base = myResultSet.getString("base");
			String sect = myResultSet.getString("sect");
			String paycode = myResultSet.getString("paycode");
			String brk = myResultSet.getString("brk");
			String brkrate = myResultSet.getString("brkrate");
			String banknont = myResultSet.getString("banknont");
			String banknous = myResultSet.getString("banknous");
			String taxfmin = myResultSet.getString("taxfmin");
			String ipcp = myResultSet.getString("ipcp");
			String traf = myResultSet.getString("traf");
%>
  <form method="post" action="upddfcrew.jsp">
    <table border="1">
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">EmpNo</font></b></td>
        <td><%= empno %>
		    <input type="hidden" name="empno" value="<%= empno %>">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Name</font></b></td>
        <td><input type="text" name="name" value="<%= name %>">
        </td>
      </tr>
      <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Ename</font></b></td>
        <td><input type="text" name="ename" value="<%= ename %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Sex</font></b></td>
        <td><input type="text" name="sex" value="<%= sex %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Flag</font></b></td>
        <td><input type="text" name="flag" value="<%= flag %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Cabin</font></b></td>
        <td><input type="text" name="cabin" value="<%= cabin %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Box</font></b></td>
        <td><input type="text" name="box" value="<%= box %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Nflrk</font></b></td>
        <td><input type="text" name="nflrk" value="<%= nflrk %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Oflrk</font></b></td>
        <td><input type="text" name="oflrk" value="<%= oflrk %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Ovrk</font></b></td>
        <td><input type="text" name="ovrk" value="<%= ovrk %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Indt</font></b></td>
        <td><input type="text" name="indt" value="<%= indt %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Poid</font></b></td>
        <td><input type="text" name="poid" value="<%= poid %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Podt</font></b></td>
        <td><input type="text" name="podt" value="<%= podt %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Pout</font></b></td>
        <td><input type="text" name="pout" value="<%= pout %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Post</font></b></td>
        <td><input type="text" name="post" value="<%= post %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Occu</font></b></td>
        <td><input type="text" name="occu" value="<%= occu %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Fleet</font></b></td>
        <td><input type="text" name="fleet" value="<%= fleet %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Base</font></b></td>
        <td><input type="text" name="base" value="<%= base %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Sect</font></b></td>
        <td><input type="text" name="sect" value="<%= sect %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Paycode</font></b></td>
        <td><input type="text" name="paycode" value="<%= paycode %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Brk</font></b></td>
        <td><input type="text" name="brk" value="<%= brk %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Brkrate</font></b></td>
        <td><input type="text" name="brkrate" value="<%= brkrate %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Banknont</font></b></td>
        <td><input type="text" name="banknont" value="<%= banknont %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Banknous</font></b></td>
        <td><input type="text" name="banknous" value="<%= banknous %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Taxfmin</font></b></td>
        <td><input type="text" name="taxfmin" value="<%= taxfmin %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Ipcp</font></b></td>
        <td><input type="text" name="ipcp" value="<%= ipcp %>">
        </td>
      </tr>
	  <tr> 
        <td><b><font face="Arial, Helvetica, sans-serif" size="2">Traf</font></b></td>
        <td><input type="text" name="traf" value="<%= traf %>">
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