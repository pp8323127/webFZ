<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>100HrLog Query</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
</head>

<body onLoad="showYM('form1','year','month')">
<form name="form1" action="100HrLog.jsp" method="post" target="mainFrame">
<select name="year">
  <script language="javascript" type="text/javascript">
  	var nowDate = new Date();
  	for(var i=2005;i<= nowDate.getFullYear()+2;i++){
		document.write("<option value='"+i+"'>"+i+"</option>");
	}
  </script>

</select>
<select name="month">
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

<input name="Submit" type="submit" class="btm" value="Query">
<span class="txtblue">*依年、月查詢100Hrs Check使用記錄
</span>
</form>
</body>
</html>
