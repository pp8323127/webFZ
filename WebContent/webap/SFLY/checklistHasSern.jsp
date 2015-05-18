<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}

isNewCheckForSFLY check = new isNewCheckForSFLY();
boolean isNew = check.checkTime("", "");//yyyy/mm/dd

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Check List Insert has same Sernno</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
<style type="text/css">
<!--
.style3 {color: #3366FF}
.style4 {color: #3165FF}
.style5 {
	color: #CC0066;
	font-weight: bold;
}
.style10 {color: #FF0000}
.style11 {
	color: #424984;
	font-weight: bold;
}
.style12 {color: #424984}
-->
</style>
</head>
<br>
<br>
<table width="80%" border="0" align="center" class="table_no_border">
	<tr>
		<td><p align="left" class="style3">
			<span class="style4">&nbsp;</span><span class="txttitletop style10"><span class="style11">This
						Cabin Safety Check List</span> has same flight record <span class="style12">in data base!!</span></span>
			</p>
			<p align="left">
				<span class="style4">&nbsp;</span><span class="txtblue">
					Please use&nbsp; <a href="#"
					onClick="load('blank.htm','fltInfo.jsp')"><strong><u>Insert/Modify
								List</u></strong></a> &nbsp;function to update this list!
				</span>
			</p></td>
	</tr>
	<tr>
		<td height="79" align="center" valign="bottom"><p align="left"
				class="style4">
				&nbsp; <span class="style5"><br> </span><span
					class="txttitletop style10">&nbsp;&nbsp;&nbsp;or</span>
			</p>
			<p align="left">
				<span class="style4">&nbsp;&nbsp;</span><span class="txtblue">use&nbsp;
					<a href="#" onClick="load('schFltDate.htm','blank.htm')"><strong><u>View/Print
								List </u></strong></a> &nbsp;function to view this list
				</span>
			</p>
			<p align="left" class="style4">&nbsp;</p></td>
	</tr>
</table>

</body>
</html>
