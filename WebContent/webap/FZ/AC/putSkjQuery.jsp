<%@page contentType="text/html; charset=big5" language="java" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>�����Z��d��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="swapArea.css" type="text/css">
<link rel="stylesheet" type="text/css" href="../kbd.css">
<script language="JavaScript" type="text/JavaScript">

function getdate(){	//�]�w���w�]��
	nowdate = new Date();	//�{�b�ɶ�

	var y,m,d
	y = nowdate.getFullYear();
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

</head>
<body  onLoad="getdate()">
<form name="form1" method="post" action="putSkj.jsp" target="mainFrame">
<span class="red">[�����Z��d��]</span>&nbsp;&nbsp;�~/��
  <select name="year">
<%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=Integer.parseInt(dateFmY.format(curDate))-1;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
  %>	
  </select>
    
  <select name="month" >
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
  <input name="Submit" type="submit" class="kbd" value="Query" >
  
</form>
</body>
</html>
