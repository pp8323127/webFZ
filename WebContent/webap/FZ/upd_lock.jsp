<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,ci.db.*,java.sql.*,tool.*,java.sql.*,java.util.*,java.io.*,java.text.*"%>
<%
//設定班表是否開放
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
 %>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
else
{

Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;
try{

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

String userid 	=(String) session.getAttribute("userid") ; 
String setlock = request.getParameter("setlock");


String sql = "UPDATE FZTCREW SET LOCKED ='" + setlock +"' WHERE EMPNO ='"+ sGetUsr+"'" ;
			
//myResultSet = 
stmt.executeUpdate(sql); 	//執行

if("638143".equals(sGetUsr))
{//send email
	//Sent email to notice
	//************************************************************************	
	tool.Email al = new tool.Email();
	String sender = "TPEEG@email.china-airlines.com";
	String receiver = "640790@cal.aero";
	String cc = "";
	String mailSubject = "638143 has been setlock = "+setlock;
	StringBuffer mailContent = new StringBuffer();
	mailContent.append(new java.util.Date()+"\r\n");
	al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
	//************************************************************************
}

fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ289");

%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>


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
<script language="JavaScript" type="text/JavaScript">
	alert("Schedule status has been updated!!System will logout automatically.\nPlease login again!!\n\n班表狀態已更改，系統即將自動登出，請重新登入");
	self.parent.location="sendredirect.jsp";	
</script>

<body>
<div align="center">
<!--
  <p class="txttitletop">Update Success !!</p>
  <p><a href="lock.jsp" class="cs55text">Click here to see the status of Schedule </a></p>
  -->
</div>
</body>
</html>
<%
}	
%>