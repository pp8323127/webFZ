<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date"%>
<%
/*
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} */
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�H�e�Z��</title>
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/javascript">


function getdate(){	//�]�w���w�]��
	nowdate = new Date();	//�{�b�ɶ�
	var y,m
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
	form1.sely.value = y;
	
	if (m < 10)	{		//�Y���<10�A�h�e���[�@��0
		form1.selm.value= "0"+ m;
	}
	else {
		form1.selm.value=m;
	}

}

</script>
</head>

<body onLoad="getdate()">
<form name="form1" method="post" action="mailsche_acttion.jsp" target="mainFrame">
  <select name="sely" class="t1">
    <option value="2003" selected>2003</option>
    <option value="2004">2004</option>
    <option value="2005">2005</option>

  </select> 
  <span class="txtblue">�~</span>  
  <select name="selm"  class="t1">

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

  <span class="txtblue">��</span>  
  <input type="submit" name="Submit" value="�H�X��Z��" class="btm">
</form>
</body>
</html>
