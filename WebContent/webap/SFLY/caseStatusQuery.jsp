<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.net.URLEncoder" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String uid = (String) request.getParameter("uid");
String from_url = (String) request.getParameter("from_url");

if (userid == null && uid == null) 
{		
	response.sendRedirect("logout.jsp");
}

if("WEBEG".equals(from_url))
{
	session.setAttribute("userid",uid);
}
%>
<html>
<head>
<title>Schedule Query</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href= "style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="calendar2.js"></script>
<script src="js/showDate.js"></script>
<style type=text/css>
<!--
BODY{margin:0px;/*內容貼緊網頁邊界*/}
.style1 {
	color: #9900FF;
	font-weight: bold;
	font-family: Arial, Helvetica, sans-serif;
}
.style2 {color: #FFFFFF}
.style3 {color: #0000FF}
.style5 {color: #0000FF; font-weight: bold; font-family: Arial, Helvetica, sans-serif; }
-->
</style>
</head>
<body>
<div align="center">
<p>
<form name="form1" method="post" target="mainFrame" action="case_status_info.jsp">
  <p><span class="style1">Query Period</span>     
  <span class="txtblue">From</span>     
  	<input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue"> 			
	<img height="20" src="images/p2.gif" width="20" onClick ="cal1.popup();">&nbsp;     
    <span class="txtblue">To</span> 
  	<input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue"> 			
	<img height="20" src="images/p2.gif" width="20" onClick ="cal2.popup();"> 
   <span class="txtred">*格式：yyyy/mm/dd。</span> &nbsp;
  <input type="submit" name="Submit" value="Query">
  </form>
</div>
</body>
</html>
<script  type="text/javascript" language="javascript">
	var cal1 = new calendar2(document.forms[0].elements['sdate']);
	cal1.year_scroll = true;
	cal1.time_comp = false;
	document.getElementById("sdate").value =cal1.gen_date(new Date());

	var cal2 = new calendar2(document.forms[0].elements['edate']);
	cal2.year_scroll = true;
	cal2.time_comp = false;
	document.getElementById("edate").value =cal2.gen_date(new Date());
</script>
