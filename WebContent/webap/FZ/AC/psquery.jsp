<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date"%>
<%//查詢他人丟出班表%>
<html>
<head>
<title>Put Schedule Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="../menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">


function getdate(){	//設定選單預設值
	nowdate = new Date();	//現在時間

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
   document.getElementById("edate").value=y+"/"+m+"/"+d;


}
function chkForm(){
	if(document.getElementById("sdate").value==""){
		alert("請選擇開始日期");
		return false;
	}else if(document.getElementById("edate").value==""){
		alert("請選擇結束日期");
		return false;
	
	}else{
		return true;
	}
}

</script>
<script language="javascript" type="text/javascript" src="calendar2.js"></script>


</head>

<body onLoad="getdate()">
<form name="form1" method="post" action="psquery_action.jsp" target="mainFrame" onSubmit="return chkForm()" >
<span class="txtblue">查詢日期
  <input name="sdate" id="sdate" type="text" size="10" maxlength="10"  onClick="cal1.popup();">
           <img src="img/cal.gif" width="16" height="16" onClick="cal1.popup();">~
           <input name="edate" id="edate" type="text" size="10" maxlength="10"  onClick="cal2.popup();">
           <img src="img/cal.gif" width="16" height="16" onClick="cal2.popup();">  Flight
  Number
  <input name="fltno" type="text" size="10">
  <input type="submit" name="Submit" value="Query" class="btm">
  &nbsp;&nbsp;*以起迄日期或航班號查詢丟班班表</span> 
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