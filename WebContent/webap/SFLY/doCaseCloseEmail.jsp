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
mailContent.append("您有一份考核報告已完成，請至組員班表資訊網查詢。\r\n");
mailContent.append("並請於閱讀後，點擊〝檢視完畢〞按鈕回覆，謝謝!!\r\n\r\n");
mailContent.append("空管部\r\n");
al.sendEmail( sender,  receiver, cc, mailSubject, mailContent);
%>