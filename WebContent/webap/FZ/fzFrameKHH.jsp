<%@ page contentType="text/html; charset=big5" language="java"  %>
<%
String userid = (String)session.getAttribute("userid");
String KHHEFFZ = (String)session.getAttribute("KHHEFFZ");


if(null == userid ){
	response.sendRedirect("sendredirect.jsp");
}else if(!"Y".equals(KHHEFFZ) | null == KHHEFFZ  ){
%>
<div style="background-color:#99FFFF;color:#FF0000;"
		+"font-family:Verdana;font-size:10pt;"
		+"padding:5pt;text-align:center;">
您無權限使用!!</div>
<script language="javascript" type="text/javascript">
	alert("您無權限使用!!");
	self.location.href="sendredirect.jsp";
</script>
<%
}else{
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>China Airlines Cabin Crew Schedule Inquiry System</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
</head>

<frameset cols="185,*" frameborder="NO" border="0" framespacing="0" rows="*"> 
  <frame name="leftFrame" scrolling="AUTO" src="fscreenKHHEF.jsp">
  <frameset rows="50,*" frameborder="NO" border="0" framespacing="0" cols="*"> 
    <frame name="topFrame" scrolling="NO"  src="showmessage.jsp" >
    <frame name="mainFrame" src="popup.jsp">
  </frameset>
</frameset>
<noframes><body>

</body></noframes>
</html>
<%
}
%>