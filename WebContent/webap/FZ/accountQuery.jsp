<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>查詢使用者帳號是否存在</title>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body onLoad="document.form1.empno.focus()">
<form method="post" name="form1" action="showAcount.jsp" target="mainFrame">
<input name="empno" size="6"  maxlength="6">
<input type="submit" name="send" value="Query"> 
<span class="txtblue">*Insert Employee number to query </span></form>
</body>
</html>
