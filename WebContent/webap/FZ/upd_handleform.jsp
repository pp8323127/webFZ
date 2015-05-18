<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first or not login
	response.sendRedirect("sendredirect.jsp");
} else{

String[] formno = request.getParameterValues("formno");
String[] aempno = request.getParameterValues("aempno");
String[] rempno = request.getParameterValues("rempno");
String[] comm = request.getParameterValues("comm");
String[] addcomm =request.getParameterValues("addcomm");
String[] formtype = request.getParameterValues("formtype");
String[] acount = request.getParameterValues("acount");
String[] acomm = request.getParameterValues("acomm");
String[] rcount = request.getParameterValues("rcount");
String[] rcomm =request.getParameterValues("rcomm");

String[] cf = new String[formno.length];
for(int i=0;i<cf.length;i++)
{
	cf[i] = request.getParameter("cf"+i);
}


Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();
String sql = "";

String errMsg = "";
boolean status = false;

try 
{
	cn.setORP3FZUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	conn.setAutoCommit(false);

	pstmt = conn.prepareStatement("update egtcrdt set comments = comments||' '||?, used_ind = 'N', upduser = ?, upddate = sysdate where sno = to_number(?) or sno = decode(?,'N/A',0,null,0,?) ");	

	stmt = conn.createStatement();
	for(int i=0;i<formno.length;i++)
	{
		if("A".equals(formtype[i]))
		{
			sql = "update fztform set ed_check='"+cf[i]+"', comments='"+addcomm[i]+" "+comm[i]+"', checkuser='"+userid+"', checkdate=sysdate where formno='"+formno[i]+"'";
		}
		else
		{
			sql = "update fztbform set ed_check='"+cf[i]+"', comments='"+addcomm[i]+" "+comm[i]+"', checkuser='"+userid+"', checkdate=sysdate where formno='"+formno[i]+"'";
		}
		//out.println(sql+"<br>");
		stmt.executeUpdate(sql); 

		if("N".equals(cf[i]))
		{
			//out.println(acomm[i]+" >> "+rcomm[i]+" >> return credit <br>");
			pstmt.setString(1,"B"+formno[i]+" 退單");
			pstmt.setString(2,userid);
			pstmt.setString(3,acomm[i]);
			pstmt.setString(4,rcomm[i]);
			pstmt.setString(5,rcomm[i]);
			pstmt.executeUpdate(); 
		}
	}

	conn.commit();
	
//寄送 email
		String cfm="";
        Properties props = new Properties();
        //props.put("mail.smtp.host", "APmailrly1.china-airlines.com");
		props.put("mail.smtp.host", "APmailrly2.china-airlines.com");
        
        Session mailSession = Session.getInstance(props,null);
        
        MimeMessage msg = new MimeMessage(mailSession);
        
		 for (int i = 0; i < formno.length; i++) 
		 {
			 cfm="";
			if ("Y".equals(cf[i])) 
			{
				cfm = "核准";
			} 
			else 
			{
				cfm = "退回";
			}
			//寄件者為 ED 公用信箱
			//msg.setFrom(new InternetAddress("tpeed@china-airlines.com"));
			
			InternetAddress sender = new InternetAddress("tpeedbox@china-airlines.com");
			sender.setPersonal("TPEED", "Big5");

			msg.setFrom(sender);

			//收件者
			
			msg.setRecipients(Message.RecipientType.TO, InternetAddress
					.parse(aempno[i]+ "@cal.aero"));
					
			msg.setRecipients(Message.RecipientType.CC,
					(Address[]) InternetAddress.parse(rempno[i]+ "@cal.aero"));
			/*	
			msg.setRecipients(Message.RecipientType.TO, InternetAddress
					.parse("640790@cal.aero"));
					
			msg.setRecipients(Message.RecipientType.CC,
					(Address[]) InternetAddress.parse("640790@cal.aero"));
			*/
			//信件標題						
			msg.setSubject("客艙組員任務互換申請單");
			
			StringBuffer contentSB = new StringBuffer();
			contentSB.append("換班單號 ApplyNumber: " +formtype[i]+ formno[i] );
			contentSB.append(" \r\n審核狀態 Confirm \t: ");
			contentSB.append(cf[i]+" ( "+cfm + " ) ");
			contentSB.append("\r\n審核附註 Comments \t: " );
			contentSB.append(addcomm[i] + comm[i]);
			
			msg.setContent(contentSB.toString(),"text/plain; charset=big5"); 

			Transport.send(msg);
			
		}
        	msg = null;
	status = true;


} catch (Exception e) {
	status = false;
	errMsg += e.getMessage();

	try {
	//有錯誤時 rollback
		conn.rollback();
	} catch (SQLException e1) {
		errMsg += e1.getMessage();
	}
} finally {
	if ( rs != null ) try {
		rs.close();
	} catch (SQLException e) {}
	if ( stmt != null ) try {
		stmt.close();
	} catch (SQLException e) {}
	if ( pstmt != null ) try {
		pstmt.close();
	} catch (SQLException e) {}
	if ( conn != null ) try {
		conn.close();
	} catch (SQLException e) {}

}



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>更新處理換班申請單</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>
<link rel="stylesheet" type="text/css" href="../style/errStyle.css">
<link rel="stylesheet" type="text/css" href="../style/style1.css">
<link rel="stylesheet" type="text/css" href="../style/lightColor.css">
<link rel="stylesheet" type="text/css" href="../style/kbd.css">

<body>

<div class="paddingTopBottom errStyle3">

<%

if(!status){
%>
<img src="images/messagebox_warning.png" align="absmiddle"><%=errMsg%>
<%
}else{
%>
<img src="images/messagebox_info.png" align="absmiddle">任務互換申請單處理完成<br>
已將訊息發至組員全員信箱
<%
}
%>
</div>

</body>
</html>
<%
}
%>