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
<title>�ӽЧ�s�a���p����T</title>
<link rel="stylesheet" type="text/css" href="checkStyle1.css">
<link rel="stylesheet" type="text/css" href="lightColor.css">

</head>

<body>

<%
if(userid == null){
	errMsg = "�����w�L���A�Э��s�n�J.";
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
		errMsg = "�п�J�Ҧ��������.";
		status = false;
	}else{
		//�H�eemail �q��
		StringBuffer sb = new StringBuffer();
		sb.append("�ӽФH���u���G\t"+userid);
		sb.append("\r\n");
		sb.append("�a�ݩm�W�G\t\t"+kindName);
		sb.append("\r\n");
		sb.append("���Y�G\t\t\t"+kindRel);
		sb.append("\r\n");
		sb.append("�a�ݤ���G\t\t"+kindMbl);		
		sb.append("\r\n");		
		sb.append("�a�ݮa�ιq�ܡG\t"+kindPhone);		
		sb.append("\r\n");
		java.util.Date curDate = java.util.Calendar.getInstance().getTime();
		sb.append("�ӽФ���G\t\t"+new java.text.SimpleDateFormat("yyyy/MM/dd HH:mm:ss",Locale.TAIWAN).format(curDate));
		
		
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "APmailrly1.china-airlines.com");
		Session mailSession = Session.getInstance(props, null);
		MimeMessage msg = new MimeMessage(mailSession);

		try {
			msg.setFrom(new InternetAddress(userid+"@cal.aero"));

			msg.setSubject("�ȿ��խ��ӽзs�W/�ܧ�a���p���q��");

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
<img src="images/messagebox_info.png" width="22" height="22" align="absmiddle" style="margin-right:0.5em; ">�z���ӽФw�e�X!!<br>
<br>
��F�թӿ�H��u�@��T�{�ӽЫ�,��s�z�ҥӽЪ����.<br>
�s��ƱN�ݭn�ƭӤu�@�Ѥ~�|�ͮ�.</div>
<%		
	}
%>
</body>
</html>
<%


%>