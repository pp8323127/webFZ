<%@page contentType="text/html; charset=big5" language="java"%>
<%@page import="fz.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
%>
 <jsp:forward page="sendredirect.jsp" /> 
<%
} 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Make Text File</title>
<link href="../menu.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function abc() {
if(document.layers) eval('document.layers["load"].visibility="hidden"')
else eval('document.all["load"].style.visibility="hidden"');
}

if(document.layers) document.write('<layer id="load" z-index=1000>');
else document.write('<div id="load" style="position: absolute;width: 100% ; height: 110% ; top: 0px; left: 0px;z-index:1000px;">');
document.write("        <p align='center'><font face='Arial, Helvetica, sans-serif' size='3'><b><strong><br><br>班表寄送中請稍候.........................</strong></font></td>");
var bar = 0
var line = ' |'
var amount =' |'

if(document.layers) document.write('</layer>');
else document.write('</div>');

</script>
<style type="text/css">
<!--
.style2 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 18px;
}
.style3 {
	font-family: "標楷體";
	font-size: 22px;
}
-->
</style>
</head>

<%
String[] tempno = request.getParameterValues("tempno");
if (tempno==null)
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="Please select crew to send schedule" />
	<jsp:param name="messagelink" value="ReSelect" />
	<jsp:param name="linkto" value="javascript:history.go(-1)" />
	</jsp:forward>
   <% 
}
String y = request.getParameter("syear");
String m = request.getParameter("smonth");
if(m.length()<2) m = "0"+m;

sPersonal_sche sp = new sPersonal_sche();
String rs = sp.sendPS(y+"/"+m,sGetUsr,tempno);
if (!rs.equals("0"))
{
	%>
	<jsp:forward page="showmessage.jsp">
	<jsp:param name="messagestring" value="<%=rs%>" />
	</jsp:forward>
   <% 
}

out.flush();
%>
<body>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p align="center" class="style2 style3">開啟全員信箱</p>
<p align="center" class="style2"><a href="https://mail.cal.aero">Open cal.aero mail-box</a> </p>
</body>
</html>
<script lanquag="JAVASCRIPT">
	abc();
	alert("您的班表已寄出");
	//self.location="/webfz/ccflypay.txt";
</script>