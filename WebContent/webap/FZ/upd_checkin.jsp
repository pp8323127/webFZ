<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*"%>
<jsp:useBean id="cci" class="fz.checkCheckin" />
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
String rptloc = request.getParameter("rptloc");
String sdate = request.getParameter("sdate");
String setloc = request.getParameter("setloc");
String applydate = request.getParameter("applydate");

String msg = null;

msg = cci.doUpdate(rptloc, sdate, setloc, applydate, sGetUsr);
if("0".equals(msg)) 
{
	//Sent email to notice 小白,蕭雲芳
	//************************************************************************	
	eg.EGInfo egi = new eg.EGInfo(sGetUsr);
    eg.EgInfoObj obj = egi.getEGInfoObj(sGetUsr); 

	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm");

	tool.Email al = new tool.Email();
	String sender = "TPEEG@email.china-airlines.com";	
	String receiver = "629944@cal.aero,629944@china-airlines.com";
	String cc = "MEI-CHIN_TSAO@email.china-airlines.com,634283@cal.aero";
	//String receiver = "640790@cal.aero";
	//String cc = "betty.yu@china-airlines.com";
	String mailSubject = sGetUsr+" "+obj.getCname()+" 報到地點異動申請";
	StringBuffer mailContent = new StringBuffer();
	mailContent.append("Dear Sir:\r\n\r\n");
	mailContent.append(sGetUsr+" "+obj.getCname()+" 報到地點異動。\r\n\r\n");
	mailContent.append("生效日期 : "+applydate+"。\r\n");
	mailContent.append("報到地點 : 由 "+ rptloc +" 改為 "+setloc+"。\r\n");
	mailContent.append("申請時間 : "+formatter.format(new java.util.Date())+"。\r\n\r\n");
	mailContent.append("B/regards,\r\n");
	al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
	//************************************************************************
	msg = "記錄新增完成 !!";
}
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center" class="txttitletop"><%=msg%>
</div>
</body>
</html>