<%@ page contentType="text/html; charset=big5" language="java"  %>
<%

String userid = (String)session.getAttribute("userid");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>三次班申請Step1</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<script language="javascript" type="text/javascript">

function chk(){
	var e = document.form1.rEmpno.value;
	if(e == ""){
		alert("請輸入被換者員工號，請重新輸入!!");
		document.form1.rEmpno.focus();
		return false;
	}else if(document.form1.rEmpno.value == "<%=userid%>"){
		alert("被換者員工號無效，請重新輸入!!");
		document.form1.rEmpno.focus();
		return false;
	}else{
		document.form1.submit.disabled=1;
		document.form1.reset.disabled=1;
		return true;
	}
}

function shownow(){
	nowdate = new Date();
	var y,m,d;
	y = nowdate.getFullYear() ;
	m = nowdate.getMonth()+1;
	d = nowdate.getDate();

	if (d >=25){  //超過25日，抓下一月
		if(m ==12){	//12月25，抓明年一月
			m = 0;
			y ++;
		}
		m = m+1;
	}
	
	if (m < 10) {
		document.form1.month.value = "0"+m;
	}
	else{
		document.form1.month.value = m;
	} 
	
		document.form1.year.value = y;
	

 }

</script>
<link href="swap.css" rel="stylesheet" type="text/css">
</head>

<body onLoad="document.form1.rEmpno.focus();shownow();">
<span class="m">換班申請Step1.輸入申請月份與被換者之員工號</span>
<form name="form1" action="step2.jsp" method="post" onsubmit="return chk();">
  <p>
    <select name="year">
      <option value="2005" >2005</option>
	  <option value="2006" >2006</option>	  
    </select>
  
  <select name="month">
      <option value="01" >01</option>
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
</p>
  <p>    被換者員工號：
    <input type="text" name="rEmpno" size="6" maxlength="6"  onfocus="this.select()"> 
</p>
  <p>      <input type="submit"  value="Next" name="submit" class="bt">
    <input type="reset" value="Clear" name="reset" class="bt2">
	
  </p>
</form>
</body>
</html>
