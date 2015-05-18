<%@page contentType="text/html; charset=big5" language="java" import="credit.*"%>
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
<title>Credit List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000" align= "center">
<div align="center">
<%
CreditList cl = new CreditList();
cl.getCreditList("ALL",userid);
ArrayList objAL = new ArrayList();
objAL = cl.getObjAL();
%>
</div>
<div width="80%" align="center">
	<font face="Comic Sans MS" color="#003399">積點使用紀錄</font>
</div>
<div align="center">
    <table width="80%" border="1" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td class="tablehead3" align="center" colspan= "1">SEQNO</td>
	    <td class="tablehead3" align="center" colspan= "1">員工號</td>
	    <td class="tablehead3" align="center" colspan= "1">姓名</td>
	    <td class="tablehead3" align="center" colspan= "1">積點原因</td>
	    <td class="tablehead3" align="center" colspan= "1">積點有效日</td>
	    <td class="tablehead3" align="center" colspan= "1">使用目的</td>
	    <td class="tablehead3" align="center" colspan= "1">扣除與否</td>
	    <td class="tablehead3" align="center" colspan= "1">使用單號</td>
		<td class="tablehead3" align="center" colspan= "1">註解</td>
	  </tr>
  <%
int count=0;
if(objAL.size()>0)
{
	String trbgcolor = "";
	for (int i=0; i<objAL.size() ; i++)
	{
		CreditObj obj = (CreditObj) objAL.get(i);
		if("N".equals(obj.getUsed_ind()))
		{
			trbgcolor = "#FFCCFF";
		}
		else
		{
			trbgcolor = "#FFFFFF";
		}

%>
		  <tr bgcolor='<%=trbgcolor%>' class="txtblue">
			  <td><%=i+1%></td>
			  <td><%=obj.getEmpno()%>(<%=obj.getSern()%>)</td>
			  <td><%=obj.getCname()%></td>
			  <td><%=obj.getReason()%></td>
			  <td>&nbsp;<%=obj.getEdate()%></td>
			  <td>&nbsp;<%=obj.getIntention()%></td>
			  <td align="center"><%=obj.getUsed_ind()%></td>
			  <td>&nbsp;<%=obj.getFormno()%></td>
			  <td>&nbsp;<%=obj.getComments()%></td>
          </tr>
  <%
	}//for (int i=0; i<objAL()-1 ; i++)
}
else
{
%>
	  <tr>
	  <td colspan="9" align="center" class="txtxred" bgcolor="#CCCCFF">N/A<td>
	  </tr>
  <%
}
%>
    </table>
</div>
</body>
</html>