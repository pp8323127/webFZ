<%@ page contentType="text/html; charset=big5" language="java" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Credit Query</title>
<link href = "../menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function showdate()
{
	var nowdate = new Date();
	var y,m;
	y = nowdate.getFullYear();
	m = nowdate.getMonth();
	if (m==0){m=12;y=y-1;}
	document.getElementById("fyy").value=y;
	if(m < 10 )	{document.getElementById("fmm").value="0"+m;	}
		else{document.getElementById("fmm").value=m;}
}
</script>

</head>
<body onLoad="document.getElementById('empno').focus();showdate();">
<form name="form1"  action="pickskjList3.jsp" method="post" target="mainFrame" class="txtblue">
(選班申請單歷史記錄查詢) EmpNo/SerNo&nbsp;&nbsp;<input type="text" size="6" maxlength="6" name="empno"  id="empno" class="txtblue">&nbsp;&nbsp;or &nbsp;&nbsp; 
  <select name="fyy" class="txtblue">
<option value="<%=java.util.Calendar.getInstance().get(Calendar.YEAR)-1%>"><%=java.util.Calendar.getInstance().get(Calendar.YEAR)-1%></option>
<option value="<%=java.util.Calendar.getInstance().get(Calendar.YEAR)%>" selected><%=java.util.Calendar.getInstance().get(Calendar.YEAR)%></option>  
<option value="<%=java.util.Calendar.getInstance().get(Calendar.YEAR)+1%>"><%=java.util.Calendar.getInstance().get(Calendar.YEAR)+1%></option>    </select>
  <select name="fmm" class="txtblue" >
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
    
  <select name="status" class="txtblue" >
    <option value="A">申請</option>
    <option value="H">處理</option>
  </select>
<input name="Submit" type="submit" class="txtblue" value="Query"  > 
</form>
</body>
</html>
