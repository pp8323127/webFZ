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
<title>�ȿ��g�z����²���A¾�ʵ��q �s�W/�ק�</title>
<script language="JavaScript" src="calendar2.js" ></script>
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript">
function chkRequest()
{
	var empno = eval("document.form1.empno.value");
	var sdate = eval("document.form1.sdate.value");
	
	//2011/05/01 �ϥηs�D�w
	if(sdate<"2011/05/01")
	{
		document.form1.action="PRbrief_evalEdit.jsp";
	}
	else if(sdate<"2012/12/01") //2012/12/01 ����D�w
	{
		document.form1.action="PRbrief_evalEdit_new.jsp";
	}
	else
	{
		document.form1.action="PRbrief_evalEdit_new2.jsp";
	}

	if(empno =="" )
	{
	 	alert("Please input EMPNO/SERN!");
		document.form1.empno.focus();
		return false;
	 }

	 if(sdate =="")
	 {
	 	alert("Please input the flt date!!");
		document.form1.sdate.focus();
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
<form method="post" name="form1" target="mainFrame" class="txtblue" onsubmit="return chkRequest();">
<span class= "txtblue">(�ȿ��g�z����²���A¾�ʵ��q)</span> 
<span class= "txtblue">EMPNO/SERN : </span> <input type="text" size="6" maxlength="6" name="empno"  id="empno" class="txtblue">&nbsp;&nbsp;
<span class= "txtblue">Flt Date :</span>  
	<input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue"> 			
	<img height="20" src="../images/p2.gif" width="20" onClick ="cal1.popup();"> 
	 <span class="red">*�榡�Gyyyy/mm/dd�C</span> &nbsp;&nbsp;
<input name="Submit" type="submit" class="txtblue" value="NEXT"  > 
<input name="btn" type="button" value="Reset" OnClick="document.form1.Submit.disabled=0">
</form>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['sdate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	document.getElementById("sdate").value =cal1.gen_date(new Date());
</script>
</body>
</html>