<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>New Credit Query</title>
<script language="Javascript" src="../../../js/FieldTools.js"></script>
<link rel="stylesheet" type="text/css" href ="menu.css" >
<link rel ="stylesheet" type="text/css" href="../style/checkStyle1.css">
<link rel ="stylesheet" type="text/css" href="../style/btn.css">
<script language="JavaScript" src="calendar2.js" ></script>
<script LANGUAGE="JavaScript">
function setgrouparea()
{
	var base = document.form1.base.value;
	if(base=="TPE")
	{
		span_groups.style.display='';
	}
	else
	{
		span_groups.style.display='none';
		document.form1.groups.value = "ALL";
	}
}	

function f_submit()
{
	var sdate = eval("document.form1.sdate.value");
	var edate = eval("document.form1.edate.value");
	 if(sdate =="" || edate =="")
	 {
		alert("Please select date range!!");
		return false;
	 }
	 else
	 {
		document.form1.Submit.disabled=1;
		return true;
	 }
}
</script>

</head>
<body onLoad="document.getElementById('sdate').focus(); setgrouparea();">
<form action="newcreditList.jsp" method="post" name="form1" target="mainFrame" class="txtblue" onsubmit="return  f_submit();">
(積點查詢)&nbsp;Date range : 
<input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue"> 			
<img height="16" src="../../images/p2.gif" width="16" onClick ="cal1.popup();"> ~
<input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue"> 			
<img height="16" src="../../images/p2.gif" width="16" onClick ="cal2.popup();">&nbsp;
<span class="txtblue">Base :</span>
<select name="base" class="txtblue" onchange="setgrouparea();">
 <option value="TPE">TPE</option>
 <option value="KHH">KHH</option>
</select>&nbsp;
<span id="span_groups" name="span_groups" style="display:none">
Group :
<select name="groups" class="txtblue">
 <option value="ALL" selected>ALL</option>
 <option value="1">一組</option>
 <option value="2">二組</option>
 <option value="3">三組</option>
 <option value="4">四組</option>
</select></span>&nbsp;
<span class= "txtblue">Empno/Sern:
<input align="center" name="empno" id="empno" type="text" size="6" maxlength="6" class="txtblue" value=""></span>&nbsp;
<input name="Submit" type="submit" class="txtblue" value="Query"> 
<input name="btn" type="button" class="txtblue" value="Reset" OnClick="document.form1.Submit.disabled=0">
</form>
</body>
</html>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['sdate']);
	var cal2 = new calendar2(document.forms[0].elements['edate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	cal2.year_scroll = true;
	cal2.time_comp = false;
</script>
