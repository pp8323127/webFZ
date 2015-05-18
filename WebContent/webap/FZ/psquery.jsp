<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date"%>
<%//查詢他人丟出班表%>
<html>
<head>
<title>Put Schedule Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">


function getdate(){	//設定選單預設值
	nowdate = new Date();	//現在時間
	var y,m,d
	y = nowdate.getFullYear();
	m = nowdate.getMonth()+1;
	d = nowdate.getDate();

	
	document.form1.pyy.value = y;
	
	if (m < 10)	{		//若月份<10，則前面加一個0
		document.form1.pmm.value= "0"+ m;
	}
	else {
		document.form1.pmm.value=m;
	}
	if(d<10){
		document.form1.pdd.value="0"+d;
	}
	else{
		document.form1.pdd.value=d;
	}

}





</script>



</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="getdate()">
<form name="form1" method="post" action="psquery_action.jsp" target="mainFrame" >
  <select name="pyy" class="t1">
      <option value="2005">2005</option>
      <option value="2006">2006</option>
  </select>
    
  <select name="pmm" class="t1">
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
<select name="pdd" class="t1">
    <option value="N">ALL</option>
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
    <option value="13">13</option>
    <option value="14">14</option>
    <option value="15">15</option>
    <option value="16">16</option>
    <option value="17">17</option>
    <option value="18">18</option>
    <option value="19">19</option>
    <option value="20">20</option>
    <option value="21">21</option>
    <option value="22">22</option>
    <option value="23">23</option>
    <option value="24">24</option>
    <option value="25">25</option>
    <option value="26">26</option>
    <option value="27">27</option>
    <option value="28">28</option>
    <option value="29">29</option>
    <option value="30">30</option>
    <option value="31">31</option>
  </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <font size="2" face="Arial, Helvetica, sans-serif" color="#000099"><strong>Flight
  Number</strong></font>
  <input name="fltno" type="text" size="10">
  <input type="submit" name="Submit" value="Query" class="btm">
  <span class="txtblue">&nbsp;&nbsp;*以年月日或航班號查詢丟班班表</span> 
</form>
</body>
</html>
