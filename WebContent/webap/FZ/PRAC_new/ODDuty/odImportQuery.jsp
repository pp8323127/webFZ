<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.util.GregorianCalendar"  %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} else{




%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../ZC/style.css">
<title>OD Duty Import Query</title>

<script language="javascript" type="text/javascript">
function showPreMonth(){
<%
java.util.GregorianCalendar cal = new java.util.GregorianCalendar();
cal.add(java.util.Calendar.MONTH, -1);

%>
	document.form1.year.value = '<%=(new java.text.SimpleDateFormat("yyyy")).format(cal.getTime())%>';
	document.form1.month.value = '<%=(new java.text.SimpleDateFormat("MM")).format(cal.getTime())%>';
}
</script>
</head>
<body onLoad="showPreMonth();">
<form name="form1" action="odImport.jsp" method="post" target="mainFrame" >
<span class="r">[OD Duty Import ]</span>
  <select name="year"  id="year">
<%

cal.add(java.util.Calendar.MONTH, +1);
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");

for(int i=Integer.parseInt(dateFmY.format(cal.getTime()))-1;i<=Integer.parseInt(dateFmY.format(cal.getTime()));i++){
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
<input name="Submit" type="submit" value="匯入" >
<span class="r">*請選擇資料匯入年/月</span>

</form>
</body>
</html>
<%
}
%>