<%@ page contentType="text/html; charset=big5" errorPage="" %>
<%@ page language="java" %>
<%@ page import="fz.*, java.util.*, java.io.*"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" /> <%
} 
%>
<html>
<link rel="stylesheet" href="menu.css" type="text/css">
<body>

<div align="center">
<%
String subject = request.getParameter("Subject");
String message = request.getParameter("Message");
String to = request.getParameter("to");
String toAdd = "";
if("1".equals(to)){	//空一組
	toAdd = "1stcabincrewdept@email.china-airlines.com";
}else if("2".equals(to)){
	toAdd = "2stcabincrewdept@email.china-airlines.com";	
}else if("3".equals(to)){
	toAdd = "3rdcabincrewdept@email.china-airlines.com";	
}else if("4".equals(to)){
	toAdd = "4thcabincrewdept@email.china-airlines.com";	
}else if("ef".equals(to)){
	toAdd = "tpeef@email.china-airlines.com";	
}else if("ee".equals(to)){
	toAdd = "tpeee@email.china-airlines.com";
}else if("kh".equals(to)){
	toAdd = "khhefcibox@email.china-airlines.com";
}else if("ea".equals(to)){
	toAdd = "629458@cal.aero";
}



Properties props = new Properties();
props.put("mail.smtp.host", "192.168.2.4");
try {
Session mailSession = Session.getInstance(props,null);

MimeMessage msg = new MimeMessage(mailSession);

InternetAddress from  = new InternetAddress(sGetUsr+"@cal.aero");
msg.setFrom(from);
InternetAddress Rec = new InternetAddress(toAdd);
//InternetAddress to = new InternetAddress(toAdd);
msg.addRecipient(Message.RecipientType.TO,Rec);


	msg.setSubject("Mail From Crew Schedule System ["+(String)session.getAttribute("cname")+"]"+subject);
	msg.setContent(message, "text/plain; charset=big5");  // added big5
	
	Transport.send(msg);
	msg = null;

fz.writeLog wl = new fz.writeLog();
wl.updLog(sGetUsr, request.getRemoteAddr(),request.getRemoteHost(), "FZ232");
%>
</div>
<p align="center"><span class="txttitletop">The message has been sent successfully!</span><br>
</p>

<%
} catch(Exception e) {
	out.print("系統忙碌中，請稍後再試!!");
	System.out.print(e.toString());
}


%>


</body>
</html>
