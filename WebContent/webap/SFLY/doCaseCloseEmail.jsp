<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="java.sql.*,tool.*"%>
<%
String purempno = request.getParameter("purempno");
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String mailSubject = request.getParameter("mailSubject");


Email al = new Email();
String sender = userid+"@cal.aero";
//String receiver = "shu-fen.chou@china-airlines.com";
//String receiver = "betty.yu@china-airlines.com";
String receiver = purempno+"@cal.aero";
String cc = "";//"betty.yu@china-airlines.com";
StringBuffer mailContent = new StringBuffer();
mailContent.append("Dear PUR:\r\n\r\n");
mailContent.append("�z���@���Үֳ��i�w�����A�Цܲխ��Z���T���d�ߡC\r\n");
mailContent.append("�ýЩ�\Ū��A�I�����˵����������s�^�СA����!!\r\n\r\n");
mailContent.append("�ź޳�\r\n");
al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
%>