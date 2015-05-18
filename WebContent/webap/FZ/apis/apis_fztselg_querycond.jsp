<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="al.*,java.sql.*, java.util.Date"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="sbcheckStyle.css">
<link rel="stylesheet" type="text/css" href="loadingStatus.css">

<script language="JavaScript" src="calendar2.js" ></script>
<script language="JavaScript" type="text/javascript">
function checkData(){
	var e = document.form1.emp.value;
	if(e == ""){
		alert("Please insert employee or serial number .");
		document.form1.emp.focus();
		return false;
	}else{
		submitForm();
		return true;
	}
}
function submitForm(){
	document.getElementById("showLoading").className="showStatus3";
	document.getElementById("s1").disabled=1;
}
</script>
</head>

<body  onLoad="document.form1.emp.focus()">
<div id="showLoading" class="hiddenStatus"></div>

<form name="form1" method="post" target="mainFrame" action="pa_rawline_queryresult.jsp" onsubmit="return checkData()">
  APIS Sent Log 
  <input type="text" name="startDate" size="10" id="startDate" onclick="cal.popup();" >
  <img height="16" src="img/cal.gif" width="16" onclick="cal.popup();"> &nbsp;&nbsp;&nbsp;&nbsp; 
  <label for="empno"></label>
  <input type="submit" name="Submit" id="s1" value="Submit" >
</form>
</body>
</html>
<script language="JavaScript">

var cal = new calendar2(document.forms['form1'].elements['startDate']);
cal.year_scroll = true;
cal.time_comp = false;
document.getElementById("startDate").value =cal.gen_date(new Date());

var cal2 = new calendar2(document.forms['form1'].elements['endDate']);
cal2.year_scroll = true;
cal2.time_comp = false;
document.getElementById("endDate").value =cal2.gen_date(new Date());

var cal3 = new calendar2(document.forms['form1'].elements['startDate2']);
cal3.year_scroll = true;
cal3.time_comp = false;
document.getElementById("startDate2").value =cal3.gen_date(new Date());

var cal4 = new calendar2(document.forms['form1'].elements['endDate2']);
cal4.year_scroll = true;
cal4.time_comp = false;
document.getElementById("endDate2").value =cal4.gen_date(new Date());
</script>