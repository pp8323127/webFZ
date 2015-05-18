<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>

<html>
<head>
<title>查詢組員班表</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../style2.css">
<link rel="stylesheet" type="text/css" href="../swap3ac/swap.css">
<script language="JavaScript" type="text/JavaScript">

function getdate(){	//設定選單預設值
	nowdate = new Date();	//現在時間

	var y,m,d
	y = nowdate.getYear();
	m = nowdate.getMonth()+1;
	d = nowdate.getDate();

	
	if ( d >= 25 ) {			//若超過25號，預設為下個月的班表
		if ( m == 12){
			y = y + 1;
			m = 0;		//若為12/25，則年份加1
		}
		m = m + 1;
	}
	document.form1.year.value = y;
	
	if (m < 10)	{		//若月份<10，則前面加一個0
		document.form1.month.value= "0"+ m;
	}
	else {
		document.form1.month.value=m;
	}

}


</script>
<script language="javascript" type="text/javascript" src="../js/checkBlank.js"></script>

</head>

<body  onLoad="getdate();document.form1.empno.focus()">
<form name="form1" method="post" action="crewSkj2.jsp" target="mainFrame" onSubmit="return checkBlank('form1','empno','請輸入員工號')">
  <select name="year">
     <jsp:include page="../../temple/year.htm" />
  </select>
    
  <select name="month">

	<jsp:include page="../temple/month.htm" />

  </select>
  EMPNO:  <input type="text" name="empno" size="6" maxlength="6">
  <input type="submit" name="Submit" value="Query" class="e">
  <span class="txtblue">&nbsp;&nbsp;*查詢組員班表</span> 
</form>
</body>
</html>
