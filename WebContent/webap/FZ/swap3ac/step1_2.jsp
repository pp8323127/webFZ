<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%

//2011/12/07 因失常單 新增
response.setHeader("Pragma","no-cache"); 
response.setHeader("Cache-Control","no-cache"); 
response.setDateHeader("Expires", 0); 
//2011/12/07 因失常單 新增

//String aEmpno = request.getParameter("userid");
String aEmpno = (String)session.getAttribute("userid");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>AirCrews版換班申請Step1</title>
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<script language="javascript" type="text/javascript" src="../js/checkBlank.js"></script>
<link href="swap.css" rel="stylesheet" type="text/css">
<style type="text/css">
body,input,select{
	font-family: Verdana;
	font-size: 10pt;
}
.e {
	background-color: #eeeeee;
	border-right: 1pt solid #666666;
	border-bottom: 1pt solid #666666;
	border-left: 1pt solid #cccccc;
	border-top: 1pt solid #cccccc;
}
.e4 {
	background-color: #edf3fe;
	color: #000000;
	text-align: center;
}

</style>
</head>

<body onLoad="document.form1.rEmpno.focus();showYM('form1','year','month')" >
<span style="color:red;text-align:left;font-family:Verdana;font-size:10pt;background-color:#CCFFFF;padding:2pt;">Step1.輸入申請月份與被換者之員工號</span>
<form name="form1" action="step1_3.jsp" method="post" onsubmit="return checkBlank('form1','rEmpno','Please insert the EmployID of replacer.\n請輸入被換者員工號!!')">
  <p>
    <select name="year">
	  <%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=Integer.parseInt(dateFmY.format(curDate));i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
  %>	  
    </select>
  
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
</p>
  <p><br>
    被換者員工號：
    <input type="text" name="rEmpno" size="6" maxlength="6"  onfocus="this.select()"> 
</p>
  <p>      <input type="submit" class="e4"  value="Next">
    <input type="reset" class="e" value="Reset">
	<input type="hidden" name="aEmpno" value="<%=aEmpno%>">
  </p>
</form>
</body>
</html>
