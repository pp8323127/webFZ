<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Credit Query</title>
<link href = "../menu.css" rel="stylesheet" type="text/css">

</head>
<script src="../../js/checkBlank.js"></script>
<body onLoad="document.getElementById('empno').focus();">
<form name="form1"  action="pickskjList2.jsp" method="post" target="mainFrame" class="txtblue"  onsubmit="return checkBlank('form1','empno','Empno is required!')">
(選班申請單維護) EmpNo/SerNo&nbsp;&nbsp;<input type="text" size="6" maxlength="6" name="empno"  id="empno" class="txtblue">&nbsp;&nbsp;
<input name="Submit" type="submit" class="txtblue" value="Query"  > 
</form>
</body>
</html>
