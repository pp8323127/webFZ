<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*,java.sql.Date,fz.*"%>
<%
//特殊帳號 rick : PA Raw teacher
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} else{

//取得是否為PowerUser
String  unidCD=  (String) session.getAttribute("fullUCD");	//get unit cd
fzAuth.UserID userID = new fzAuth.UserID(sGetUsr,null);
fzAuth.CheckPowerUser ck = new fzAuth.CheckPowerUser();


%>
<html>
<head>
<title>Tsa Left Frame</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function pageLoad(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
<body bgcolor="#99ccff" >
<p>
<!--<a class="txtblue" href='javascript:pageLoad("../paraw/paraw_querycond.jsp","../blank.htm")'>PA Raw Score</a></p>  -->
<a class="txtblue" href='javascript:pageLoad("../paraw2011/paraw_querycond.jsp","../blank.htm")'>PA Raw Score(2011)</a></p>
<%
if(ck.isHasPowerUserAccount() ){
%>
<p><a href="cspage.jsp" target="_top"><span style="color:#003333;background-color:#FFCCFF;padding:2pt; ">選擇登入頁面</span></a></p>
<%
}
%>
<br>
<p><a href="#" class="txtblue" onClick='pageLoad("../blank.htm","sendredirect.jsp")'>Logout</a></p>
</body>
</html>
<%
}
%>
