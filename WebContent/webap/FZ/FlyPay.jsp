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
<title>�H�e�ӤH���[�M��</title>
<link href="../menu.css" rel="stylesheet" type="text/css">

<link href="menu.css" rel="stylesheet" type="text/css">
</head>

<body>
<%


String year = request.getParameter("year");
String month = request.getParameter("month");
boolean sendSuccess = false;
String rs = null;
//���o���[���G���
df.flypay.PublishCheck pc = new df.flypay.PublishCheck(year, month, userid);
if(pc.isCheckable() && !pc.isPublished())
{	//�@�Ӥ뤺����ơA���ˬd���G��� && �|�����G

%>
<p align="center" >
	<span class="txtxred"><u><%=year+"/"+month%> ���[�|�����G / not yet released </u></span>
</p>
<%
} 
else 
{ //�H�e���[�y�{ start
	SingleCrewFlyPay sFlyPay = new SingleCrewFlyPay(userid, year, month, userid);

	//�]�wappend file
	sFlyPay.setAppendFile(application.getRealPath("/")+"/noticeFlypay.txt");

	//�]�wlog�ɸ��|
	sFlyPay.setLogFile(application.getRealPath("/")+"/Log/reqFlyPayLog.txt");
	
	sendSuccess = sFlyPay.sendFlyPayData();


	if(sendSuccess)
	{//�H�e���\
	//ci.tool.WriteLog wl = new ci.tool.WriteLog( application.getRealPath("/")+"/flypaylog.txt");
	//	wl.WriteFileWithTime(userid+"\t"+year+"/"+month+"\t");
	fz.writeLog wl = new fz.writeLog();
	wl.updLog(userid, request.getRemoteAddr(),request.getRemoteHost(), "FZ347");
	
	%>
	<script lanquag="JAVASCRIPT">
		alert("�ɮפw�H�X�ܱz�������H�c / File send to your mail box");
	</script>
	
	<p align="center"><br>
	Open<a href="http://mail.cal.aero" class="txtxred"> cal.aero mail-box</a></p>
	
	<p align="center" ><a href="flyPayQuery.htm" target="topFrame" ><span class="txtxred"><u>�H�e��L��� / Send another month</u></span></a> </p>
	
	<%
	}
	else if(!sFlyPay.isHasData())
	{	//�|�L���[���
	%>
	
	<p align="center" >
		<a href="flyPayQuery.htm" target="topFrame" ><span class="txtxred"><u>�L��ƽЭ��� / No data , try again</u></span></a> 
	</p>
	
	<%
	
	}
	else
	{
	
	%>
	<p align="center" >
		<a href="flyPayQuery.htm" target="topFrame" ><span class="txtxred"><u>�H�e���ѡA�Э��� / Mailing fail, try again</u></span></a> 
	</p>
	<%
	}



}//end of �H�e���[�y�{

		
%>






</body>
</html>
