<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*"%>

<html>
<head>
<title>�d�߲խ��Z��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../style2.css">
<link rel="stylesheet" type="text/css" href="../swap3ac/swap.css">
<script language="JavaScript" type="text/JavaScript">

function getdate(){	//�]�w���w�]��
	nowdate = new Date();	//�{�b�ɶ�

	var y,m,d
	y = nowdate.getYear();
	m = nowdate.getMonth()+1;
	d = nowdate.getDate();

	
	if ( d >= 25 ) {			//�Y�W�L25���A�w�]���U�Ӥ몺�Z��
		if ( m == 12){
			y = y + 1;
			m = 0;		//�Y��12/25�A�h�~���[1
		}
		m = m + 1;
	}
	document.form1.year.value = y;
	
	if (m < 10)	{		//�Y���<10�A�h�e���[�@��0
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
<form name="form1" method="post" action="crewSkj2.jsp" target="mainFrame" onSubmit="return checkBlank('form1','empno','�п�J���u��')">
  <select name="year">
     <jsp:include page="../../temple/year.htm" />
  </select>
    
  <select name="month">

	<jsp:include page="../temple/month.htm" />

  </select>
  EMPNO:  <input type="text" name="empno" size="6" maxlength="6">
  <input type="submit" name="Submit" value="Query" class="e">
  <span class="txtblue">&nbsp;&nbsp;*�d�߲խ��Z��</span> 
</form>
</body>
</html>
