<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,java.util.GregorianCalendar"  %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (sGetUsr == null) {		//check user session start first or not login
	response.sendRedirect("../sendredirect.jsp");
} 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>班表查詢</title>
<link href="style2.css" rel="stylesheet" type="text/css">

<link href="style.css" rel="stylesheet" type="text/css">
</head>
<%
//今年跟去年
GregorianCalendar currentDate = new GregorianCalendar();
int thisYear = currentDate.get(GregorianCalendar.YEAR);
int month = currentDate.get(GregorianCalendar.MONTH) + 1;
String mymonth = String.valueOf(month);
if(month < 10) mymonth = "0" + mymonth;

String actionPage = "fltInfo_2.jsp";
%>
<script language="javascript">
function showDate(){
	document.getElementById("yyyy").value="<%=thisYear%>";
	document.getElementById("mm").value="<%=mymonth%>";
}
function goPage(){
var nowDa = new Date();
var thisDay = nowDa.getDate();
	var yy = document.getElementById("yyyy").value;
	var mm = document.getElementById("mm").value;
	//alert(yy+""+mm);
		
	if((yy == 2014 ) && ( mm  < 11 )){
		alert("New Format is Start from 2014/11/01");
		document.form1.action="fltInfo.jsp";		
		return false;
	}else{
		document.form1.action="<%=actionPage%>";
		return true;
	}
	
}
</script>
<body onLoad="showDate();getGdYear()">
<form name="form1" action="<%=actionPage%>" method="post" target="mainFrame" onsubmit="return goPage()" >
<span class="txtblue">yyyy</span>
<select name="yyyy" class="txtblue" id="yyyy">
 <script language="javascript" type="text/javascript">
  	var nowDate = new Date();
  	for(var i=2014;i<= nowDate.getFullYear()+2;i++){
		document.write("<option value='"+i+"'>"+i+"</option>");
	}
  </script>
</select>
/ 
<span class="txtblue">mm</span>
<select name="mm" class="txtblue" onChange="getGdYear()" id="mm">
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
  <input name="Submit" type="submit" class="txtblue" value="Query" >
</form>
</body>
</html>
