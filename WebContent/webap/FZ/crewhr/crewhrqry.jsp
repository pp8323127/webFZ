<%@ page contentType="text/html; charset=big5" language="java" import="fz.*"  %>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //Check if logined
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();
//記錄寫進log
writeCRCLog wl = new writeCRCLog();
wl.updLog(sGetUsr, request.getRemoteAddr(), request.getRemoteHost(), "100Hrs Check","");


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>查飛時</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="JavaScript" type="text/JavaScript">
function check(){

var y,m;
var sel_y,sel_m;
sel_y = parseInt(document.form1.sel_year.value);
sel_m = parseInt(document.form1.sel_mon.value);
 nowdate = new Date();
 y = nowdate.getFullYear();
 m = nowdate.getMonth() + 1;
 if(document.form1.empno.value != ""){
 	document.form1.action = "crewhrdetail.jsp";
	document.form1.submit();
 }else
 {
	if (sel_y >= y && sel_m > m+1){ 
		alert("Select date error!!\n無法查詢未來資料!!");
		location.reload();
		return false;
	}
	/*else 	if (form1.sel_emp.value == ""){
		alert("Employee number must be insert!!\n請輸入員工號")
		document.form1.sel_emp.focus();
		return false;
	}*/
	else	{
		
		return true;
	
	}

}
	

}
function showdate(){

now = new Date();
var y,m,selm
y = now.getFullYear();
m = now.getMonth()+1;



	if(m < 10){
		document.form1.sel_mon.value="0"+m;
	}
	else	{
		document.form1.sel_mon.value=+m;
	}
document.form1.sel_year.value=y;

}

</script>

<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body onLoad="showdate()">

<form name="form1" method="post" action="crewhrlist.jsp" class="txtblue" target="mainFrame" onSubmit="return check()">
   <span class="txtxred">100Hrs Check LOC</span><span class="txtblue"> Year</span>  
   <select name="sel_year">
    <option value="2003">2003</option>
	<option value="2004">2004</option>
    <option value="2005">2005</option>
	<option value="2006">2006</option>
	<option value="2007">2007</option>
  </select>
  <span class="txtblue">Month</span>  
  <select name="sel_mon">
    <option value="01">01</option>
    <option value="02">02</option>
    <option value="03">03</option>
    <option value="04">04</option>
    <option value="05">05</option>
    <option value="06">06</option>
    <option value="07">07</option>
    <option value="08">08</option>
    <option value="09">09</option>
    <option value="10">10</option>
    <option value="11">11</option>
    <option value="12">12</option>
  </select>
  Fleet
  <select name="fleet" size="1">
	  <option value="" selected>ALL</option>
	  <option value="330">330</option>
	  <option value="343">343</option>
	  <option value="332">332</option>
	  <option value="738">738</option>
	  <option value="744">744</option>
	  <option value="747">747</option>
	  <option value="AB6">AB6</option>
  </select>
  Occu
  <select name="occu" size="1">
	  <option value="" selected>ALL</option>
	  <option value="CA">CA</option>
	  <option value="FO">FO</option>
	  <option value="FE">FE</option>
  </select>
  <input name="checkbk" type="checkbox" id="checkbk" value="Y" checked>
  BlkHr
  <select name="s_mark" id="s_mark">
    <option value="&gt;">&gt;</option>
    <option value="=">=</option>
    <option value="&lt;">&lt;</option>
  </select>
  <input name="s_num" type="text" id="s_num" value="30" size="5" maxlength="5">
  <span class="txtblue">  </span>
  Empno
  <input name="empno" type="text" id="empno" size="10" maxlength="6">
  <input name="Submit" type="submit" class="btm" value="Query">
  <input name="Submit2" type="button" class="btm" value="Reset" onClick="javascript:location.reload()">

</form>
</body>
</html>
