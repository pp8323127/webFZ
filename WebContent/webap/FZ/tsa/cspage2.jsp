<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*" errorPage="" %>

<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
session.setAttribute("cabin",null);
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
String uid = (String) session.getAttribute("userid") ;

if ((sGetUsr == null) || (session.isNew()) )
{		//check user session start first or not login
	response.sendRedirect("../logout.jsp");
} 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Management Page</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<p class="txttitletop">Management Information </p>
<ul>
  <li class="txtblue"><a href="tsaframe.htm">OZ CII</a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_od.jsp">OD CII</a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_ed.jsp">ED CII</a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_oz2.jsp">OZ CII -2</a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_auh.jsp">AUH CII</a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_uv.jsp">���A��</a> </li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_qc.jsp">�w�޳B�w���~�O�� �O�w��</a></li>   
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_qc2.jsp">�w�޳B�������a�Ϧw���޲z��</a></li>  
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_kb.jsp">��A�B�@�~�� Crew meal</a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_pub.jsp">��ȳB�@�αb��</a> </li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_kl.jsp">��A�B�@�~�� </a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_ir.jsp">�H�O�B������ </a></li>  
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_qi.jsp">�����B�A�ȫ~�O��</a></li>
  <br>
  <li class="txtblue"><a href="../log.htm">�o�e���[��Log</a></li>
<br>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_adm.jsp"><span  class="txtxred">���ե\��</span></a><br>

</li>
</ul>
</body>
</html>
