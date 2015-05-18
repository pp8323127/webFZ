<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String empno = request.getParameter("empno");

//檢查被查詢者是否開放班表
swap3ac.CheckLockSkj cLock = new swap3ac.CheckLockSkj(empno);
try{
	cLock.SelectData();	
}catch(Exception e){
}

fzac.CrewPublishedSkj cs = new fzac.CrewPublishedSkj(empno);

ArrayList crewSkjAL = null;
boolean status = false;
String  errMsg = "";
try {
	cs.SelectData();
	crewSkjAL = cs.getCrewSkjAL();
	status = true;
} catch (ClassNotFoundException e) {	
	errMsg = e.toString();
} catch (SQLException e) {
	errMsg = e.toString();
} catch (Exception e) {
	errMsg = e.toString();
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../errStyle.css">
<link rel="stylesheet" type="text/css" href="swapArea.css">
<link rel="stylesheet" type="text/css" href="hintsClass.css">
<script language="JavaScript" src="tigra_hints.js"></script>
<script language="JavaScript" src="tigra_hints_cfg.js"></script>
<script language="JavaScript" >
	var myHint = new THints (HINTS_ITEMS, HINTS_CFG);
</script>
<title>組員班表</title>


</head>

<body >
<%
//班表是否公布
 if(!status){
%>
	<p  class="errStyle1">ERROR:<%=errMsg%></p>
<%
}else if(crewSkjAL == null){
%>
	<p  class="errStyle1">NO DATA!!</p>
<%
}else if(!cLock.isOpenSkj()){
%>
	<p class="errStyle1"><%=empno%> 不開放個人班表提供查詢</p>
<%
}else {
%>
<table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:0pt solid black;border-collapse:collapse; " >
 <tr >
   <td height="86" colspan="2" valign="top" class="red" >The following shedule is for reference only. <br>
     For official up-to-date schedule information, please contact Scheduling Department. <br>
    下列班表僅供參考，請向組員派遣部門確認個人正式班表任務。</td>
 </tr>
 <tr >
   <td width="97%" class="center" >Crew's Current Schedule , Empno:<span class="blue"><%=empno%></span><br>
   <span style="font-size:smaller;color:#0000FF; ">Click Fltno to View Flight Crew List</span></td>
   <td width="3%" valign="bottom" class="right" ><a href="javascript:window.print()"><img src="../images/print.gif" border="0"></a></td>
 </tr>
 </table>
<table width="90%"  border="0" align="center" cellpadding="0" cellspacing="1"   style="border:1pt solid black;border-collapse:collapse; ">
  <tr >
    <th width="23%"> Start Date Time 
    (Local)</th>
    <th width="21%">End Date Time 
  (Local)</th>
    <th width="14%">Fltno<br>
    <span style="font-size:smaller ">(Crew List)</span></th>
    <th width="11%">Dpt</th>
    <th width="10%">Arv</th>
    <th width="11%">SpCode</th>
    <th width="10%">Rank</th>
  </tr>
  <%
  	for (int i = 0; i < crewSkjAL.size(); i++) {
		fzac.CrewMonthSkjObj obj = (fzac.CrewMonthSkjObj) crewSkjAL.get(i);

	String cssStyle = "";
	if (i%2 == 1)	{
		cssStyle = "gridRowEven";
	}	else{
		cssStyle = "gridRowOdd";
	}
%>
      <tr class="center <%=cssStyle %>"> 
    <td height="24"><%=obj.getStrFdate()%></td>
    <td><%=obj.getEndFdate()%></td>
    <td class="right"> <a href="#<%=i%>" name="<%=i%>" onMouseOver="myHint.show(2)" onMouseOut="myHint.hide()"  onClick="javascript:viewFlightCrew('<%=obj.getTripno()%>');"><%=obj.getFltno()%></a></td>
    <td><%=obj.getDpt()%></td>
    <td><%=obj.getArv()%></td>
    <td><%=obj.getSpCode()%></td>
    <td><%=obj.getActing_rank()%></td>
  </tr>
  <%
  }
  %>
  <tr>
  <td colspan="7">
  Click Fltno to View Flight Crew List By Trip.<br>
	  點擊Fltno可檢視該任務組員名單.
  </td>
  </tr>
</table>
 <table width="90%" border="0" align="center" cellpadding="0" cellspacing="1" style="border:0pt solid black;border-collapse:collapse; " >
 <tr>
   <td class="center"><input type="button" value="CLOSE WINDOW" onClick="javascript:self.close();"></td></tr>
 </table>
 <form name="form1" method="post" id="form1" target="_blank">
	<input type="hidden" name="tripno" id="tripno">
</form>

<script language="javascript" type="text/javascript">
	function viewFlightCrew(tripno){
		document.getElementById("tripno").value = tripno;
		//document.form1.action="viewFlightCrew.jsp";
		document.form1.action="viewFlightCrew.jsp";
		document.form1.submit();
	
	}
	

</script>


<%

} 
%>

</body>
</html>
