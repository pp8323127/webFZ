<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>無標題文件</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../js/checkBlank.js"></script>
</head>

<body onLoad="document.form1.empID.focus();" >
<form name="form1" action="crProfile.jsp" target="mainFrame" method="post" onSubmit="return checkBlank('form1','empID','Please Input ID To Query!!')">
<span style="background-color:#A0DBFA; line-height:13.5pt; font-size: 12px; color: #0000FF; font-family: Verdana;padding:2pt"><b>Crew Profile</span>
<input type="text" size="6" maxlength="6" name="empID">
<input type="submit" value="Query">
<span class="txtblue">Please Input ID To Query</span>  
</form>
</body>
</html>
