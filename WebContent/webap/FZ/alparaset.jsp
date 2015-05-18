<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*,ci.db.*"%>
<%
//砞﹚砞安闽把计
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 

String userid =(String) session.getAttribute("userid") ; 
String offday = "";
String papers = "";
String openday = "";
String opentime = "";

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

try
{
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement();

int maxform = 0;
String sql = "SELECT offday, papers, openday, opentime FROM egtalco ";
myResultSet = stmt.executeQuery(sql); 

if (myResultSet.next())
{
	offday =  myResultSet.getString("offday");
	papers =  myResultSet.getString("papers");
	openday =  myResultSet.getString("openday");
	opentime =  myResultSet.getString("opentime");
}

%>

<html>
<head>
<title>砞﹚叫安闽把计</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<form action="updalparaset.jsp" method="post" name="form1">

<table width="44%"  border="1" align="center" cellpadding="0" cellspacing="1" class="fortable">
  <tr>
    <td colspan="2" class="tablehead3">砞﹚AL闽把计</td>
  </tr>
  <tr>
    <td width="37%" class="tablehead3">–る患眎计</td>	
    <td width="63%" class="txtblue"><input name="papers" type="text" value="<%=papers%>" size="3" maxlength="3"> 眎</td>
  </tr>
  <tr>
    <td width="37%" class="tablehead3">患安虫秨﹍ら</td>	
    <td width="63%" class="txtblue">
		<input name="openday" type="text" value="<%=openday%>" size="3" maxlength="3"> ら 
		<input name="opentime" type="text" value="<%=opentime%>" size="5" maxlength="5"> 24H:MM
	</td>
  </tr>
  <tr>
    <td width="37%" class="tablehead3">患安虫篒ゎら</td>	
    <td width="63%" class="txtblue">
		<input name="offday" type="text" value="<%=offday%>" size="3" maxlength="3"> ら</td>
  </tr>
  <tr>
    <td colspan="2"  class="tablebody"><input name="Submit" type="submit" class="btm" value="э"></td>
  </tr>
</table>
</form>
</body>
</html>
<%
}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>