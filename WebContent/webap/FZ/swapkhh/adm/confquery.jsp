<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date"%>
<html>
<head>
<title>申請單查詢</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css">

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

</script>
<script language="javascript" type="text/javascript" src="calendar2.js"></script>
<script language="javascript" type="text/javascript" src="validator.js"></script>
</head>

<body onLoad="getdate()">
<form name="form1" method="post" action="conf_form.jsp" target="mainFrame" onSubmit="return v.exec();">
    <span >條件</span>  
    <select name="conf">
  	<option value="A">全部 All</option>
    <option value="Y">同意 Agree</option>
    <option value="N">退回 Regect</option>
  </select>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <span >類別</span>  
  <select name="cdate">
    <option value="C">處理 Check</option>
    <option value="A">申請 Apply</option>
  </select>&nbsp;&nbsp;
  <div  id="qdate"  style="display:inline; "> <span >日期</span></div>
  <input name="sdate" id="sdate" type="text" size="10" maxlength="10"  onClick="cal1.popup();"> 				
                <img src="img/cal.gif" width="16" height="16" onClick="cal1.popup();">
～<input name="edate" id="edate" type="text" size="10" maxlength="10" onClick="cal2.popup();"> 				
				<img src="img/cal.gif" width="16" height="16" onClick="cal2.popup();">&nbsp;&nbsp; <span >  EmpNo</span>
                <input type="text" name="empno" size="8" maxlength="6" >
  <input type="submit" name="Submit" id="submit" value="查詢" >
  *查詢<span class="r">KHH已處理</span>申請單 
</form>
</body>
</html>
<script language="javascript" type="text/javascript" src="../showAndHiddenButton.js"></script>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['sdate']);
	var cal2 = new calendar2(document.forms[0].elements['edate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	cal2.year_scroll = true;
	cal2.time_comp = false;

var a_fields = {
	'sdate' : {'l': '開始日期', 'r': true, 't': 'qdate'},
	'edate' : {'l': '結束日期', 'r': true, 't': 'qdate'}	
	
}
o_config = {	
	'alert' : 1
}
var v = new validator('form1', a_fields, o_config);

function chkForm(){
	if(v.exec()){
		
	}
}	
</script>
