<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*, java.util.*, java.text.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>組員月班表</title>
<link href="../../menu.css" rel="stylesheet" type="text/css">
</head>
<script src="../../js/showDate.js" language="javascript" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function chk() {
	if(document.form1.empno.value == "") {
		alert("Please input Empno !");
		document.form1.empno.focus();
		return false;
	}
	
	return true;
}
</script>

<body onLoad="javascript:document.form1.mm.focus();showYM('form1','yy','mm')">
<form name="form1" method="post" action="showsche3.jsp" target="mainFrame" onsubmit="return chk();">
<select name="yy">
  <option value="2004">2004</option>
  <option value="2005">2005</option>
  <option value="2006">2006</option>
  <option value="2007">2007</option>
  <option value="2008">2008</option>
  <option value="2009">2009</option>
  <option value="2010">2010</option>
  <option value="2011">2011</option>
  <option value="2012">2012</option>
  <option value="2013">2013</option>
  <option value="2014">2014</option>
  <option value="2015">2015</option>
</select>
<select name="mm" >
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

empno : 
<input name="empno" type="text" maxlength="6" size="6">

<input name="Submit" type="submit" value="Query">
</form>
</body>
</html>
