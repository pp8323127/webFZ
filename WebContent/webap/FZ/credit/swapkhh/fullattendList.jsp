<%@page contentType="text/html; charset=big5" language="java" import="eg.off.quota.*, eg.*,tool.*"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../preCheckAC.jsp");
} 
%>
<html>
<head>
<title>Full Attendance Lisst</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> 
<%
SkjPickList spl = new SkjPickList();
spl.getSkjPickList("ALL",userid);
ArrayList objAL = spl.getObjAL();
%>
  <table width="80%" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
	  <td colspan="8" align="center">
	  <font face="Comic Sans MS" color="#003399">���Կ�Z����</font>
	  </td>
	</tr>
	<tr valign="top">
	  <td colspan="8" align="center">
	  <font face="Comic Sans MS" color="#003399">���ӽЬ���</font>
	  </td>
	</tr>
	<tr height ="20">
	  <td class="tablehead3" align="center" colspan= "2">SEQNO</td>
	  <td class="tablehead3" align="center" colspan= "2">���Զ}�l��</td>
	  <td class="tablehead3" align="center" colspan= "2">���Ե�����</td>
	  <td class="tablehead3" align="center" colspan= "2">&nbsp;</td>
	</tr>
	<tr valign="top">
	  <td colspan="8" align="center">
	  <font face="Comic Sans MS" color="#003399">���Կ�Z����</font>
	  </td>
	</tr>
	<tr height ="20">
	  <td class="tablehead3" align="center" colspan= "1">SEQNO</td>
	  <td class="tablehead3" align="center" colspan= "1">���u��</td>
	  <td class="tablehead3" align="center" colspan= "1">�m�W</td>
	  <td class="tablehead3" align="center" colspan= "1">�ӽФ���ɶ�</td>
	  <td class="tablehead3" align="center" colspan= "1">����]</td>
	  <td class="tablehead3" align="center" colspan= "1">���ĻP�_</td>
	  <td class="tablehead3" align="center" colspan= "1">���Զ}�l��</td>
	  <td class="tablehead3" align="center" colspan= "1">���Ե�����</td>
	</tr>
<%
int count=0;
if(objAL.size()>0)
{
	for (int i=0; i<objAL()-1 ; i++)
	{
		objAL obj = (SkjPickObj) objAL.get(i);
		if("Y".equals())
		{	
			count++;
%>
		<tr>
			<td bgcolor="#FFCCFF" class="txtblue"><%=count%></strong></td>
			<td bgcolor="#FFCCFF" class="txtblue"><%=obj.getEmpno()%>(<%=obj.getSern()%>)</td>
			<td bgcolor="#FFCCFF" class="txtblue"><%=obj.getCname()%></td>
			<td bgcolor="#FFCCFF" class="txtblue"><%=obj.getNew_tmst()%></td>
			<td bgcolor="#FFCCFF" class="txtblue"><%=obj.getReason()%></td>
			<td bgcolor="#FFCCFF" class="txtblue"><%=obj.getValid_ind()%></td>
			<td bgcolor="#FFCCFF" class="txtblue"><%=obj.getSdate()%></td>
			<td bgcolor="#FFCCFF" class="txtblue"><%=obj.getEdate()%></td>
	     </tr>
<%
		}
}
else
{
%>
	<tr>
	<td colspan="8" align="center" valign="middle" class="btm">No data found!!
	<td>
	</tr>
<%
}
%>
</table>
</body>
</html>