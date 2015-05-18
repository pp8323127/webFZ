<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="eg.zcrpt.*,java.sql.*"%>
<%
//助理座艙長報告--送出報告
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
ArrayList objAL = (ArrayList) session.getAttribute("zcreportobjAL"); 
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String sect = request.getParameter("port");
String purempn = request.getParameter("purempn");
if(objAL == null)
{
	ZCReport zcrt = new ZCReport();
    zcrt.getZCFltListForPR(fdate,fltno,sect,purempn);
	objAL = zcrt.getObjAL();
}

if ( sGetUsr == null | objAL == null) 
{		//check user session start first or not login
	response.sendRedirect("/webfz/FZ/sendredirect.jsp");
}
else
{
	String idx = request.getParameter("idx");
	ZCReportObj obj = (ZCReportObj) objAL.get(Integer.parseInt(idx));
	ArrayList crewListobjAL = new ArrayList();
	ArrayList fltIrrobjAL = new ArrayList();
	crewListobjAL = obj.getZccrewObjAL();
	fltIrrobjAL = obj.getZcfltirrObjAL();
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
<body>
<div align="center">
  <span class="style1">CABIN CREW DIVISION</span><p>
  <span class="style12">ZONE CHIEF'S TRIP REPORT
  </span></div>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
	  <td colspan="3"><div align="right"><a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="15" border="0" alt="列印"></a></div></td>
    </tr>
	<tr>
      <td><strong>Pur :</strong>&nbsp;&nbsp;<%=obj.getPsrempn()%>&nbsp;&nbsp; <%=obj.getPsrsern()%>&nbsp;&nbsp;<%=obj.getPsrname()%></td>
	  <td><strong>ZC  :</strong>&nbsp;&nbsp; <%=obj.getZcempn()%>&nbsp;&nbsp;<%=obj.getZcsern()%>&nbsp;&nbsp;<%=obj.getZcname()%>&nbsp;&nbsp;Group : <%=obj.getZcgrps()%></td>
	  <td><strong>CA  :</strong>&nbsp;&nbsp;<%=obj.getCpname()%>&nbsp;&nbsp;A/C &nbsp;<%=obj.getAcno()%></td>
    </tr>
    <tr>
      <td><strong>Date : </strong><%=obj.getFdate()%></td>
	  <td><strong>Fltno : </strong><%=obj.getFlt_num()%></td>
	  <td><strong>Sect : </strong> <%=obj.getPort()%></td>
    </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td height="37" colspan="4" valign="middle"><strong>I.Crew Duty & Grade : </strong>     
    <table width="100%"  border="1" align="center" cellpadding="0" cellspacing="0" >
    <tr bgcolor="#CCCCCC">
      <td><div align="center" class="style5 style6 style8">Duty</div></td>
      <td><div align="center" class="style10">S.No.</div></td>
      <td><div align="center" class="style10">Name</div></td>
      <td><div align="center" class="style10">GRP</div></td>
	  <td><div align="center" class="style10">GRD</div></td>
      <td><div align="center" class="style10">B/P</div></td>
	  <td><div align="center" class="style10">Duty</div></td>
      <td><div align="center" class="style10">S.No.</div></td>
      <td><div align="center" class="style10">Name</div></td>
      <td><div align="center" class="style10">GRP</div></td>
	  <td><div align="center" class="style10">GRD</div></td>
      <td><div align="center" class="style10">B/P</div></td>
    </tr>
<%
for(int i=0; i<20; i++)
{
	if(i < crewListobjAL.size())
	{
		ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);
		if((i+1)%2==1)
		{
			out.println("<tr>");
		}
%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" class="style4">&nbsp;<%=zccrewobj.getDuty()%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;<%=zccrewobj.getSern()%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;<%=zccrewobj.getCname()%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;<%=zccrewobj.getGrp()%></div></td>
	  <td height="26"><div align="center" class="style4">&nbsp;<%=zccrewobj.getScore()%></div></td>
      <td height="26"><div align="center" class="style4">&nbsp;
	  <%
		  if("Y".equals(zccrewobj.getBest_performance()))
			out.print("*"); 
		  else 
		    out.print("");
	  %>
	  </div></td>
	 <%
		if((i+1)%2==0)
		{
			out.println("</tr>");
		}
	}
	else
	{
		if((i+1)%2==1)
		{
			out.println("<tr>");
		}

%>
      <td height="26" bgcolor="#CCCCCC"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
      <td height="26"><div align="center" class="style4">&nbsp;</div></td>
	  <td height="26"><div align="center" class="style4">&nbsp;</div></td>
<%
		if((i+1)%2==0)
		{
			out.println("</tr>");
		}

	}
}
%>
   </table>
  </td>
 </tr>
</table>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
 <tr>
  <td height="37" colspan="4" valign="middle"><strong>II.Crew Performance : </strong>     
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
		<%
		int count_2=0;
		for(int i=0; i<crewListobjAL.size(); i++)
		{
			ZCReportCrewListObj zccrewobj = (ZCReportCrewListObj) crewListobjAL.get(i);
			ArrayList gradeAL = zccrewobj.getGradeobjAL();
			if(gradeAL.size()>0)
			{
				for( int j=0; j<gradeAL.size(); j++)
				{
					ZCGradeObj gradeobj = (ZCGradeObj) gradeAL.get(j);
					count_2++;
		%>
          <tr>
            <td width="12%"><span class="style21"><%=gradeobj.getCname()%></span></td>
            <td width="13%"><span class="style21"><%=gradeobj.getGddesc()%></span></td>
            <td width="75%"><span class="style21"><%=gradeobj.getComments()%></span></td>
          </tr>
		<%
				}
			}
		}
		if (count_2<=0)
		{
			%>
		  <tr>
			<td colspan="3">本欄空白</td>
		  </tr>
		<%
		}
		%>
        </table>
	  </td>
	 </tr>
  </table>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr valign="top">
      <td height="151" colspan="4" valign="top"><strong>III.Flight Irregularity : </strong>
        <table width="100%"  border="1" cellpadding="0" cellspacing="0">
		<%
		int count_3=0;
		if(fltIrrobjAL.size()>0)
		{
			for(int i=0; i<fltIrrobjAL.size(); i++)
			{
				ZCFltIrrItemObj fltirrobj = (ZCFltIrrItemObj) fltIrrobjAL.get(i);
		%>
          <tr>
            <td width="15%"><div align="center"><span class="style21"><%=fltirrobj.getItemdsc2()%></span></div></td>
            <td width="20%"><div align="center"><span class="style21"><%=fltirrobj.getItemdsc()%></span></div></td>
            <td width="65%"><span class="style21"><%=fltirrobj.getComments()%></span></td>
          </tr>
		<%
			}
		}
		else
		{
%>
		  <tr>
            <td colspan="3">本欄空白</td>
          </tr>
<%
		}
%>
        </table>
	</td>
</tr>
</table>
</body>
</html>
<%
}	
%>