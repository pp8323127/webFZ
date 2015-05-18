<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>無標題文件</title>
<link href="../style2.css" rel="stylesheet" type="text/css">
</head>

<body>
<form name="form1" action="compare.jsp">
<div >[比對班表]  </div>
<p>
    <select name="year">
     <jsp:include page="../temple/year.htm" />
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
<br>
比對者
<input type="text" size="6" maxlength="6" name="aEmpno">
<br>
被比對者
<input type="text" size="6" maxlength="6" name="rEmpno">
<input type="submit" class="e" value="Query">
</form>
</body>
</html>
