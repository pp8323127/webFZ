<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Aircrews3次換班申請Step1</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
</head>

<body  >
<div style="color:red;text-align:left;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;">
AirCrews三次換班測試&nbsp;Step1.輸入申請月份、申請者與被換者之員工號</div>
<form name="form1" action="step2.jsp" method="post">
  <p>
    <select name="year">
	   <option value="2007" >2007</option>
    </select>
  
  <select name="month">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06" selected>06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
    </select>
</p>
  <p>申請者員工號：
    <input type="text" name="aEmpno" size="6" maxlength="6" onfocus="this.select()"> 
    <br>
    被換者員工號：
    <input type="text" name="rEmpno" size="6" maxlength="6" onfocus="this.select()"> 
</p>
  <p>
    <input type="submit"  value="Next">
    <input type="reset" value="Reset">
  </p>
</form>
</body>
</html>
