<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
if (session.isNew()) 
{		//check user session start first
  %>
<jsp:forward page="login.jsp" />
<%
} 
if (sGetUsr == null) 
{		//check if not login
  %>
<jsp:forward page="login.jsp" />
<%
} 
%>
<%
if (session.getAttribute("cs55.auth").equals("R"))
{
        %><jsp:forward page="notauth.jsp" /><%
}
%>
<html>
<head>
<title>Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<meta http-equiv="pragma" content="no-cache">
</head>
<frameset rows="80,*" frameborder="NO" border="0" framespacing="0"> 
  <frame name="topFrame" scrolling="NO" noresize src="topframe5.jsp" >
  <frame name="mainFrame" src="mainframe.jsp">
</frameset>
<noframes>
<body bgcolor="#FFFFFF" text="#000000">
</body>
</noframes> 
</html>
