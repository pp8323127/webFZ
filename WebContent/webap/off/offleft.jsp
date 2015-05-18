<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.*,java.util.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String userip = request.getRemoteAddr();

if (session.isNew() || userid == null) 
{
	response.sendRedirect("sendredirect.jsp");

} 
else
{
EGInfo egi = new EGInfo(userid);
ArrayList objAL2 = new ArrayList();
objAL2 = egi.getObjAL();
EgInfoObj obj2 = new EgInfoObj();
if(objAL2.size()>0)
{
	obj2 = (EgInfoObj) objAL2.get(0);
}        
// EG status, 1=在職
String egStatus = obj2.getStatus();
%>
<html>
<head>
<title>off menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<SCRIPT Language="JavaScript" type="text/javascript">
function load(w1,w2)
{
	parent.topFrame.location.href=w1;
	parent.mainFrame.location.href=w2;
}

function logout()
{	
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
<br>
<%
//在職者才能使用年假功能
if("1".equals(egStatus))
{
%>	
	<img src="../FZ/img2/we.gif" width="16" height="16">&nbsp;組員請休假<br>
	<li><a href="#"  onClick='load("blank.htm","offsheetQuery.jsp")'><div class="n"id="n27">Enquery off records</div></a><br>
	<li><a href="#"  onClick='load("blank.htm","AL/aloffsheet.jsp")'><div class="n"id="n27">AL/XL </div></a><br>
<%
	//if("192.168".equals(userip.substring(0,7)) | "10.18".equals(userip.substring(0,5))) --cs40 modified 2010/3/14
	if("192.168".equals(userip.substring(0,7)) | "10.16".equals(userip.substring(0,5))) 
	{	
	%>
		<li><a href="#"  onClick='load("blank.htm","Leave/leaveoffsheet.jsp")'><div class="n"id="n27">SL/PL/EL/WL/FL</div></a><br>
		<li><a href="#"  onClick='load("Leave/offEmpno.jsp","blank.htm")'><div class="n"id="n27">代填假單</div></a><br>
	<%
	}
}
else
{
%>	
	<img src="../FZ/img2/we.gif" width="16" height="16">&nbsp;<a href="#"  onClick='load("blank.htm","noALMessage.htm")'><div class="n"id="n27">組員請休假</div></a><br>
<%

}
%>	
	<img src="../FZ/img2/Security.gif" width="16" height="16">&nbsp;<a href="#"  onClick="logout()"><div class="n" id="n0">登出</div></a> 


</body>
</html>
<%
}
%>