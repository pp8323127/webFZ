<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>
<%
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
//取得是否為PowerUser
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
<p class="txtblue"><a href="#" onClick='load("../../FZ/crewmeal/mealQuery.jsp","../blank.htm")'> Crew Meal</a></p>
<p class="txtblue"><a href="#" onClick='load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a> </p>


<p class="txtblue"><a href="#" onClick='load("../../FZ/crewmeal/mealQuery_tt.jsp","../blank.htm")'> Crew Meal(TPETT test only)</a></p>

<p class="txtblue"><a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>OutStation Crew List</a></p>

<p><a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a></p>

<%
if(ck.isHasPowerUserAccount() ){
%>
<p><a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt;">Change 
  Other CII</span></a></p>

<%
}
%>
<br>

</body>
</html>
<%
}//end of has session
%>