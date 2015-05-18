<%@page contentType="text/html; charset=big5" language="java"%>
<%@page import="fz.*,java.sql.*,java.util.*,df.flypay.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first or not login
%>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>寄送個人飛加清單</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<%


String year = request.getParameter("year");
String month = request.getParameter("month");
boolean sendSuccess = false;
String rs = null;
//取得飛加公佈日期
df.flypay.PublishCheck pc = new df.flypay.PublishCheck(year, month, userid);
if(pc.isCheckable() && !pc.isPublished())
{	//一個月內的資料，需檢查公佈日期 && 尚未公佈

%>
<p align="center" >
	<span class="txtxred"><u><%=year+"/"+month%> 飛加尚未公佈 / not yet released </u></span>
</p>
<%
} 
else 
{ //寄送飛加流程 start
	SingleCrewFlyPay sFlyPay = new SingleCrewFlyPay(userid, year, month, userid);

	//設定append file
	sFlyPay.setAppendFile(application.getRealPath("/")+"/noticeFlypay.txt");

	//設定log檔路徑
	sFlyPay.setLogFile(application.getRealPath("/")+"/Log/reqFlyPayLog.txt");
	
	sendSuccess = sFlyPay.sendFlyPayData();


	if(sendSuccess)
	{//寄送成功
	//ci.tool.WriteLog wl = new ci.tool.WriteLog( application.getRealPath("/")+"/flypaylog.txt");
	//	wl.WriteFileWithTime(userid+"\t"+year+"/"+month+"\t");
	fz.writeLog wl = new fz.writeLog();
	wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ347");
	
	%>
	<script lanquag="JAVASCRIPT">
		alert("檔案已寄出至您的全員信箱 / File send to your mail box");
	</script>
	
	<p align="center"><br>
	Open<a href="http://mail.cal.aero" class="txtxred"> cal.aero mail-box</a></p>
	
	<p align="center" ><a href="flyPayQuery.htm" target="topFrame" ><span class="txtxred"><u>寄送其他月份 / Send another month</u></span></a> </p>
	
	<%
	}
	else if(!sFlyPay.isHasData())
	{	//尚無飛加資料
	%>
	
	<p align="center" >
		<a href="flyPayQuery.htm" target="topFrame" ><span class="txtxred"><u>無資料請重試 / No data , try again</u></span></a> 
	</p>
	
	<%
	
	}
	else
	{
	
	%>
	<p align="center" >
		<a href="flyPayQuery.htm" target="topFrame" ><span class="txtxred"><u>寄送失敗，請重試 / Mailing fail, try again</u></span></a> 
	</p>
	<%
	}



}//end of 寄送飛加流程

		
%>






</body>
</html>
