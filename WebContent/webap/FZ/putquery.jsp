<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date"%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">

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
		document.form1.pyy.value = y;
	
	if (m < 10)	{		//若月份<10，則前面加一個0
		document.form1.pmm.value= "0"+ m;
	}
	else {
		document.form1.pmm.value=m;
	}

}

function checkdate(){
	nowdate = new Date();	//現在時間
	selDate = new Date();	//選擇時間
	var sely ,selm;
	sely = form1.pyy.value;
	selm = parseInt(form1.pmm.value)-1 ;
	selDate.setFullYear(sely);
	selDate.setMonth(selm);
	/*if (selDate < nowdate){
		alert("系統僅提供查詢當月及下月班表，請重新查詢！！\n\nYou cannot query the schedule before. Please select another date!");
		location.reload();
		return false;
	}
	else{
		return true;
	}*/
}

</script>

</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="getdate()">
<form name="form1" method="post" action="dutyput.jsp" target="mainFrame" onSubmit="return checkdate()">
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
  <input type="submit" name="Submit" value="Query" class="btm">
  <span class="txtblue">&nbsp;&nbsp;*查詢月班表以Trip Number顯示 </span> 
</form>
</body>
</html>
