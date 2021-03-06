<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"  %>
<%@ page import="javax.activation.*"%>
<%@ page import="javax.mail.*"%>
<%@ page import="javax.mail.internet.*"%>

<%
String userid = (String)session.getAttribute("userid");
boolean status = false;
String errMsg = "";



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>申請更新家屬聯絡資訊</title>
<link rel="stylesheet" type="text/css" href="checkStyle1.css">
<link rel="stylesheet" type="text/css" href="lightColor.css">

</head>

<body>

<%
if(userid == null){
	errMsg = "網頁已過期，請重新登入.";
	status = false;
}else{
	String kindName = null;
	if(!"".equals(request.getParameter("kindName")) &&  null !=request.getParameter("kindName") ) {
		kindName = request.getParameter("kindName");
	}
	String kindRel	= null;
	if(!"".equals(request.getParameter("kindRel")) &&  null !=request.getParameter("kindRel") ) {
		kindRel = request.getParameter("kindRel");
	}
	String kindMbl	= null;
	if(!"".equals(request.getParameter("kindMbl")) &&  null !=request.getParameter("kindMbl") ) {
		kindMbl = request.getParameter("kindMbl");
	}
	String kindPhone= "";
	if(!"".equals(request.getParameter("kindPhone")) &&  null !=request.getParameter("kindPhone") ) {
		kindPhone = request.getParameter("kindPhone");
	}
	
	
	if(kindName == null || kindRel == null || kindMbl == null){
		errMsg = "請輸入所有必填欄位.";
		status = false;
	}else{
		//寄送email 通知
		StringBuffer sb = new StringBuffer();
		sb.append("申請人員工號：\t"+userid);
		sb.append("\r\n");
		sb.append("家屬姓名：\t\t"+kindName);
		sb.append("\r\n");
		sb.append("關係：\t\t\t"+kindRel);
		sb.append("\r\n");
		sb.append("家屬手機：\t\t"+kindMbl);		
		sb.append("\r\n");		
		sb.append("家屬家用電話：\t"+kindPhone);		
		sb.append("\r\n");
		java.util.Date curDate = java.util.Calendar.getInstance().getTime();
		sb.append("申請日期：\t\t"+new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss",Locale.TAIWAN).format(curDate));
		
		
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "APmailrly1.china-airlines.com");
		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);

		try {
			msg.setFrom(new InternetAddress(userid+"@cal.aero"));

			msg.setSubject("客艙組員申請新增/變更家屬聯絡電話");

			msg.setRecipients(Message.RecipientType.TO, InternetAddress.
				parse(
				//"frances.tsai@china-airlines.com"
				//,640073@cal.aero"));
			"chuan-kuei_wu@email.china-airlines.com,YING-YING_HSU@email.china-airlines.com"
			));	
			msg.setContent(sb.toString(), "text/plain;charset=big5");
			Transport.send(msg);
		
			status = true;
		} catch (Exception e) {
			status = false;
			errMsg +=e.getMessage();
		} finally {
			msg = null;
			mailSession = null;
			props = null;
		}
		
		
				

	}
	
}	
	if(!status){
%>
<div class="paddingTopBottom1 bgLYellow red center" ><%=errMsg%>
<%	
	}else{
%>
<div class="paddingTopBottom1 bgLYellow red left" >
<img src="images/messagebox_info.png" width="22" height="22" align="absmiddle" style="margin-right:0.5em; ">您的申請已送出!!<br>
<br>
行政組承辦人於工作日確認申請後,更新您所申請的資料.<br>
新資料將需要數個工作天才會生效.</div>
<%		
	}
%>
</body>
</html>
<%


%>
