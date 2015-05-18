<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
//response.setHeader("Cache-Control","no-cache");
//response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
//***************************************
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../logout.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙經理任務簡報表現評量 新增/修改</title>
<script language="JavaScript" src="calendar2.js" ></script>
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript">
function chkRequest()
{
	var sdate = eval("document.form1.sdate.value");
	var edate = eval("document.form1.edate.value");
	 if(sdate =="")
	 {
	 	alert("Please input the date range!!");
		document.form1.sdate.focus();
		return false;
	 }
	 else if(edate =="")
	 {
	 	alert("Please input the date range!!");
		document.form1.edate.focus();
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
<body onLoad="document.getElementById('empno').focus();">
<form action="PRbrief_evalView.jsp" method="post" name="form1" target="mainFrame" class="txtblue" onsubmit="return chkRequest();">
<span class= "txtblue">(任務簡報表現評量查詢)</span> 
<span class= "txtblue">EMPNO/SERN : </span> <input type="text" size="6" maxlength="6" name="empno"  id="empno" class="txtblue">&nbsp;
<span class="txtblue">Base</span>    
<select name="base" class="txtblue">
<option value="ALL">ALL</option>
<option value="TPE">TPE</option>
<option value="KHH">KHH</option>
</select>
<span class= "txtblue">Duty Date :</span>  
	<input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue"> 			
	<img height="20" src="../images/p2.gif" width="20" onClick ="cal1.popup();"> ~
	<input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue"> 			
	<img height="20" src="../images/p2.gif" width="20" onClick ="cal2.popup();">
	&nbsp;
<input name="Submit" type="submit" class="txtblue" value="Query"  > 
<input name="btn" type="button" class="txtblue" value="Reset" OnClick="document.form1.Submit.disabled=0">
</form>
</body>
</html>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['sdate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	document.getElementById("sdate").value =cal1.gen_date(new Date());

	var cal2 = new calendar2(document.forms[0].elements['edate']);
	cal2.year_scroll = true;
	cal2.time_comp = false;
	document.getElementById("edate").value =cal2.gen_date(new Date());
</script>
