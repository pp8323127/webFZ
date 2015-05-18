<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
String userip = request.getRemoteAddr();
String userhost = request.getRemoteHost();

%>
	<jsp:forward page="http://tpeweb02.china-airlines.com/webfz/FZ/login.jsp">
	<jsp:param name="userip" value="<%=userip%>" />
	<jsp:param name="userhost" value="<%=userhost%>" />
	<jsp:param name="outside" value="Y" />
	</jsp:forward>
