<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="java.sql.*, java.util.Date,fz.*"%>
<html>
<head>
<title>�H�e�Z��</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link rel="stylesheet" href="menu.css" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function abc() {
if(document.layers) eval('document.layers["load"].visibility="hidden"')
else eval('document.all["load"].style.visibility="hidden"');
}

if(document.layers) document.write('<layer id="load" z-index=1000>');
else document.write('<div id="load" style="position: absolute;width: 100% ; height: 110% ; top: 0px; left: 0px;z-index:1000px;">');
/*
document.write(" <center>");
document.write("  <table border=0 cellpadding=0 cellspacing=0 style='border-collapse: collapse' width='505'>");
document.write("    <tr><br><br><br><br><br> ");
document.write("      <td align='center' width='505' nowrap> ");
*/
document.write("        <p align='center'><font face='Arial, Helvetica, sans-serif' size='3'><b><strong>��Z��H�e���A�]�խ��H�Ʋ��h�A�Э@�ߵy��.....</strong></font></td>");
/*
document.write("    </tr>");
document.write("    <tr> ");
document.write("      <td align='center' width='505' nowrap> ");
document.write("        <form name='loaded'>");
document.write("          <div align=center> ");
document.write("            <p>");
document.write("              &nbsp;<input name='chart' size='100' style='border:1px ridge #000000; background-color: #FFFFFF; color: #000000; font-family: Arial; font-size:8 pt; padding-left:4; padding-right:4; padding-top:1; padding-bottom:1'>&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input name='percent' size='8' style='border:1px ridge #000000; color: #000000; text-align: center; background-color:#FFFFFF'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
*/
var bar = 0
var line = ' |'
var amount =' |'
count()
function count(){
	/*bar= bar+1
	amount =amount  +  line
	document.loaded.chart.value=amount
	document.loaded.percent.value=bar+'%'
	if (bar<99)
	{setTimeout('count()',5);}*/
}
/*
document.write("            </p>");
document.write("          </div>");
document.write("        </form>");
document.write("        <p align='center'></p>");
document.write("      </td>");
document.write("    </tr>");
document.write("  </table>");
document.write(" </center>");
*/
if(document.layers) document.write('</layer>');
else document.write('</div>');

</script>
<style type="text/css">
<!--
.style1 {
	font-size: 16px;
	color: #0033CC;
	font-family: "�ө���", "�s�ө���", "Courier New";
	font-weight: bold;
}
-->
</style>
</head>
<%
out.flush();
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
  %> <jsp:forward page="sendredirect.jsp" />
<%
} 
//out.flush();
String y = request.getParameter("sely");
String m = request.getParameter("selm");
String ym = y+"/"+m;
String tfilepath = application.getRealPath("/")+"/sendlog.txt";
try{
	sendMail sm = new sendMail();
	String messge = sm.sendSche(ym, tfilepath);
	%>
	<body ><br>
<br>
<br>

	<div align="center"><span class="style1">�H�e�����A�`�@�H�X&nbsp; <%=messge%>&nbsp;���Z��C</span>  
	  <%
}
catch (Exception e){
%>
      <jsp:forward page="err.jsp" />
       
      <%	  
}
%>
    </div>
	</body>
</html>
<script lanquag="JAVASCRIPT">
	abc();
</script>
