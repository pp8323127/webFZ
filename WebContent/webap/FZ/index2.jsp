<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*"%>
<%
String userip = request.getRemoteAddr();
if("192.168".equals(userip.substring(0,7))){//¤º³¡
	response.sendRedirect("http://tpeweb03:9901/webfz/FZ/login.htm");
}else{
	response.sendRedirect("http://tpeweb02.china-airlines.com:8080/loginIP.jsp");
}

%>
