<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*" errorPage="" %>
<%
String fltno = request.getParameter("requestFltno");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>eSMS������X��</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

</head>

<body>
<div align="center">
<span class="txttitletop">������X�ɮסA�s�@���\!!</span><br>
<span class="txtgray2">1.������X�ɡG</span><a href="SMSMakeFile_2.jsp?f=1&fltno=<%=fltno%>"><img src="../../images/ed4.gif" border="0">���I���t�s�s��!!</a><br>
<span class="txtgray2">2.�ӤH��²�T�ɡG</span><a href="SMSMakeFile_2.jsp?f=2&fltno=<%=fltno%>"><img src="../../images/ed4.gif" border="0">���I���t�s�s��!!</a>
<br>
<br>
<span class="txtblue">�o�e²�T�A�Ц�<a href="http://eip.china-airlines.com/" target="_blank"><font color="#FF0000" style="text-decoration:underline ">�د�²�T�A�Ⱥ�eSMS</font></a><br>
�W�Ǧ��B�s�@��������X�ɮקY�i�C</span>
</div>
</body>
</html>
