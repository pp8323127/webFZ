<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" type="text/css" href="../menu.css">
<script language="javascript" type="text/javascript" src="../js/showDate.js"></script>
<script language="JavaScript" src="calendar2.js" ></script>
<script language="JavaScript" src="../js/checkBlank.js" ></script>

<title>��Z�d��</title>
</head>

<body>
<form name="form1" action="showFlt.jsp" method="post" target="mainFrame" onsubmit="return checkBlank(
'form1','fdate','�п�J�d�ߤ��')"  >
  <span class="txtblue">Flight Date:</span>
  <input type="text" size="10" maxlength="10" name="fdate" id="fdate" onclick="cal.popup();">
  <img height="16" src="img/cal.gif" width="16" onclick="cal.popup();"> <span class="txtblue">FLTNO</span>
  <input type="text" size="4" maxlength="4" name="fltno">
  <input type="submit" value="QUERY">
  <span class="txtxred">�i��Z�d�ߡj�I��Flight Date��ܬd�ߤ��(yyyy/mm/dd)�C����JFltno�A�h��ܥ�����Z </span>
</form>
</body>
</html>
<script language="JavaScript">
var cal = new calendar2(document.forms['form1'].elements['fdate']);
cal.year_scroll = true;
cal.time_comp = false;
</script>