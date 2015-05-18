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
</script>

<style type=text/css>
<!--
BODY{margin:0px;/*內容貼緊網頁邊界*/}
-->
</style>
</head>

<body bgcolor="#FFFFFF" text="#000000" onLoad="getdate()">
<form name="form1" method="post" target="mainFrame" action="showuploadfile.jsp">
  <select name="syear" class="t1">

	  <%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=Integer.parseInt(dateFmY.format(curDate))-1;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
  %>	    </select>
    
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
  <input type="submit" name="Submit" value="Query" class="btm">
  <span class="txtblue">*選擇欲下載換班限額表年/月</span> 
</form>
</body>
</html>
