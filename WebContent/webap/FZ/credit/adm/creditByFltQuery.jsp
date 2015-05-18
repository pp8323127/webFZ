<%@ page contentType="text/html; charset=big5" language="java" errorPage="" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 

String fltd = request.getParameter("fltd");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("sect");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew List for Purser</title>

<link rel="stylesheet" type="text/css" href="menu.css">
<script language="JavaScript" src="calendar2.js" ></script>

<style type="text/css">
label,submit,button{
padding-left:1em;}
</style>
<script src="../../js/showDate.js" language="javascript" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function chk()
{
	var d = document.getElementById("fltd").value;
	var n = document.getElementById("fltno").value;
	var s = document.getElementById("sect").value;

	if(d == "")
	{
		alert("請輸入Fltd");
		document.getElementById("fltd").focus();
		return false;
	}
	else if(n == "")
	{
		alert("請輸入Fltno");
		document.getElementById("fltno").focus();
		return false;
	}
	else if(s == "")
	{
		alert("請輸入sector");
		document.getElementById("sect").focus();
		return false;
	}
	else
	{
		document.getElementById("s1").disabled=true;
		return true;
	}
}
</script>
</head>
<body>
<form name="form1"  action="creditByFlt.jsp" method="post" target="mainFrame"  class="txtblue" onsubmit="return chk();">
(EF積點新增 By Flt) Fltd&nbsp;&nbsp;<input type="text" name="fltd" size="10" id="fltd" value="<%=fltd%>" class="txtblue">
<img height="16" src="../img/cal.gif" width="16" onclick="cal.popup();">&nbsp;&nbsp;
Fltno&nbsp;&nbsp;<input type="text" size="6" maxlength="6" name="fltno" id="fltno" value="<%=fltno%>" onkeyup="javascript:this.value=this.value.toUpperCase();" class="txtblue">&nbsp;&nbsp;
Sector&nbsp;&nbsp;<input name="sect" type="text" id="sect" value="<%=sect%>" onkeyup="javascript:this.value=this.value.toUpperCase();" size="6" maxlength="6"  class="txtblue">
<input name="s1" id="s1" type="submit" class="txtblue" value="Query">
<input name="btn" type="button" class="txtblue" value="Reset" OnClick="document.form1.s1.disabled=0">

</form>
</body>
</html>

<script language="JavaScript">
var cal = new calendar2(document.forms['form1'].elements['fltd']);
cal.year_scroll = true;
cal.time_comp = false;
</script>