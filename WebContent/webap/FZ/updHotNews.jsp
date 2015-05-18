<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,ci.db.*,java.sql.*,java.text.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
//更新最新消息
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>update Hot News!!</title>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<br>
<div align="center">
  <%

Connection conn = null;
Driver dbDriver = null;
Statement stmt = null;
//ResultSet myResultSet = null;
int count = 0;
boolean t = false;
String sql = "";

String ms = request.getParameter("ms").trim();
String flag = request.getParameter("flag");

try{

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

if(flag.equals("1")){ //flight crew hot news
	sql = "update fzthotn set ms=replace('"+ms+"','\r\n','<BR>'),chgdate=sysdate,chguser='"+sGetUsr+"' where flag='1'";//用,取代換行符號
}
else{ //cabin crew hot news
	sql = "update fzthotn set ms=replace('"+ms+"','\r\n','<BR>'),chgdate=sysdate,chguser='"+sGetUsr+"' where flag='2' and station='TPE'";
}
stmt.executeUpdate(sql);

%>
  <span class="txttitletop">Update Hot News Success!!</span><br>
<a href="edHotNews.jsp" target="_self" ><p class="txtxred" style="text-decoration:underline ">View Hot News</p></a>
</div>
</body>
</html>
<%
}
catch(SQLException sqle){
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
%>
	<jsp:forward page="showmessage.jsp" >
	<jsp:param name="messagestring" value="<p style='font-size:10pt;color:#0066FF'>字數超過限制，請重新輸入</p>"/>
	<jsp:param name="messagelink" value="<p style='font-size:10pt;color:FF0000'>BACK</p>" />
	<jsp:param name="linkto" value="javascript:history.back(-1)"/>
	</jsp:forward>

<%

}
catch (Exception e)
{

	  t = true;
	  out.print(e.toString()+"<br>");
}
finally
{
//	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t){
%>
      <jsp:forward page="err.jsp" /> 
<%
}
%>


