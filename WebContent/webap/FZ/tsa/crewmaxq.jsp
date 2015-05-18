<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Crew Max Query</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body class="txtblue">
<form name="form1" method="post" action="crewmax.jsp" target="mainFrame">
Fleet
  <select name="fleet" id="fleet">
    <option value="333" selected>333</option>
    <option value="343">343</option>
    <option value="738">738</option>
    <option value="742">742</option>
    <option value="744">744</option>
    <option value="AB6">AB6</option>
  </select>
  <select name="job" id="job">
    <option value="CA" selected>CA</option>
    <option value="CC">CC</option>
    <option value="FE">FE</option>
    <option value="FO">FO</option>
  </select>
  EmpNo
  <input name="empno1" type="text" id="empno1" size="10" maxlength="6">
  <input type="submit" name="Submit" value="Query">
</form>
</body>
</html>
