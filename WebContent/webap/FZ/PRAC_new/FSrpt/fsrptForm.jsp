<%@ page contentType="text/html; charset=big5" language="java" import="java.util.*,java.io.*,fsrpt.*" %>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
*/

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../sendredirect.jsp");
} 

FSRpt fsr = new FSRpt();
fsr.getFSSubjectItem();
ArrayList objAL = new ArrayList();
objAL= fsr.getObjAL();

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="Javascript" src="../../../js/FieldTools.js"></script>
<link rel ="stylesheet" type="text/css" href="../../../style/checkStyle1.css">
<link rel ="stylesheet" type="text/css" href="../../../style/btn.css">
<script language="JavaScript" src="calendar2.js" ></script>

<script language="JavaScript" type="text/JavaScript">
function setacno()
{
	var actp = document.form1.actp.value;
	var obj=document.getElementById('acno');
	var count = obj.options.length;
    for(var i = 0;i<count;i++)
    {
		   obj.options.remove(0);
    }

	if(actp=="744")
	{
		obj.add(new Option("B18201","B18201")); 
		obj.add(new Option("B18202","B18202")); 
		obj.add(new Option("B18203","B18203")); 
		obj.add(new Option("B18205","B18205")); 
		obj.add(new Option("B18206","B18206")); 
		obj.add(new Option("B18207","B18207"));
		obj.add(new Option("B18208","B18208")); 
		obj.add(new Option("B18251","B18251")); 
		obj.add(new Option("B18210","B18210")); 
		obj.add(new Option("B18211","B18211")); 
		obj.add(new Option("B18212","B18212")); 
		obj.add(new Option("B18215","B18215")); 
		obj.add(new Option("N168CL","N168CL")); 
	}
	if(actp=="738")
	{
		 obj.add(new Option("B18601","B18601")); 
		 obj.add(new Option("B18605","B18605")); 
		 obj.add(new Option("B18606","B18606")); 
		 obj.add(new Option("B18607","B18607")); 
		 obj.add(new Option("B18608","B18608")); 
		 obj.add(new Option("B18609","B18609")); 
		 obj.add(new Option("B18610","B18610")); 
		 obj.add(new Option("B18612","B18612")); 
		 obj.add(new Option("B18615","B18615")); 
		 obj.add(new Option("B18617","B18617")); 



	}
	if(actp=="343")
	{
		 obj.add(new Option("B18801","B18801")); 
		 obj.add(new Option("B18802","B18802")); 
		 obj.add(new Option("B18803","B18803")); 
		 obj.add(new Option("B18805","B18805")); 
		 obj.add(new Option("B18806","B18806")); 
		 obj.add(new Option("B18807","B18807")); 
	}
	if(actp=="333")
	{
		 obj.add(new Option("B18301","B18301")); 
		 obj.add(new Option("B18302","B18302")); 
		 obj.add(new Option("B18303","B18303")); 
		 obj.add(new Option("B18305","B18305")); 
		 obj.add(new Option("B18306","B18306")); 
		 obj.add(new Option("B18307","B18307")); 
		 obj.add(new Option("B18308","B18308")); 
		 obj.add(new Option("B18309","B18309")); 
		 obj.add(new Option("B18351","B18351")); 
		 obj.add(new Option("B18352","B18352")); 
		 obj.add(new Option("B18353","B18353")); 
		 obj.add(new Option("B18310","B18310")); 
		 obj.add(new Option("B18311","B18311")); 
		 obj.add(new Option("B18312","B18312")); 
		 obj.add(new Option("B18315","B18315")); 
		 obj.add(new Option("B18316","B18316")); 
		 obj.add(new Option("B18317","B18317")); 
	}
}

