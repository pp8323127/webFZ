<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="fz.*,ci.db.*,java.sql.*,ci.tool.*,javax.mail.*,javax.mail.internet.*,java.util.*"%>
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
Connection conn = null;
Driver dbDriver = null;

Statement stmt = null;
ResultSet myResultSet = null;
boolean t = false;

String userid 	=(String) session.getAttribute("userid") ; 
String oMphone = request.getParameter("oMphone");//�ק�e��mphone
String mphone	= request.getParameter("tf_mphone");//�ק�᪺mphone
String oHphone = request.getParameter("oHphone");//�ק�e��hphone
String hphone	= request.getParameter("tf_hphone");
//String address	= request.getParameter("tf_address");
String icq		= request.getParameter("tf_icq");


try{

//dbDriver = (Driver) Class.forName("weblogic.jdbc.pool.Driver").newInstance();
//conn = dbDriver.connect("jdbc:weblogic:pool:CAL.FZCP02", null);
ConnDB cn = new ConnDB();
cn.setORP3FZUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement();

icq = ReplaceAllFor1_3.replace(icq,"'","''");

String sql = "UPDATE FZTCREW SET MPHONE ='"
			+ mphone +"',HPHONE = '" + hphone +"',ICQ = '" + icq +"'  WHERE EMPNO = '" + userid +"'";
			
//myResultSet = 
stmt.executeUpdate(sql); 	//����


}
catch (Exception e)
{
	  out.print(e.toString());
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}



if( (!mphone.equals(oMphone) && !mphone.equals("") ) 
	| (!hphone.equals(oHphone) && !hphone.equals(""))){//�q�ܦ��ܧ� �B�ܧ�ᤧ�Ȥ����ť�
	
	StringBuffer sb = new StringBuffer();
	sb.append("�խ��]���u�� "+userid+" ) �w�ܧ��Z���T�����ӤH�q�ܡA\r\n");
	if(!mphone.equals(oMphone) ){
		sb.append("�s��Ƥ���ʹq�ܬ��G"+mphone+"\r\n");
	}
	if(!hphone.equals(oHphone) ){
		sb.append("�s��Ƥ���a�q�ܬ��G"+hphone+"\r\n");
	}
	
	Properties props = new Properties();
	props.put("mail.smtp.host", "APmailrly1.china-airlines.com");
	
	Session mailSession = Session.getInstance(props, null);
	MimeMessage msg = new MimeMessage(mailSession);

	try {
		msg.setFrom(new InternetAddress("tpecsci@cal.aero"));

		msg.setSubject("�խ��Z���T��.�խ�����ܧ�q��");

		msg.setRecipients(Message.RecipientType.TO, InternetAddress
				.parse("TPEED@email.china-airlines.com"));
				//.parse("640073@cal.aero"));
		msg.addRecipients(Message.RecipientType.TO, InternetAddress
				.parse("TPEEA@email.china-airlines.com"));
				//.parse("tpecsci@cal.aero"));
		
		msg.setContent(sb.toString(), "text/plain;charset=big5");
		Transport.send(msg);

		
	} catch (AddressException e) {
	  
		System.out.print("����ܧ�mail�H�e���ѡG"+e.toString());
	} catch (MessagingException e) {
	  	System.out.print("����ܧ�mail�H�e���ѡG"+e.toString());
	} finally {
		msg = null;
		mailSession = null;
		props = null;
	}
		

} //end of �ܧ�q�ܸ��X


%>
<html>
<head>
<title>Update Crew Info</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
</head>


<body>
<div align="center">
  <p class="txttitletop">Update Success !!</p>
  <p><a href="javascript:history.back(-1)"  target="_self" class="cs55text">Click here to view crew information</a></p>
</div>
</body>
</html>