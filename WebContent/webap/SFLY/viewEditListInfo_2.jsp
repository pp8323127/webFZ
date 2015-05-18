<%@page import="ws.prac.SFLY.MP.MPsflyRptFun"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}

String[] trip	=	request.getParameterValues("trip");
String[] fltno	=	request.getParameterValues("fltno");
String[] acno  =   request.getParameterValues("acno");
String[] fleet =   request.getParameterValues("fleet");

String pursern  =   request.getParameter("pursern");
String purserName  = null;
String inspector  = null;
String fltd  =   request.getParameter("sdate");
String fdate_y  =   fltd.substring(0,4);
String fdate_m  =   fltd.substring(5,7);
String fdate_d  =   fltd.substring(8,10);

String allSector = "";
for(int i=0;i<trip.length;i++)
{
	if(trip[i] != null && !"".equals(trip[i])){
		if(i==0)
			allSector = (String)trip[i];
		else
			allSector +="/"+trip[i];
	}
}

String allFltno = "";
for(int i=0;i<fltno.length;i++)
{
	if(fltno[i] != null && !"".equals(fltno[i])){
		if(i==0)
			allFltno = (String)fltno[i];
		else
			allFltno +="/"+fltno[i];
	}
}

String allFleet = "";
for(int i=0;i<fleet.length;i++){
	if(fleet[i] != null && !"".equals(fleet[i])){
		if(i==0)
			allFleet = (String)fleet[i];
		else
			allFleet +="/"+fleet[i];
	}
}

String allAcno = "";
for(int i=0;i<acno.length;i++){
	if(acno[i] != null && !"".equals(acno[i])){
		if(i==0)
			allAcno = (String)acno[i];
		else
			allAcno +="/"+acno[i];
	}
}
MPsflyRptFun sfly = new MPsflyRptFun();
String sernno = "";
sfly.getMpSflySeqno(fltd, allSector, allFltno, userid, allFleet, allAcno);
if("Y".equals(sernno)){
	sernno = sfly.getSeqno();
	sfly.getCabinSafety(sernno);
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>View eidt Cabin Safey check List Info</title>
<link href= "style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style3 {
	font-family: Arial, Helvetica, sans-serif;
	color: #000000;
	font-size: 14px;
}
.style5 {color: #FFFFFF}
.style6 {color: #FFFFFF; font-size: 14px; }
.style7 {
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<br>
<%
if(sernno != null && !"".equals(sernno)){
%>
<table width="60%" border="0" align="center" class="table_no_border">
<tr>
	<td class="txtblue"><div align="center">&nbsp;<span class="style7">Please click the LINK to modify the data!
     </span></div></td>
</tr>
</table>
<br>
	
<table width="60%" border="0" align="center" class="tablebody">
	<tr class="tablehead">
		<td width="30%" class="table_head"><div align='center' class="style6">Flight Date</div></td>
		<td width="60%" class="table_head"><div align="center" class="style6">Flight NO.</div></td> 
	</tr>
	<tr >
		<td  Align="Center"><%=sfly.getsChkR().getFltd()%></td>
		<td  Align="Center"><a href="editListData.jsp?sernno=<%=sfly.getsChkR().getFltd()%>&sector=<%=allSector%>&fltno=<%=allFltno%>&pursern=<%=pursern%>&acno=<%=allAcno%>&fleet=<%=allFleet%>&fdate_y=<%=fdate_y%>&fdate_m=<%=fdate_m%>&fdate_d=<%=fdate_d%>"><%=sfly.getsChkR().getFltno()%></a></td>
	</tr>
<%
session.setAttribute("cabinSafety", sfly.getsChkR());
}
else
{
%>
	<jsp:forward page="checklist_2.jsp">
	<jsp:param name="fltd" value="<%=fltd%>" />
	<jsp:param name="sector" value="<%=allSector%>" />
	<jsp:param name="fltno" value="<%=allFltno%>" />
	<jsp:param name="acno" value="<%=allAcno%>" />
	<jsp:param name="fleet" value="<%=allFleet%>" />
	<jsp:param name="pursern" value="<%=pursern%>" />
	</jsp:forward>
<%		
}	

%>
</table>
</body>
</html>

