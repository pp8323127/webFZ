<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,java.sql.*,ci.db.ConnDB,fz.psfly.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {
	font-size: x-large;
	font-weight: bold;
}
.style4 {font-size: medium}
.style5 {
	font-size: x-small;
	font-weight: bold;
}
.style6 {font-size: small}
.style8 {color: #000000}
.style10 {font-size: small; font-weight: bold; color: #000000; }
.style12 {font-size: medium; font-weight: bold; }
.style13 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
}
.style15 {font-size: 12px; font-weight: bold; }
.style16 {font-size: 12px}
.style21 {font-family: Arial, Helvetica, sans-serif; font-size: 14px; }
-->
</style>
</head>
<%
String fltdt = request.getParameter("fltdt");//yyyy/mm/dd
String fltno = request.getParameter("fltno");//006
String sect = request.getParameter("sect");//TPELAX
String topic_no = request.getParameter("topic_no");
String fleet = request.getParameter("fleet");
String acno = request.getParameter("acno");

PRSFlyIssue psf = new PRSFlyIssue();
ArrayList bankItemobjAL = new ArrayList();
ArrayList objAL = new ArrayList();
psf.getBankItemno(topic_no);//blank 
bankItemobjAL = psf.getBankObjAL();
%>
<body>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" >
	<tr>
	  <td><div class = "txtblue" align="center">Fltdt : <%=fltdt%></div></td>
	  <td><div class = "txtblue" align="center">Fltno : <%=fltno%></div></td>
	  <td><div class = "txtblue" align="center">Sect  : <%=sect%></div></td>
	  <td><div class = "txtblue" align="center">Fleet : <%=fleet%></div></td>
	  <td><div class = "txtblue" align="center">Acno  : <%=acno%></div></td>
	</tr>
</table>
<table width="80%" border="1" align="center" cellpadding="0" cellspacing="0" >
	<tr class="tablehead2">
	  <td><div class = "txtblue" align="center">Seq.</div></td>
	  <td><div class = "txtblue" align="center">Issue No</div></td>
	  <td><div class = "txtblue" align="center">Issue Description</div></td>
	  <td><div class = "txtblue" align="center">Inspection Duty</div></td>
	</tr>
<%
for(int i=0; i<bankItemobjAL.size(); i++)
{
	String check_duty="ALL";
	PSFlyIssueObj obj = (PSFlyIssueObj) bankItemobjAL.get(i);
	if(!"".equals(obj.getCheck_duty()) && obj.getCheck_duty() != null)
	{
		check_duty = obj.getCheck_duty();
	}
%>
	<tr>
	  <td><div class = "txtblue" align="center"><%=(i+1)%></div></td>
	  <td><div class = "txtblue" align="center"><%=obj.getTopic_no()%>-<%=obj.getItemno()%></div></td>
	  <td><div class = "txtblue" align="left">&nbsp;<%=obj.getItemdesc()%></div></td>
	  <td><div class = "txtblue" align="left">&nbsp;<%=check_duty%></div></td>
	</tr>
<%
}//for(int i=0; i<bankItemobjAL.size(); i++)	
%>
</table>
</body>
</html>
