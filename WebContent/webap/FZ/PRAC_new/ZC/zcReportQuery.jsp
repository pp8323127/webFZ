<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.util.GregorianCalendar"  %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	//response.sendRedirect("../sendredirect.jsp");
} 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="style.css">
<title>事務長 任務查詢</title>

<script language="javascript" type="text/javascript" src="../../js/showDate.js"></script>
</head>
<body onLoad="showYM('form1','year','month')">
<form name="form1" action="zcRepostList.jsp" method="post" target="mainFrame" >
[任務顯示]
  <select name="year"  id="year">
<%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=2007;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
 %>	  
</select>
/ 
<select name="month"   id="month">
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
<input name="Submit" type="submit" value="查詢" >
<span class="r">*選擇年/月查詢
</span>
</form>
</body>
</html>
