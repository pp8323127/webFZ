<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%
String userid = (String)session.getAttribute("userid");
if(userid == null){
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}else{
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>申請單狀態更新查詢</title>
<script type="text/javascript" language="javascript" src="../js/showDate.js"></script>
<link href="../style/kbd.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="../realSwap/realSwap.css">
<script language="javascript" type="text/javascript">
function chk(){
	var d = document.form1.num.value;
	if(d == ""){
		alert("請輸入單號!!");
		document.form1.num.focus()
		return false;
	}else{
		return true;
	}
}
</script>
</head>

<body onLoad="showYM('form1','year','month');document.form1.num.focus()">
<form  action="chgSwapFromList.jsp" method="post" name="form1" target="mainFrame" onsubmit="return chk()">
  [更新KHH申請單處理狀態]
	<select name="year">
	  <%
  java.util.Date curDate = java.util.Calendar.getInstance().getTime();
java.text.SimpleDateFormat dateFmY = new java.text.SimpleDateFormat("yyyy");
for(int i=Integer.parseInt(dateFmY.format(curDate))-1;i<=Integer.parseInt(dateFmY.format(curDate))+1;i++){
	out.print("<option value=\""+i+"\">"+i+"</option>\r\n");
}
  %>		</select>
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
	單號後四碼
	<input type="text" size="4" maxlength="4" name="num">
<input type="submit" class="kbd" value="QUERY">
<span class="r">*Step 1.選擇申請單之年/月/申請單號後四碼
</span>
</form>
</body>
</html>
<%
}
%>