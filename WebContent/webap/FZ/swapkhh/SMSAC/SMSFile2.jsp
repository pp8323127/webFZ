<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,fz.*" errorPage="" %>
<%
String fltno = request.getParameter("requestFltno");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>eSMS手機號碼檔</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

</head>

<body>
<div align="center">
<span class="txttitletop">手機號碼檔案，製作成功!!</span><br>
<span class="txtgray2">1.手機號碼檔：</span><a href="SMSMakeFile_2.jsp?f=1&fltno=<%=fltno%>"><img src="../../images/ed4.gif" border="0">請點此另存新檔!!</a><br>
<span class="txtgray2">2.個人化簡訊檔：</span><a href="SMSMakeFile_2.jsp?f=2&fltno=<%=fltno%>"><img src="../../images/ed4.gif" border="0">請點此另存新檔!!</a>
<br>
<br>
<span class="txtblue">發送簡訊，請至<a href="http://eip.china-airlines.com/" target="_blank"><font color="#FF0000" style="text-decoration:underline ">華航簡訊服務網eSMS</font></a><br>
上傳此處製作的手機號碼檔案即可。</span>
</div>
</body>
</html>
