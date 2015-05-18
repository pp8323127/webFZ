<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,java.sql.*"%>
<%
//·s¼Wcomments
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
String addsta = request.getParameter("addsta");

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
boolean t = false;

ci.db.ConnDB cn = new ConnDB() ;

try{
//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
//DataSource
cn.setDFUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
con_ORP3  = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement();

String sql = "insert into fztustat(station) values(UPPER('"+ addsta +"'))";

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
