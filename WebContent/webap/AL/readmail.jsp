<%@ page contentType="text/html; charset=Big5" import="java.sql.*" errorPage="" %>
<%@ page language="java" %>
<%@ page import="java.util.*, java.io.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page import="javax.activation.*" %>

<% /*
try {
	// Code which can throw can exception
} catch(Exception e) {
	// Exception handler code here
} /* */
%>

<%
request.setCharacterEncoding("Big5");        //Tomcat must set to receive Big5
	// APmailrly1.china-airlines.com Intranet mail relay IP
String hostIP = request.getParameter("IP");
String mailID = request.getParameter("user");
String mailPasswd = request.getParameter("passwd");

//Session mailSession = Session.getInstance(props,null);

    // Get session
    Session mailSession = Session.getInstance(
                           System.getProperties(), null);

    // Get the store
    Store store = mailSession.getStore("imap");
    store.connect(hostIP, mailID, mailPasswd);

    // Get folder
    Folder folder = store.getFolder("INBOX");
    folder.open(Folder.READ_ONLY);

    // Get Count
    int msgCount = folder.getMessageCount();
    //System.out.println("Messages waiting: " 
    //  + count);
    int unReadCount = folder.getUnreadMessageCount();
    //System.out.println("Unread messages waiting: " 
    //  + count);

    // Close connection 
    folder.close(false);
    store.close();
 
%>

<html>
<meta http-equiv="Content-Type" content="text/html; charset=Big5"> 
<p align="center">The INBOX message count <br>
  use IMAP</p>
<table width="30%"  border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>Unread message count <%= unReadCount %> </td>
  </tr>
  <tr>
    <td>Total message count <%=msgCount %></td>
  </tr>
</table>
<div align="center"></div>
<p align="center"><a href="readmail.htm">Click here to test another.</a></p>
</html>
