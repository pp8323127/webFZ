<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>

<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} else{

// ----- 取得是否為PowerUser -----
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();

%>
<html>
<head>
<title>Tsa Left Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">

</head>
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}

</script>

<body bgcolor="#99ccff" >
OD CII
<hr>
<p><a href="#" class="txtblue" onClick='load("../../FZ/pr_interface/simchk_querycond.jsp","../blank.htm")'>SIM Check</a></p>
<p><a href="#" class="txtblue" onClick='load("http://tpeweb03:9901/webdz/catiii/topframe.jsp","../blank.htm")'>CATII/IIIa</a></p>
<p><a href="#" class="txtblue" onClick='load("http://tpeweb03:9901/webdz/catiii/catiiQ.htm","../blank.htm")'>CATII/IIIa<br>Excel</a></p>
<!--CS40 2007/12/31 <p><a href="#" class="txtblue" onClick='load("http://tsaweb02:8099/LIC/querycrew.htm","../blank.htm")'>License</a></p>-->
<p class="txtblue" ><a href="#" onClick='load("querycrew.htm","../blank.htm")'>Crew Query </a></p>
<p class="txtblue" ><a href="#" onClick='load("../../FZ/crewmeal/KHHmealQuery.jsp","../blank.htm")'>KHH Crew Meal </a></p>
<p class="txtblue"><a href="#" onClick='load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a> </p>


<%
if (ck.isHasPowerUserAccount() || "633".equals(unidCD)|| "092".equals(unidCD)|| "093".equals(unidCD)) {
%>
<p><a href="#" class="txtblue" onClick='load("dailycrew/dailyquery.htm","../blank.htm")'>Daily Check</a></p>
<p><a href="#" class="txtblue" onClick='load("dailycrew/SBquery.htm","../blank.htm")'>Standby Crew</a></p>
<p><a href="#" class="txtblue" onClick='load("dailycrew/schQuery.jsp","../blank.htm")'>Schedule Query</a></p>
<p><a href="#" class="txtblue" onClick='load("../blank.htm","dailycrew/crewListMenu.jsp")'>Crew List Query</a></p>

<!-- CS40 2008/1/15 <p><a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>外站 Crew List</a></p> -->
<p>
<a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>外站 Crew List</a>
<br><br>
簡體CrewList</font><br>
<a href="http://tpecsap03.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">web1</a>
<a href="http://tpecsap04.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">web2</a>
</p>

<%
}

if(ck.isHasPowerUserAccount()){
%>

<p><a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">選擇登入頁面</span></a></p>
<%
}
%>
<br>


<p><a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'>Logout</a></p>
<hr>
<font size="1">tsaleft_od.jsp</font> 
</body>
</html>
<%
}//end of has session
%>