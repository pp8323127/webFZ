<%@page contentType="text/html; charset=big5" language="java"%>
<%@page import="fz.*,java.sql.*,java.util.*"%>
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
document.write("        <p align='center'><font face='Arial, Helvetica, sans-serif' size='3'><b><strong><br><br>�ɮ׻s�@���еy��.........................</strong></font></td>");
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
	font-family: "�з���";
	font-size: 22px;
}
-->
</style>
</head>

<%

String y = request.getParameter("sely");
String m = request.getParameter("selm");
String rs = null;

ccFlyPay fp = new ccFlyPay();

//�H�X�ɮ�
rs = fp.doFile(sGetUsr, y, m, application.getRealPath("/")+"/flypay.txt");

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
<p align="center" class="style2 style3">�}�ҥ����H�c</p>
<p align="center" class="style2"><a href="https://mail.cal.aero">Open cal.aero mail-box</a> </p>
</body>
</html>
<script lanquag="JAVASCRIPT">
	abc();
	alert("�ɮפw�H�X�ܱz�������H�c");
	//self.location="/webfz/ccflypay.txt";
</script>