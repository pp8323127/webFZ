<%@page contentType="text/html; charset=big5" language="java" import="credit.*,eg.GetEmpno"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 
ArrayList objAL = new ArrayList();
String empno = request.getParameter("empno");
empno = GetEmpno.getEmpno(empno);

%>
<html>
<head>
<title>Request Pick SKj Lisst</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="../subWindow.js" type="text/javascript"></script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000" align= "center">
<div align="center">
<%
SkjPickList spl = new SkjPickList();
if(empno==null | "".equals(empno))
{
	spl.getSkjPickList("Y","");
}
else
{
	spl.getSkjPickList("Y",empno);
}
objAL = spl.getObjAL();
%>
</div>
<div width="80%" align="center">
	<font face="Comic Sans MS" color="#003399">待處理選班紀錄</font>
</div>
<div align="center">
    <table width="80%" border="1" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td class="tablehead" align="center" colspan= "1">排序</td>
	    <td class="tablehead" align="center" colspan= "1">姓名<br>員工號<br>(序號)</td>
	    <td class="tablehead" align="center" colspan= "1">資格<br>(積點編號)</td>	
	    <td class="tablehead" align="center" colspan= "1">全勤起訖日</td>	
	    <td class="tablehead" align="center" colspan= "1">申請日</td>
	    <td class="tablehead" align="center" colspan= "1">註解</td>
	    <td class="tablehead" align="center" colspan= "1">選班處理</td>
	  </tr>
  <%
int count=0;
if(objAL.size()>0)
{
	String trbgcolor = "";
	for (int i=0; i<objAL.size() ; i++)
	{
		SkjPickObj obj = (SkjPickObj) objAL.get(i);
		if("".equals(obj.getEd_user()) | obj.getEd_user() == null)
		{
			if(count % 2 ==0)
			{
				trbgcolor = "#FFCCFF";
			}
			else
			{
				trbgcolor = "#FFFFFF";
			}
%>
			  <tr bgcolor='<%=trbgcolor%>' class="txtblue" align = "center">
				  <td><%=count+1%></td>
				  <td><%=obj.getCname()%><br><%=obj.getEmpno()%><br>(<%=obj.getSern()%>)</td>
				  <td><%=obj.getReason()%><br><%=obj.getcredit3()%></td>
				  <td>&nbsp;<%=obj.getSdate()%>~<%=obj.getEdate()%></td>
				  <td><%=obj.getNew_tmst()%></td>
				  <td width="20%">
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr><td class="txtblue"><%=obj.getComments()%></td></tr></table>
				  </td>
				  <td align="center"><a href="#" onClick="subwin('modpick.jsp?sno=<%=obj.getSno()%>','fItem','600','700')"><img src="../../images/red.gif" width="15" height="15" border="0" alt="Handle"></a>
				</td>
		      </tr>
  <%
			count ++;
		}
	}//for (int i=0; i<objAL()-1 ; i++)
}

if(count <=0)
{
%>
	  <tr>
	  <td colspan="6" align="center" valign="middle" >No data found!!<td>
	  </tr>
  <%
}
%>
    </table>
</div>
</body>
</html>