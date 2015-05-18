<%@ page contentType="text/html; charset=big5" language="java" errorPage="" %>
<%
//**************************for PB use
String uid = request.getParameter("uid");
if(uid != null) {
	session.setAttribute("userid", uid);
	session.setAttribute("pbuser", "Y"); //由EG login 的 user
	session.setAttribute("auth", "O");
}
//*************************************
%>
<html>
<head>
<title>China Airlines Cabin Crew Schedule Inquiry System</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>

<frameset cols="170,*" frameborder="NO" border="0" framespacing="0" rows="*"> 
  <frame name="leftFrame" scrolling="AUTO" src="blank.htm">
  <frameset rows="50,*" frameborder="NO" border="0" framespacing="0" cols="*"> 
    <frame name="topFrame" scrolling="NO"  src="blank.htm">
    <frame name="mainFrame" src="PRSel.jsp">
  </frameset>
</frameset>
<noframes><body bgcolor="#FFFFFF" text="#000000">

</body></noframes>
</html>
