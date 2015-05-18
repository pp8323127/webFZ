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
//取得是否為PowerUser
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();
// ck.isHasPowerUserAccount()  僅檢查是否有帳號，不檢查密碼
%>
<html>
<head>
<title>Tsa Left Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language=javaScript>
<!-- Beginning of JavaScript ------------------------------------------------------
function showtime(){
var Now  = new Date()
var month = Now.getMonth() + 1
var day = Now.getDate()
var year = Now.getFullYear()
//document.write(month + "/" + day + "/" + year)
var hours=Now.getHours()
var minutes=Now.getMinutes()
var seconds=Now.getSeconds()
if (hours==0) hours=12
if (minutes<=9) minutes="0"+minutes
if (seconds<=9) seconds="0"+seconds
document.Tick.Clock.value= month+"/"+day+" "+hours+":"+minutes+":"+seconds
setTimeout("showtime()",1000)
}

function showtimeu(){
var Now2  = new Date()
var month = Now2.getUTCMonth() + 1
var day = Now2.getUTCDate()
var year = Now2.getUTCFullYear()
var hours=Now2.getUTCHours()
var minutes=Now2.getUTCMinutes()
var seconds=Now2.getUTCSeconds()
if (hours==0) hours=12
if (minutes<=9) minutes="0"+minutes
if (seconds<=9) seconds="0"+seconds
document.Ticku.Clock.value= month+"/"+day+" "+hours+":"+minutes+":"+seconds
//var NowUTC = Date.UTC(year,month,day,hours,minutes)
setTimeout("showtimeu()",1000)
}

function showtimetpe(){
var Now  = new Date()
//var TPE =  (Now.getTime() + (Now.getTimezoneOffset() * 60000) )
var utc_int = (Now.getTime() + (Now.getTimezoneOffset() * 60000) )  //msec integer
var NowUTC = new Date(utc_int )
var NowTPE = new Date(utc_int + (3600000* 8 ))  // NowUTC add 8 hours
var month = NowTPE.getMonth() + 1
var day = NowTPE.getDate()
var year = NowTPE.getFullYear()
var hours=NowTPE.getHours()
var minutes=NowTPE.getMinutes()
var seconds=NowTPE.getSeconds()
if (hours==0) hours=12
if (minutes<=9) minutes="0"+minutes
if (seconds<=9) seconds="0"+seconds
document.Ticktpe.Clock.value= month+"/"+day+" "+hours+":"+minutes+":"+seconds
//var NowUTC = Date.UTC(year,month,day,hours,minutes)
setTimeout("showtimetpe()",1000)
}
// - End of JavaScript ------------------------------------------------------------ -->
</script>
<script language="JavaScript" type="text/JavaScript">
//-- for using onclick with frame
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>

</head>	
<body bgcolor="#99ccff" >
OutStation<br>
<font size="2">Crew on flight query</font><br>
<hr>
<!-- <p><a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>Crew List</a></p> -->
<p><a href="#" class="txtblue" onClick='load("AUH/crewlistquery.jsp","../blank.htm")'>Crew List</a></p>
<p class="txtblue"><a href="#" onClick='load("../GD/gdQuery.jsp","../blank.htm")'>Web GD</a> </p>
<hr>
<!-- 2009/10/14 -->
簡體CrewList<br>
Simp-CHN Crew<br>
<a href="http://tpecsap03.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">web1</a>
<a href="http://tpecsap04.china-airlines.com/outstn/GBCabinCrewListv2.aspx" target="mainFrame">web2</a>
<hr>
</p>

<a href="#" class="txtblue" onClick='load("../blank.htm","sendredirect.jsp")'><font color="#666666">Logout</font></a><br>
<%
if(ck.isHasPowerUserAccount() ){
%>
<br>
<a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">Other CII</span></a>
<%
}
%>
<hr>
<div id="timediv" class="timestyle">
  </div>
<form name="Tick">
<font size="1">
<input type="text" size="14" name="Clock">Local</font>
</form>
<script>
<!--
showtime()
//-->
</script>

<form name="Ticku"><font size="1">
<input type="text" size="14" name="Clock">UTC</font>
</form>
<script>
<!-- Show UTC date time
showtimeu()
//-->
</script>

<form name="Ticktpe"><font size="1">
<input type="text" size="14" name="Clock">TPE</font>
</form>
<script>
<!-- Show TPE date time
showtimetpe()
//-->
</script>

<font size="1">2009/10/08 Revised </font> 
 
</body>
</html>
