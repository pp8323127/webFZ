<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,java.util.ArrayList" %>
<%
/*
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}
*/

String fdate_y  =   request.getParameter("fdate_y");
String fdate_m  =   request.getParameter("fdate_m");
String fdate_d  =   request.getParameter("fdate_d");
String allFltno =	request.getParameter("allFltno");
String purserName	= request.getParameter("purserName");
String inspector	= request.getParameter("inspector");

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>GO TO EMPTY SELF INSPECTION LIST REPORT</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
<style type="text/css">
<!--
.style5 {
	color: #FF9900;
	font-weight: bold;
	font-size: 16px;
}
-->
</style>
</head>

<body>
 <div align="center"><span class="style5"><a href="#" class="txtred" onClick="load('blank.htm','Self_Inspect/emptySILReport.jsp?allFltno=<%=allFltno%>&fdate_y=<%=fdate_y%>&fdate_m=<%=fdate_m%>&fdate_d=<%=fdate_d%>&purserName=<%=purserName%>&inspector=<%=inspector%>')">to get an  EMPTY SELF INSPECTION LIST REPORT </a></span>  
<MARQUEE BEHAVIOR=ALTERNATE><span class="txtred">↑Continue to Click</span>
</MARQUEE> </div>
</body>
</html>
