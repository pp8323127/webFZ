<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.*,java.sql.*,java.util.*,java.text.DateFormat,ci.db.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (session.isNew() || userid == null) {
	response.sendRedirect("sendredirect.jsp");

} else{


%>
<html>
<head>
<title>function screen(AC)</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<SCRIPT Language="JavaScript" type="text/javascript">

function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
function logout(){	
	top.location.href="sendredirect.jsp";
}


</script>
<SCRIPT Language="JavaScript" type="text/javascript" src="Language.js"></script>
<style type="text/css">
body,table,input {
	font-family: Verdana;
	font-size: 10pt;
}
body{
	background-color:#B1D3EC	;
	margin:2pt;
}
.n{
	display:inline;
}
.e4 {
	background-color: #edf3fe;
	color: #000000;
	text-align: center;
}

a:link,a:visited {  color: blue; text-decoration: none;}
a:hover,a:active {  color: #FFFFFF ;background-color: #0066B2	;  text-decoration: none; }
img{
	border:0pt;
}
</style>

</head>



<body >

<table border="0" cellpadding="0" cellspacing="0" width="185">
  <tr>
    <td>&nbsp;</td>
    <td>
		<img src="img2/doc.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("pr_interface/simchk_querycond.jsp","blank.htm")'>SIM Check </a><br>
		  <br>
		  	<img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#" onClick='load("blank.htm","resetCIAPW.jsp")'><div class="n"id="n23">重設 CIA 密碼</div></a><br>

		  <br>
		
		 <img src="img2/Security.gif" width="16" height="16">&nbsp;<a href="#"  onClick="logout()">登出</a><br>
		  <br>
		  <br>
		  <br>
		  <input type="button"  class="e4" onClick="javascript:window.open('http://cia.china-airlines.com');" value=" CIA 班表查詢"  >
	</td>
  </tr>
</table>

	
	
<br>
&nbsp;&nbsp;&nbsp;<br>
<br>
&nbsp;&nbsp;&nbsp;<br>



</body>

</html>
<%
}
%>
