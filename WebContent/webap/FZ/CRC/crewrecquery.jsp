<%@ page contentType="text/html; charset=big5" language="java"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //Check if logined
if ((sGetUsr == null) || (session.isNew()) )
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} 
%>
<html>
<head>
<title>Crew REC</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<script language="JavaScript" type="text/JavaScript">
function showdate(){
	var y,m;
	
	now = new Date();
	y = now.getFullYear();
	m = now.getMonth()+1;
	
		if(m < 10){
			document.form1.month.value="0"+m;
		}
		else	{
			document.form1.month.value=m;
		}
	document.form1.year.value=y;
}

</script>

<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body onLoad="showdate()">

<form name="form1" method="post" action="../../DF/accrec.jsp" class="txtblue" target="mainFrame">
   <span class="txtblue">Year</span>  
  <select name="year" id="year">
    <option value="2003">2003</option>
	<option value="2004">2004</option>
	<option value="2005">2005</option>
	<option value="2006">2006</option>
	<option value="2007">2007</option>
	<option value="2008">2008</option>
	<option value="2009">2009</option>
	<option value="2010">2010</option>
	<option value="2011">2011</option>
	<option value="2012">2012</option>
  </select>
  <span class="txtblue">Month</span>  
  <select name="month" id="month">
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
  <span class="txtblue">  </span>
  <input name="empno" type="hidden" id="empno" value="<%=sGetUsr%>">
  <input name="Submit" type="submit" class="btm" value="Query">
  <input name="Submit2" type="reset" class="btm" value="Reset">

</form>
</body>
</html>
