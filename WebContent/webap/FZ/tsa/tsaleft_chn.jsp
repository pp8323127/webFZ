<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if( session.getAttribute("cabin") == null){
	session.setAttribute("cabin","N");
}
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} 
//���o�O�_��PowerUser
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();
// ck.isHasPowerUserAccount()  ���ˬd�O�_���b���A���ˬd�K�X


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
<p ><!-- CS40 2009/02/11 --><a href='javascript:load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a> </p> 
<hr>²�骩crew list
<p>
<a href="http://tpecsap03.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">Normal</a>
<a href="http://tpecsap04.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">Backup</a>
</p>
<hr>
<p><a href='javascript:load("dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></p> 
<hr>
<p><a href="http://tpecsap03/outstn/ChnNameEdit.aspx" target="mainFrame">²�餤��m�W���@</a></p>
<hr>
<p><a href='javascript:load("AUH/crewlistquery.jsp","../blank.htm")'>�~�� Crew List</a></p>
<hr>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a></p>
</body>
</html>