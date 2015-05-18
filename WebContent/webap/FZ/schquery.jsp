<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="al.*,java.sql.*, java.util.Date"%>

<html>
<head>
<title>Schedule Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/javascript">


function getdate(){	//設定選單預設值
	nowdate = new Date();	//現在時間
	var y,m,d
	y = nowdate.getFullYear();
	m = nowdate.getMonth()+1;
	d = nowdate.getDate();

	
	if ( d >= 25 ) {			//若超過25號，預設為下個月的班表
		if ( m == 12){
			y = y + 1;
			m = 0;		//若為12/25，則年份加1
		}
		m = m + 1;
	}
	document.form1.syear.value = y;
	
	if (m < 10)	{		//若月份<10，則前面加一個0
		document.form1.smonth.value= "0"+ m;
	}
	else {
		document.form1.smonth.value=m;
	}

}


function checkm(){
var y,m;
var sel_y,sel_m;
sel_y = parseInt(form1.syear.value);
sel_m = parseInt(form1.smonth.value);
 nowdate = new Date();
 y = nowdate.getFullYear();
 m = nowdate.getMonth() + 1;
	if (sel_y <= y && sel_m < m){ 
		alert("僅能查詢當月及下月班表，請重新查詢！！");
		location.reload();
		return false;
	}
	else	{
		if (document.form1.fform.value == "L")
		{
			document.form1.action = "showsche2.jsp";
		}
		else
		{
			document.form1.action = "showsche.jsp";
		}
		return true;
	
	}
}

</script>
<style type=text/css>
<!--
BODY{margin:0px;/*內容貼緊網頁邊界*/}
-->
</style>
</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="getdate()">
<form name="form1" method="post" target="mainFrame" action="showsche2.jsp">
  <select name="syear" class="t1">

      <option value="2003">2003</option>
      <option value="2004">2004</option>
      <option value="2005">2005</option>
      <option value="2006">2006</option>
    </select>
    
  <select name="smonth"  class="t1">

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
  <!--<select name="fform" class="t1">
    <option value="L">Landscape</option>
    <option value="P">Portrait</option>
  </select>-->
  <font color="#000099"><b><font face="Arial, Helvetica, sans-serif" size="2">EmpNo/SerNo</font></b></font>
<input type="text" name="empno" size="10" maxlength="10" class="t1">
  <input type="submit" name="Submit" value="Query" class="btm">
  <span class="txtblue">*不輸入員工號：查詢自己班表&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;輸入員工號：可查詢其他組員班表</span> 
</form>
</body>
</html>
