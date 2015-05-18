<%@page contentType="text/html; charset=big5" language="java" %>
<%
String mypage = request.getParameter("mypage");
%>
<html>
<head>
<title>Crew Integration Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>

<frameset cols="145,*" frameborder="AUTO" border="0" framespacing="0">
  <frame src="<%=mypage%>" name="leftFrame" scrolling="AUTO" noresize>
  <frameset rows="50,*" frameborder="NO" border="0" framespacing="0">
  <frame name="topFrame" scrolling="NO"  noresize src="../blank.htm" >
  <frame name="mainFrame" src="../blank.htm">
  </frameset>
</frameset>



<noframes> 
<body >
</body>
</noframes> 
</html>