function chk_form()
{
	var eventdate = document.form1.eventdate.value;
	var subject = document.form1.subject.value;
	var desc = document.form1.desc.value;
	var cons = document.form1.cons.value;

	if(eventdate == "" )
	{
		alert("Please input Event/Flight date!!");
		return false;
	}

	if(subject == "" )
	{
		alert("Please input subject!!");
		return false;
	}
	if(desc == "" )
	{
		alert("Please input Description!!");
		return false;
	}
	if(cons == "" )
	{
		alert("Please input Potential Consequence!!");
		return false;
	}

	flag = confirm("確定送出報告嗎?");
	
	if (flag) 
	{
		document.form1.Submit.disabled=1;	
		return true;
	}
	else
	{
		document.form1.Submit.disabled=0;	
		return false;
	}
}
</script>
<style type="text/css">
<!--
.style1 {font-family: Arial, Helvetica, sans-serif}
.style2 {color: #0000FF}
-->
</style>
</head>
<body>
<form name="form1" method="post" action="insFsrptForm.jsp" onsubmit="return chk_form();">
<div align="center">
	<h2><span class="style1">Hazard Report</span></h2>
</div>
<table width="95%"  border="0" align="center" >
  <tr>
	<td align="center" valign='bottom' class="txtxred">Basic Information</td>
  </tr>
</table>

<table width="95%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20%" class="tablehead"><span class="txtxred">*</span>Event/Flight Date</td>
	<td width="20%"><input name="eventdate" id="eventdate" type="text" size="10" maxlength="10"> 
	<img src="../../../FZ/images/p2.gif" width="22" height="22"  onClick="cal1.popup();"></td>
	<td width="12%" class="tablehead">Flight No.</td>
	<td width="14%">
	<select name="carrier" id="carrier" class="txtblue">
	<option value="" selected></option>
	<option value="CI">CI</option>
	<option value="AE">AE</option>
	</select>
	<input name="fltno" id="fltno" type="text" size="5" maxlength="5"></td>
	<td width="20%" class="tablehead">Sector</td>
	<td width="14%"><input name="dpt" id="dpt" type="text" size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();">/
		<input name="arv" id="arv" type="text" size="3" maxlength="3" onkeyup= "javascript:this.value=this.value.toUpperCase();"></td>
  </tr>
  <tr>
    <td class="tablehead">A/C Type</td>
	<td><select name="actp" id="actp" onchange="setacno();">
		<option value=""></option>
		<option value="744">744</option>
		<option value="738">738</option>
		<option value="343">343</option>
		<option value="333">333</option>
		</select>
	</td>
	<td class="tablehead">A/C No.</td>
		<option value=""></option>
	<td>
		<select name="acno" id="acno" class="txtblue">
		     <option value="" selected></option>
		</select>
	</td>
	<td class="tablehead">Reply Requested</td>
	<td><select name="rly" id="rly">
		<option value="Y" selected>Yes</option>
		<option value="N">No</option>
		</select>
	</td>
  </tr>
</table>
<table width="95%"  border="0" align="center" >
  <tr>
	<td align="center" valign='bottom' class="txtxred">*Subject</td>
  </tr>
</table>

<table width="95%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center">
	<select name="subject" id="subject">
<%
	for(int i=0; i<objAL.size(); i++)
	{
		FSSubjectItemObj obj = (FSSubjectItemObj) objAL.get(i);
%>
	<option value="<%=obj.getSubject()%>"><%=obj.getSubject()%></option>
<%
	}	
%>
	</select>
	</td>
  </tr>
</table>

<table width="95%"  border="0" align="center" >
  <tr>
	<td align="center" valign='bottom' class="txtxred">*Description</td>
  </tr>
</table>

<table width="95%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><textarea name="desc" id="desc" cols="80" rows="5"></textarea></td>
  </tr>
</table>

<table width="95%"  border="0" align="center" >
  <tr>
	<td align="center" valign='bottom' class="txtxred">*Potential Consequence(潛在發生結果)</td>
  </tr>
</table>

<table width="95%"  border="1" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><textarea name="cons" id="cons" cols="80" rows="5"></textarea></td>
  </tr>
</table>
<table width="95%"  border="0" align="center" >
  <tr>
	<td align="center" class="txtblue">
    <input type="submit" name="Submit" value="Send (送出)" class="addButton">&nbsp;&nbsp;&nbsp;
	<input name="reset" type="reset" value="Reset (清除重寫)">
	</td>
  </tr>
</table>
</form>
<body>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['eventdate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
</script>
