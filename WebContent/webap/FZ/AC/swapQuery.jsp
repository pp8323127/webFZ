<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String userid = (String)session.getAttribute("userid");
if(userid == null){
response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else{
fz.writeLog wl = new fz.writeLog();
wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ1611");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�d�ߥi���Z��</title>
<link rel="stylesheet" type="text/css" href="validator.css">
<link rel="stylesheet" type="text/css" href="swapArea.css">
<link rel="stylesheet" type="text/css" href="../kbd.css">

<script language="javascript" type="text/javascript" src="calendar2.js"></script>
<script language="javascript" type="text/javascript" src="validator.js"></script>
<script language="javascript" type="text/javascript">
function showSel(str){
var showHTML;
	if(str =="1"){	//flight number
		showHTML = "1.<input type=\"text\" name=\"fltno\" size=\"4\" maxlength=\"5\">&nbsp;2.<input type=\"text\" name=\"fltno\" size=\"4\" maxlength=\"5\">&nbsp;3.<input type=\"text\" name=\"fltno\" size=\"4\" maxlength=\"5\">";		
		showHTML += "&nbsp;�̦h�i��J�T�ӯZ��";
		document.getElementById("selOptionDIV").innerHTML=showHTML;
		document.form1.fltno[0].focus();
	}else if(str == "2"){	//special flight

		showHTML = "<select name=\"spcialFlight\"><option value=\"1\">�����Z (004/006/008/032) </option><option value=\"2\">�j���Z (012/063/065/067) </option></select>";
		document.getElementById("selOptionDIV").innerHTML=showHTML;
	}else{
		document.getElementById("selOptionDIV").innerHTML="";
	}
}

function getdate(){	
	nowdate = new Date();
	var y,m,d
	y = nowdate.getFullYear();
	m = nowdate.getMonth()+1;
	d = nowdate.getDate();
	if (m < 10)	{		//�Y���<10�A�h�e���[�@��0
		m= "0"+ m;
	}
	
	if (d < 10)	{		//�Yday<10�A�h�e���[�@��0
		d = "0"+d;
	}	
   document.getElementById("sdate").value=y+"/"+m+"/"+d;
   document.getElementById("edate").value=y+"/"+m+"/"+d;

}

//validator form
var a_fields = {
'sdate' : {'l': 'From', 'r': true,'f': 'date', 't': 'sText'}	,
'edate' : {'l': 'To', 'r': true,'f': 'date', 't': 'eText'}	
	
}
o_config = {
	'to_disable' : ['submit'],
	'alert' : 1
}
var v = new validator('form1', a_fields, o_config);

function chkForm(){
var sel = document.getElementById("sel").value;
	if(sel =="1" && document.form1.fltno[0].value.length==0){
			document.getElementById("sel").options[1].style.color="red";
			alert("�ܤֻݿ�J�@�ӯ�Z���X");
			document.form1.fltno[0].focus();
			return false;		
	}else{
		//�ˬd���
		if( v.exec()){
			document.getElementById("showStatus").className="showStatus";
		}
	}
}
</script>

</head>

<body onLoad="getdate();showSel(document.getElementById('sel').value);">
<div id="showStatus" class="hiddenStatus">loading...</div>

<form name="form1" action="swapFlight.jsp" method="post" target="mainFrame" onSubmit="return chkForm()">
<div id="sText">From</div>&nbsp;
  <input name="sdate" id="sdate" type="text" size="10" maxlength="10"  onClick="cal1.popup();">
           <img src="img/cal.gif" width="16" height="16" onClick="cal1.popup();">&nbsp;&nbsp;<div id="eText" >To</div>&nbsp;
           <input name="edate" id="edate" type="text" size="10" maxlength="10"  onClick="cal2.popup();">
           <img src="img/cal.gif" width="16" height="16" onClick="cal2.popup();"> 
<select name="occu">
  	<option value="0" >ALL ( F. C. Y )</option>
	<option value="1">������ ( F. C ) </option>
	<option value="2" >�g�ٿ� ( Y ) </option>
	<option value="3" >Zone Chief ( ZC ) </option>
</select>

  <select name="sel" id="sel" onChange="showSel(this.value)" >
  	<option value="0">�Z���d�߱���</option>
  	<option value="1">Flight Number</option>
  	<option value="2">Special Flight</option>
  </select>
  <div id="selOptionDIV" ></div> 
<input name="submit" type="submit" class="kbd" id="submit" value="Query" >
  
</form>
</body>
</html>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.form1.elements['sdate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	var cal2 = new calendar2(document.form1.elements['edate']);
	cal2.year_scroll = true;
	cal2.time_comp = false;
	
</script>	
<%
}
%>