<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>
<%
//��A�B�@�~��, SYDDM�ϥ�CII 
/*	20060810,  SYDDM (862)		,SR6390,�ϥ�Daily check ,flight crew List,Schedule Query 	*/
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} else{

if( session.getAttribute("cabin") == null){
	session.setAttribute("cabin","N");
}
//���o�O�_��PowerUser
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();


%>
<html>
<head>
<title>Tsa Left Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>

<body bgcolor="#99ccff" >

<p><a href="#" class="txtblue" onClick='load("dailycrew/dailyquery.htm","../blank.htm")'>Daily Check</a></p>
<p><a href="#" class="txtblue" onClick='load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p>
<p><a href="#" class="txtblue" onClick='load("dailycrew/schQuery.jsp","../blank.htm")'>Schedule Query</a></p>

<p class="txtblue"><a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>OutStation Crew List</a></p>

<p><a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a></p>

<%
if(ck.isHasPowerUserAccount() ){
%>
<p><a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">Change Other CII</span></a></p>

<%
}
%>


</body>
</html>
<%
}//end of has session
%>