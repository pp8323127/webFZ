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
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_uv.jsp">車服部</a> </li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_qc.jsp">安管處安全品保部 保安部</a></li>   
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_qc2.jsp">安管處桃園機場地區安全管理組</a></li>  
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_kb.jsp">行服處作業部 Crew meal</a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_pub.jsp">航務處共用帳號</a> </li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_kl.jsp">行服處作業部 </a></li>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_ir.jsp">人力處員關部 </a></li>  
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_qi.jsp">公關處服務品保室</a></li>
  <br>
  <li class="txtblue"><a href="../log.htm">發送飛加及Log</a></li>
<br>
  <li class="txtblue"><a href="tsaframe.jsp?mypage=tsaleft_adm.jsp"><span  class="txtxred">測試功能</span></a><br>

</li>
</ul>
</body>
</html>
