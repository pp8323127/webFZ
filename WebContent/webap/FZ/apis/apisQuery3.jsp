<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>APIS report Query</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {font-size: 18px}
-->
</style>
</head>
<script language="Javascript" src="calendar/FieldTools.js"></script>
<SCRIPT LANGUAGE="JavaScript">
function load()
{	
    today=new Date();
	var y, m, d;
	y = today.getFullYear() ;
	m = today.getMonth()+1;
	d = today.getDate(); 
		 
	strDate = Date.parse(y+"/"+m+"/"+d);
    strDate = parseInt(strDate, 10);
    strDate = strDate - 1*(24*60*60*1000);
    strDate = new Date(strDate);

	syy = strDate.getFullYear() ;
	smm = strDate.getMonth()+1;
	sdd = strDate.getDate();	

	if (smm < 10) 
	{
	   smm = '0'+smm;
	}

	if(sdd<10)
	{
	   sdd = '0'+sdd;
	}

	endDate = Date.parse(y+"/"+m+"/"+d);
    endDate = parseInt(endDate, 10);
	endDate = endDate + 1*(24*60*60*1000);
	endDate = new Date(endDate);

	eyy = endDate.getFullYear() ;
	emm = endDate.getMonth()+1;
	edd = endDate.getDate();	

	if (emm < 10) 
	{
	   emm = '0'+emm;
	}

	if(edd<10)
	{
	   edd = '0'+edd;
	}

	document.form1.sdt.value=syy+'/'+smm+'/'+sdd;
	document.form1.edt.value=eyy+'/'+emm+'/'+edd;
 }

function chk()
{
	var sdt =document.form1.sdt.value;
	var edt =document.form1.edt.value;

	if (sdt.length == 0) 
	{// blank
		alert(" Please input flight date!!");	
		document.form1.sdt.focus();
		return false;
	}

	if (edt.length == 0) 
	{// blank
		alert(" Please input flight date!!");	
		document.form1.edt.focus();
		return false;
	}

    document.form1.Submit.disabled=1;
	return true;
}

</SCRIPT>

<body onLoad="load();">
<form method="post" name="form1" target="mainFrame" class="txtblue" action="apisReport3.jsp" onsubmit = "chk();" >
APISIII Category
<select name="type">
	<option value="CR1" selected>CR1 (Pilot)</option>
	<option value="CR2">CR2 (Cabin crew)</option>
	<option value="CR3">CR3 (MGT/SFE)</option>
	<option value="CR4">CR4 (Non-Crew)</option>
	<option value="CR5">CR5 (Deadhead)</option>
	<option value="ALL">ALL</option>
</select>
Flight Date
<input name="sdt" type="text" size="10" maxlength="10"> 
<IMG onclick="Calendar('calendar/calendar.htm',sdt,event.screenX,event.screenY);" src="calendar/calendar.gif" align="absMiddle"><span class="style1"> ~
</span>
<input name="edt" type="text" size="10" maxlength="10"> 
<IMG onclick="Calendar('calendar/calendar.htm',edt,event.screenX,event.screenY);" src="calendar/calendar.gif" align="absMiddle"><span class="style39 style47">ex:2005/01/01</span>
<input name="Submit" type="submit" class="button6" value="Query" > 
&nbsp;&nbsp;<input name="btn" type="button" class="button6" value="Reset" OnClick="document.form1.Submit.disabled=0;" >
</form>
</body>
</html>
