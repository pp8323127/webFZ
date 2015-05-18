<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("logout.jsp");
} 
else
{

String unitCD = (String) session.getAttribute("Unitcd");// get Unit Code
String  group = (String) session.getAttribute("group");//get CSOZEZ group
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>SFLY Menu</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function load(w1,w2)
{
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
.style3 {font-size: 12px}
-->
</style>
</head>

<body bgcolor="#BBE8F7">
<p align="left"><img src="images/cball.gif" width="14" height="14" border="0"><a href="#" class="style1" onClick="load('blank.htm','PRSFlyMenu.jsp')" ><span class="txtblue"><strong>Cabin Safety Check </strong></span></a></p>
<p align="left"><img src="images/cball.gif" width="12" height="12" border="0"><a href="#" class="style1" onClick="load('blank.htm','Self_Inspect/selfInspectionMenu.jsp')" ><span class="txtblue"><strong>Self Inspection</strong></span></a></p>
<p align="left"><img src="images/cball.gif" width="12" height="12" border="0"><a href="#" class="style1" onClick="load('blank.htm','PRfunc_eval/PRfunc_evalMenu.jsp')" ><span class="txtblue"><strong>CM Evaluation</strong></span></a></p>
<p align="left"><img src="images/messagebox_info.png" width="16" height="16" border="0"><a href="#" class="style1" onClick="load('caseStatusQuery.htm','blank.htm')" ><span class="txtblue"><strong>Case Status</strong></span></a></p>

<hr>
<p align="left"><img src="images/cball.gif" width="12" height="12" border="0"><a href="#" class="style1" onClick="load('blank.htm','PRbrief_eval/PRbrief_evalMenu.jsp')" ><span class="txtblue"><strong>CM Brief Evaluation</strong></span></a></p>
<p>&nbsp;</p>
<p><img src="images/logout.gif" width="21" height="21" border="0"><a href="#" class="txtblue" onClick="javascript:self.location='logout.jsp'">Logout </a></p>
</body>
</html>
<%
}	
%>
