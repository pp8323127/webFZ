<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date"%>
<html>
<head>
<title>�ӽг�d��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css">

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

</script>
<script language="javascript" type="text/javascript" src="calendar2.js"></script>
<script language="javascript" type="text/javascript" src="validator.js"></script>
</head>

<body onLoad="getdate()">
<form name="form1" method="post" action="conf_form.jsp" target="mainFrame" onSubmit="return v.exec();">
    <span >����</span>  
    <select name="conf">
  	<option value="A">���� All</option>
    <option value="Y">�P�N Agree</option>
    <option value="N">�h�^ Regect</option>
  </select>
  &nbsp;&nbsp;&nbsp;&nbsp;
  <span >���O</span>  
  <select name="cdate">
    <option value="C">�B�z Check</option>
    <option value="A">�ӽ� Apply</option>
  </select>&nbsp;&nbsp;
  <div  id="qdate"  style="display:inline; "> <span >���</span></div>
  <input name="sdate" id="sdate" type="text" size="10" maxlength="10"  onClick="cal1.popup();"> 				
                <img src="img/cal.gif" width="16" height="16" onClick="cal1.popup();">
��<input name="edate" id="edate" type="text" size="10" maxlength="10" onClick="cal2.popup();"> 				
				<img src="img/cal.gif" width="16" height="16" onClick="cal2.popup();">&nbsp;&nbsp; <span >  EmpNo</span>
                <input type="text" name="empno" size="8" maxlength="6" >
  <input type="submit" name="Submit" id="submit" value="�d��" >
  *�d��<span class="r">KHH�w�B�z</span>�ӽг� 
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
	'sdate' : {'l': '�}�l���', 'r': true, 't': 'qdate'},
	'edate' : {'l': '�������', 'r': true, 't': 'qdate'}	
	
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
