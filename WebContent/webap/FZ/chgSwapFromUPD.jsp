<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%
String userid = (String)session.getAttribute("userid");
if(userid ==  null)
{
	response.sendRedirect("sendredirect.jsp");
}
else
{
	String formno = request.getParameter("formno");
	String ed_check = request.getParameter("ed_check");
	String addcomm = request.getParameter("addcomm").trim();
	String comm = request.getParameter("comm").trim();
	String aEmpno = request.getParameter("aEmpno");
	String rEmpno = request.getParameter("rEmpno");
	String formtype = request.getParameter("formtype");
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	ResultSet rs = null;
	String sql = null;
	ConnDB cn = new ConnDB();
	Driver dbDriver = null;
	int rowCount = 0;
	boolean status =false;
	String errMsg = "";
	try
	{
	//User connection pool 
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	conn.setAutoCommit(false);

	if("A".equals(formtype))
	{
		pstmt = conn.prepareStatement("update fztform set ed_check=?,comments=?,checkuser=?,checkdate=sysdate where formno=?");
		pstmt.setString(1,ed_check);
		pstmt.setString(2,addcomm+comm);
		pstmt.setString(3,userid);
		pstmt.setString(4,formno);
		rowCount = pstmt.executeUpdate();
	}
	else
	{
		pstmt = conn.prepareStatement("update fztbform set ed_check=?,comments=?,checkuser=?,checkdate=sysdate where formno=?");
		pstmt.setString(1,ed_check);
		pstmt.setString(2,addcomm+comm);
		pstmt.setString(3,userid);
		pstmt.setString(4,formno);
		rowCount = pstmt.executeUpdate();

		pstmt2 = conn.prepareStatement("update egtcrdt set comments = comments||' '||?, used_ind = ?, upduser = ?, upddate = sysdate where formno = ? ");	

		if("Y".equals(ed_check))
		{//reject changes to agree
			pstmt2.setString(1,"B"+formno+ " Reject changes to agree ");
			pstmt2.setString(2,"Y");
			pstmt2.setString(3,userid);
			pstmt2.setString(4,formno);
		}
		else
		{//Agree changes to reject
			pstmt2.setString(1,"B"+formno+ " Agree changes to Reject ");
			pstmt2.setString(2,"N");
			pstmt2.setString(3,userid);
			pstmt2.setString(4,formno);
		}
		pstmt2.executeUpdate();
	}

	///寄送 email
	if(rowCount==1)
	{
		conn.commit();
		String cfm="";
		if ("Y".equals(ed_check)) 
		{
				cfm = "核准";
		} 
		else 
		{
				cfm = "退回";
		}
        Properties props = new Properties();
        //props.put("mail.smtp.host", "192.168.2.4");
		props.put("mail.smtp.host", "APmailrly1.china-airlines.com");
        
        Session mailSession = Session.getInstance(props,null);
        
        MimeMessage msg = new MimeMessage(mailSession);
        InternetAddress sender = new InternetAddress("tpeedbox@china-airlines.com");
		sender.setPersonal("TPEED", "Big5");

		msg.setFrom(sender);
		
		//收件者
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(aEmpno+ "@cal.aero"));
		//TODO CC
		msg.setRecipients(Message.RecipientType.CC,(Address[]) InternetAddress.parse(rEmpno+ "@cal.aero"));
			
		//msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse("640790@cal.aero"));
		//TODO CC
		//msg.setRecipients(Message.RecipientType.CC,(Address[]) //InternetAddress.parse("640790@cal.aero"));

			//信件標題						
			msg.setSubject("客艙組員任務互換申請單[狀態更新通知]");
			
			StringBuffer contentSB = new StringBuffer();
			contentSB.append("換班單號 ApplyNumber: " +formtype+ formno );
			contentSB.append(" \r\n審核狀態 Confirm \t: ");
			contentSB.append(ed_check+" ( "+cfm + " ) ");
			contentSB.append("\r\n審核附註 Comments \t: " );
			contentSB.append(addcomm+comm);
			
			msg.setContent(contentSB.toString(),"text/plain; charset=big5"); 

			Transport.send(msg);
		
        	msg = null;	
			status = true;
	}
	else
	{
		status = false;
		errMsg ="申請單狀態更新成功<br>通知信件傳送失敗.<br>";
	}
}
catch (Exception e) 
{
	status = false;
	errMsg += e.getMessage();

	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
} 
finally
{

	if (rs != null) try {rs.close();} catch (SQLException e) {}	
	if (pstmt != null) try {pstmt.close();} catch (SQLException e) {}
	if (pstmt2 != null) try {pstmt2.close();} catch (SQLException e) {}
	if (conn != null) try { conn.close(); } catch (SQLException e) {}
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>更新申請單狀態</title>
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../style/style1.css">
<link rel="stylesheet" type="text/css" href="../style/lightColor.css">
<link rel="stylesheet" type="text/css" href="../style/kbd.css">
</head>

<body>
<div class="paddingTopBottom errStyle3">

  <%

	if(status){//更新成功&mail成功!!
		
%>
<img src="images/messagebox_info.png" align="absmiddle">申請單狀態更新成功!!<br>
已重新寄送訊息通知予組員.
<%		
	}else{//更新成功.mail失敗
%>
<img src="images/messagebox_warning.png" align="absmiddle"><%=errMsg%>
<%		

	}
%>
</div>
</body>
</html>
<%
}
%>