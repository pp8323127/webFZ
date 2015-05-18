<%@ page contentType="text/html; charset=big5" import="java.sql.*" errorPage="" %>
<%@ page language="java" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.mail.internet.MimeMessage.*" %>
<%@ page import="javax.activation.*" %>
<%@ page import="com.sun.mail.smtp.*" %>
<%
String userid = request.getParameter("userid");
String password = request.getParameter("password");

Properties props = new Properties();
//props.put("mail.smtp.host", "61.13.233.233"); 
//props.put("mail.smtp.host", "192.168.2.3");  // <= change your mail server IP address 
props.put("mail.smtp.host", "APmailrly1.china-airlines.com");  // <= change your mail server IP address 
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.user", userid);
props.put("mail.smtp.password", password);

Session mailSession = Session.getInstance(props,null);
MimeMessage msg = new MimeMessage(mailSession);
InetAddress myia = InetAddress.getByName("crew.china-airlines.com");

PasswordAuthentication mypa = mailSession.requestPasswordAuthentication(null,80,"pop3",null,null);
String mypass = mypa.getPassword();
String myuserid = mypa.getUserName();
//System.out.println(mypass+","+myuserid);

%>

<html>
<H1><%=userid%></H1>
<H1><%=password%></H1>
<H1><%=myia%></H1>
<H1><%=mypass%></H1>
<H1><%=myuserid%></H1>

<!--<p align="center">The message has been sent successfully!<br></p>
<p align="center"><a href="sendmail.htm">Click here to send another.</a></p>-->
</html>
