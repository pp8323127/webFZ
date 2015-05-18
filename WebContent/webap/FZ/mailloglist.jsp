<%@page contentType="text/html; charset=big5" language="java"%>
<%@page import="fz.*,java.sql.*,java.util.*,df.log.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
%>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Make Text File</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
}
.style3 {
	font-family: "標楷體";
	font-size: 22px;
}
-->
</style>
<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<%
String y = request.getParameter("sely");
String m = request.getParameter("selm");
SingleCrewLogList s = new SingleCrewLogList(y, m, sGetUsr);
s.SelectData();
if(!s.isHasData()){//無資料
%>
<p align="center" class="txtblue" >本月無資料!!<br>
  <a href="loglistquery.htm" target="topFrame" ><span class="txtxred"><u>寄送其他月份</u></span></a> </p>

<%
}else{
	s.setLogFile(application.getRealPath("/")+"/Log/reqLogListLog.txt");
	s.SendLogList(application.getRealPath("/")+"/");

fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ340");
	
	
%>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center" class="style2 style3">開啟全員信箱</p>
<p align="center" class="style2"><a href="https://mail.cal.aero">Open cal.aero mail-box</a> </p>
<p align="center" ><a href="loglistquery.htm" target="topFrame" ><span class="txtxred"><u>寄送其他月份</u></span></a> </p>
<%	
}
/*
cLogList cll = new cLogList();

//寄出檔案
String rs = cll.doFile(sGetUsr, y, m, application.getRealPath("/")+"/cloglist.txt");
//out.println(rs);
if (!rs.equals("0"))
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="<%=rs%>" />
	</jsp:forward>
   <% 
}
*/


%>

</body>
</html>
