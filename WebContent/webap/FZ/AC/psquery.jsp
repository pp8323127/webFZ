<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date"%>
<%//�d�ߥL�H��X�Z��%>
<html>
<head>
<title>Put Schedule Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="../menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">


function getdate(){	//�]�w���w�]��
	nowdate = new Date();	//�{�b�ɶ�

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
function chkForm(){
	if(document.getElementById("sdate").value==""){
		alert("�п�ܶ}�l���");
		return false;
	}else if(document.getElementById("edate").value==""){
		alert("�п�ܵ������");
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
<span class="txtblue">�d�ߤ��
  <input name="sdate" id="sdate" type="text" size="10" maxlength="10"  onClick="cal1.popup();">
           <img src="img/cal.gif" width="16" height="16" onClick="cal1.popup();">~
           <input name="edate" id="edate" type="text" size="10" maxlength="10"  onClick="cal2.popup();">
           <img src="img/cal.gif" width="16" height="16" onClick="cal2.popup();">  Flight
  Number
  <input name="fltno" type="text" size="10">
  <input type="submit" name="Submit" value="Query" class="btm">
  &nbsp;&nbsp;*�H�_������ί�Z���d�ߥ�Z�Z��</span> 
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