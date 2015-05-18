<%@ page contentType="text/html; charset=big5" import="java.sql.*" errorPage="" %>
<%@ page language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>

<%
Properties props = new Properties();
// props.put("mail.smtp.host", "127.0.0.1");
props.put("mail.smtp.host", "192.168.2.4");   // <= change your mail server IP address
Session mailSession = Session.getInstance(props,null);

MimeMessage msg = new MimeMessage(mailSession);

String toAddress = request.getParameter("To");
String subject = request.getParameter("Subject");
String message = request.getParameter("Message");

InternetAddress from = new InternetAddress("JAVAmail@TPEWEB02");
msg.setFrom(from);

InternetAddress to = new InternetAddress(toAddress);
msg.addRecipient(Message.RecipientType.TO, to);

msg.setSubject(subject);
msg.setContent(message, "text/plain; charset=big5");  // added big5

Transport.send(msg);
%>

<html>
<p align="center">The message has been sent successfully!<br></p>
<p align="center"><a href="sendmail.htm">Click here to send another.</a></p>
</html>
