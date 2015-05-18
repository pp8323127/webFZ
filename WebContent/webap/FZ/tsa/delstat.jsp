<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*"%>
<%
//??Comment
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
/*
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} */

String[] stat = request.getParameterValues("checkdel");
String ks=null;
String sql=null;
for(int i=0;i<stat.length;i++)
{
	if (i==0)
	{
		ks = "'"+stat[i]+"'";
	}
	else
	{
		ks = ks+",'"+stat[i]+"'";
	}
}
sql = "delete fztustat where station in ("+ks+")";

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
boolean t = false;

try{
dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
stmt = conn.createStatement();

stmt.executeUpdate(sql); 	//°õ¦æ
}
catch (Exception e)
{
	  t = true;
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t)
{
%>
      <jsp:forward page="../err.jsp" /> 
<%
}else{
%>
      <jsp:forward page="station.jsp" /> 
<%
}
%>
