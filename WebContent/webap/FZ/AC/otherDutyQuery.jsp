<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>查詢OFF/METTING任務</title>
<link rel="stylesheet" type="text/css" href="validator.css">
<link rel="stylesheet" type="text/css" href="../kbd.css">
<link rel="stylesheet" type="text/css" href="swapArea.css">

<script language="javascript" type="text/javascript" src="calendar2.js"></script>
<script language="javascript" type="text/javascript" src="validator.js"></script>
<script language="javascript" type="text/javascript">
function showSel(str){
var showHTML;
	if(str =="1"){	//flight number
		showHTML = "1.<input type=\"text\" name=\"fltno\" size=\"4\" maxlength=\"5\">&nbsp;2.<input type=\"text\" name=\"fltno\" size=\"4\" maxlength=\"5\">&nbsp;3.<input type=\"text\" name=\"fltno\" size=\"4\" maxlength=\"5\">";		
		showHTML += "&nbsp;最多可輸入三個班號";
		document.getElementById("selOptionDIV").innerHTML=showHTML;
		document.form1.fltno[0].focus();
	}else if(str == "2"){	//special flight

		showHTML = "<select name=\"spcialFlight\"><option value=\"1\">媽媽班 (004/006/008/032) </option><option value=\"2\">大長班 (012/063/065/067) </option></select>";
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
	if (m < 10)	{		//若月份<10，則前面加一個0
		m= "0"+ m;
	}
	
	if (d < 10)	{		//若day<10，則前面加一個0
		d = "0"+d;
	}	
   document.getElementById("sdate").value=y+"/"+m+"/"+d;


}

//validator form
var a_fields = {
'sdate' : {'l': 'From', 'r': true,'f': 'date', 't': 'sText'}	,
'type': {'l':'查詢條件','r': true, 't': 'typeText'}
	
}
o_config = {
	'to_disable' : ['submit'],
	'alert' : 1
}
var v = new validator('form1', a_fields, o_config);

function chkForm(){
	if( v.exec()){
		document.getElementById("showStatus").className="showStatus";
		return true;
	}else{
		return false;
	}
}


function showSel(str){
var showHTML;
	if(str =="1"){	// 休假
		<%
//		<option value='0' >ALL ( F. C. Y )</option>

// PR or 管理者可看到PR的選項
String prRank="";
if("PR".equals((String)session.getAttribute("occu")) || "Y".equals((String)session.getAttribute("powerUser"))){
	prRank="<option value='3'>座艙長 (PR) </option>";
}
		%>
		showHTML ="<select name='occu'><%=prRank%><option value='1' >高艙等 ( F. C ) </option><option value='2'>經濟艙 ( Y ) </option></select>";
		document.getElementById("selOptionDIV").innerHTML=showHTML;
		document.getElementById("selOptionDIV").style.display="";
		
	}else{
		document.getElementById("selOptionDIV").innerHTML="";
		document.getElementById("selOptionDIV").style.display="none";
	}
}
</script>
</head>

<body onLoad="getdate();showSel('');">
<div id="showStatus" class="hiddenStatus">loading...</div>

<form name="form1" action="otherDuty.jsp" method="post" target="mainFrame" onSubmit="return chkForm()">
<select name="type" id="type" onChange="showSel(this.value)" >
	<option value="" id="typeText" selected>*** 選擇查詢條件 ***</option>
  	<option value="1">休假 ( OFF. ADO ) </option>
	<option value="2">上課 ( R1. R2. R3. R4. R5 ) </option>
	<option value="3">開會 ( MT ) </option>
	<option value="4">會議 ( EF ) </option>
	<option value="5">公假 ( BL ) </option>
</select>
 <div id="selOptionDIV" style="display:none; " ></div>

<div id="sText">Date</div>
<input name="sdate" id="sdate" type="text" size="10" maxlength="10"  onClick="cal1.popup();">
           <img src="img/cal.gif" width="16" height="16" onClick="cal1.popup();">&nbsp;&nbsp;
           <div id="selOptionDIV" ></div> 
<input name="submit" type="submit" id="submit" class="kbd" value="Query" >
  
</form>
</body>
</html>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.form1.elements['sdate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	
</script>	