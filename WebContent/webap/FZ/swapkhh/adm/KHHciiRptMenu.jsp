<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String userid = (String) session.getAttribute("userid") ;
String KHHEFFZ = (String)session.getAttribute("KHHEFFZ");

if(userid == null){
response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else{

	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>CII Report</title>
<link rel="stylesheet" type="text/css" href="../../AC/swapArea.css">
<script language="JavaScript" type="text/JavaScript">
function pageLoad(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
</head>

<body>
<%

fzAuthP.UserID usrid = new fzAuthP.UserID(userid,null);
fzAuthP.CheckHRUnit chkHR = new fzAuthP.CheckHRUnit();
fzAuthP.HRObj hrObj = chkHR.getHrObj();
String unitCD = "";
if(chkHR.isDutyEmp() ){
	unitCD = hrObj.getUnitcd();
}

fzac.CrewInfo ci = new fzac.CrewInfo(userid);
	fzac.CrewInfoObj ciObj = ci.getCrewInfo();
	if(!"Y".equals(KHHEFFZ)&&ci.isHasData() ){//組員身份
	%>
	<div style="background-color:#99FFFF;text-align:center;color:#FF0000;font-family:Verdana;font-size:10pt; ">您未被授權使用本頁面</div>
	
	<%
	}else{



fz.writeLog wl = new fz.writeLog();   
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ460K");

session.setAttribute("cs55.usr",userid);
session.setAttribute("cabin","N");

// 設定  單位代碼
session.setAttribute("fullUCD",unitCD);
%>
<table width="47%"  border="0" align="center" cellspacing="0">
  <tr class="center">
    <td height="35" colspan="2" style="background-color:#336699;color:#FFFFFF;font-size:larger;font-weight:bold; ">KHH - CII Report </td>
  </tr>
  <tr>
    <td width="7%">&nbsp;</td>
    <td width="93%"><a href="#"  onClick='pageLoad("/webfz/FZ/tsa/dailycrew/dailyquery.htm","../blank.htm")'>Daily Check</a></td>
  </tr>
  <tr class="gridRowEven" >
      <td >&nbsp;</td>
    <td ><a href="#"  onClick='pageLoad("/webfz/FZ/tsa/dailycrew/KHHDailyCheckQuery.jsp","../blank.htm")'>KHH Daily Check</a></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td ><a href="#"  onClick='pageLoad("../blank.htm","/webfz/FZ/tsa/dailycrew/sbMenu.jsp")'>Standby Crew</a></td>
  </tr>
  <tr class="gridRowEven" >
    <td>&nbsp;</td>
    <td><a href="#"  onClick='pageLoad("/webfz/FZ/tsa/dailycrew/schQuery.jsp","../blank.htm")'>Schedule Query</a>
</td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td ><a href="#"  onClick='pageLoad("../blank.htm","/webfz/FZ/tsa/dailycrew/crewListMenu.jsp")'>Crew List Query</a></td>
  </tr>
  <tr class="gridRowEven" >
    <td >&nbsp;</td>
    <td ><a href="#"  onClick='pageLoad("/webfz/FZ/tsa/SCH/crewSchequery.htm","../blank.htm")'>月班表PROD</a></td>
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td ><a href="#"  onClick='pageLoad("/webfz/FZ/tsa/dailycrew/crewListForPurQuery.htm","../blank.htm")'>Flight Crew List</a></td>
  </tr>
 
</table>
<%
}
%>
</body>
</html>
<%
}
%>
