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
String proj_no = request.getParameter("proj_no");
String fleet = request.getParameter("fleet");
String acno = request.getParameter("acno");
boolean ifD = false; //是否為追蹤考核

PRPJIssue psf = new PRPJIssue();
ArrayList bankItemobjAL = new ArrayList();
ArrayList objAL = new ArrayList();
psf.getBankItemno(proj_no);//blank 
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
	  <td><div class = "txtblue" align="right">
	  <a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="20" border="0" alt="列印"></a></div></td>
	</tr>
</table>
<table width="80%" border="1" align="center" cellpadding="0" cellspacing="0" >
	<tr class="tablehead2">
	  <td><div class = "txtblue" align="center">&nbsp;</div></td>
	  <td><div class = "txtblue" align="center">Issue Description</div></td>
	</tr>
<%
int seq = 0;
for(int i=1; i<bankItemobjAL.size(); i++)
{
	PRPJIssueObj objp = (PRPJIssueObj) bankItemobjAL.get(i-1);
	PRPJIssueObj obj = (PRPJIssueObj) bankItemobjAL.get(i);
	
	if(!obj.getProj_no().equals(objp.getProj_no()))
	{
		seq = 0;
%>
	<tr class="btm">
	  <td><div class = "txtblue" align="center">Event</div></td>
	  <td><div class = "txtblue" align="left">
<%
	if("D".equals(obj.getKin()))
	{
		ifD = true;
		EGInfo egi = new EGInfo(obj.getEmpno());
		EgInfoObj empobj = egi.getEGInfoObj(obj.getEmpno()); 
%>
	  <font color="red">Checkee : <%=obj.getEmpno()%>(<%=empobj.getSern()%>) <%=empobj.getCname()%></font><br>
<%
	}
%>	  
	  <%=obj.getProj_event()%></div></td>
	</tr>
	<tr>
	  <td><div class = "txtblue" align="center"><%=(++seq)%></div></td>
	  <td><div class = "txtblue" align="left">&nbsp;<%=obj.getBankdesc()%></div></td>
	</tr>
<%
	}
	else
	{
%>
	<tr>
	  <td><div class = "txtblue" align="center"><%=(++seq)%></div></td>
	  <td><div class = "txtblue" align="left">&nbsp;<%=obj.getBankdesc()%></div></td>
	</tr>
<%	
	}
}//for(int i=0; i<bankItemobjAL.size(); i++)	
%>
</table>
<%
if(ifD==true)
{
%>
<p><p>
<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" >
	<tr>
	  <td><div class = "txtxred" align="left">* 為提昇輔導與矯正績效，辦公室期待您對本追蹤考核作業以公正、客觀的方式親自進行觀察與記錄，並謝謝您的費心。<br>
	    * 為尊重被追蹤考核者，請您務必謹守業務機密，勿委由ZC以外之其他組員代為執行，或是與其他組員討論。<br>* 如您欲對該名組員進一步瞭解，也歡迎您與該員所屬組別聯絡。
	謝謝您！</div></td>
	</tr>
</table>
<%
}	
%>
</body>
</html>
