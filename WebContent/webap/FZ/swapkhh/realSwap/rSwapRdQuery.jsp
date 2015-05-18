<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>實體換班記錄查詢</title>
<link href="../style/kbd.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="realSwap.css" >

<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>

</head>

<body onLoad="showYM('form1','year','month')">
<form name="form1" action="rSwapRd.jsp" method="post" target="mainFrame">
KHH實體換班記錄查詢[年/月] 
 <select name="year">
	  <%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=Integer.parseInt(dateFmY.format(curDate))-1;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
  %>	</select>
  /
  <select name="month">
      <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05" >05</option>
      <option value="06" >06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
</select>
  EMPNO
  <input type="text" name="empno" size="6" maxlength="6"> 
<input type="submit" class="kbd" value="Query">
*若不輸入員工號，則顯示全月資料
</form>
</body>
</html>
