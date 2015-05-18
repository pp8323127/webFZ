<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,java.sql.*,ci.db.ConnDB,fz.projectinvestigate.*,eg.*"%>
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
<script language="javascript" type="text/javascript">

</script>

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
String fleet = "";
String acno = "";

PRPJIssue pj = new PRPJIssue();
ArrayList objAL = new ArrayList();
pj.getPRProj(fltdt, fltno, sect,sGetUsr);
objAL = pj.getBankObjAL();      
if(objAL.size()>1)
{
	PRProjIssueObj obj = (PRProjIssueObj) objAL.get(1);
	fleet = obj.getFleet();
	acno = obj.getAcno();
}
%>
<body>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" >
	<tr>
	  <td><div class = "txtblue" align="center">Fltdt : <%=fltdt%></div></td>
	  <td><div class = "txtblue" align="center">Fltno : <%=fltno%></div></td>
	  <td><div class = "txtblue" align="center">Sect  : <%=sect%></div></td>
	  <td><div class = "txtblue" align="center">Fleet : <%=fleet%></div></td>
	  <td><div class = "txtblue" align="center">Acno  : <%=acno%></div></td>
	</tr>
</table>

<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" >
	<tr class="tablehead2">
	  <td width = "5%"><div class = "txtblue" align="center">&nbsp;</div></td>
	  <td width = "15%"><div class = "txtblue" align="center">Issue Description</div></td>
	  <td width = "15%"><div class = "txtblue" align="center">Feedback</div></td>
	  <td width = "65%"><div class = "txtblue" align="center">Comments</div></td>
	</tr>
<%
int seq =0;
for(int i=1; i<objAL.size(); i++)
{
	PRProjIssueObj objp = (PRProjIssueObj) objAL.get(i-1);
	PRProjIssueObj obj = (PRProjIssueObj) objAL.get(i);
	if(!obj.getProj_no().equals(objp.getProj_no()))
	{
		seq = 0;
%>
	<tr class="btm">
	  <td><div class = "txtblue" align="center">Event</div></td>
	  <td colspan="3"><div class = "txtblue" align="left">
<%
	if("D".equals(obj.getProjtype()))
	{
		EGInfo egi = new EGInfo(obj.getChkempno());
		EgInfoObj empobj = egi.getEGInfoObj(obj.getChkempno()); 
%>
	  <font color="red">Check Crew : <%=obj.getChkempno()%>(<%=empobj.getSern()%>) <%=empobj.getCname()%></font><br>
<%
	}
%>	  
	  <%=obj.getProj_event()%></div></td>
	</tr>
<%
	}
%>
	<tr>
	  <td><div class = "txtblue" align="center"><%=(++seq)%></div></td>
	  <td><div class = "txtblue" align="left">&nbsp;<%=obj.getItemdesc()%></div></td>
	  <td><div class = "txtblue" align="left">&nbsp;<%=obj.getFeedback()%></div></td>
	  <td><div class = "txtblue" align="left">&nbsp;<%=obj.getComments()%></div></td>
	</tr>
<%	
}//for(int i=1; i<objAL.size(); i++)	
%>
</table>
<%
if(objAL.size()<=1)
{
%>
<br>
<div align = "center">
No Data Found!!
</div>
<%
}	
%>
</body>
</html>