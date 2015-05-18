<%@page contentType="text/html; charset=big5" language="java" import="credit.*,eg.GetEmpno"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String fullUCD = (String) session.getAttribute("fullUCD") ; 
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 
ArrayList objAL = new ArrayList();
String empno = request.getParameter("empno");
String sdate = request.getParameter("sdate");
String edate = request.getParameter("edate");
String base = request.getParameter("base");
String groups = request.getParameter("groups");
%>
<html>
<head>
<title>New credit List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<script src="../subWindow.js" type="text/javascript"></script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style></head>
<body bgcolor="#FFFFFF" text="#000000" align= "center">
<div align="center">
<%
CreditList cl = new CreditList();
empno = GetEmpno.getEmpno(empno);
cl.getNewCreditList(sdate,edate,base); 
objAL = cl.getObjAL();
//out.println(objAL.size());
//out.println("<br>"+cl.getSQL());
%>
</div>
<div width="95%" align="center">
	<font face="Comic Sans MS" color="#003399"><%=sdate%> ~ <%=edate%> 新增積點明細</font>
</div>
<div align="center">
    <table width="95%" border="1" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td class="tablehead3 txtblue" align="center" colspan= "1">#</td>
		<td class="tablehead3 txtblue" align="center" colspan= "1">積點序號</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">員工號(序號)</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">姓名</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">積點分類</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">使用期限</td>
		<td class="tablehead3 txtblue" align="center" colspan= "1">是否使用</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">新增人員</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">新增時間</td>	    
		<td class="tablehead3 txtblue" align="center" colspan= "1">說明</td>
	   </tr>
  <%
int count=0;
if(objAL.size()>0)
{
	String trbgcolor = "";
	for (int i=0; i<objAL.size() ; i++)
	{
		boolean ifshow = false;
		CreditObj obj = (CreditObj) objAL.get(i);
		
//*************************************************
		if("".equals(empno) || empno == null)
		{
			if("KHH".equals(base) && "H".equals(obj.getGroups()))
			{
				ifshow = true;
			}
			else if ("TPE".equals(base) && groups.equals(obj.getGroups()))
			{
				ifshow = true;
			}
			else if ("TPE".equals(base) && "ALL".equals(groups) && ("1".equals(obj.getGroups()) | "2".equals(obj.getGroups()) | "3".equals(obj.getGroups()) | "4".equals(obj.getGroups())))
			{
				ifshow = true;
			}			
			else
			{
				ifshow = false;
			}
		}
		else
		{//empno is not null
			if(empno.equals(obj.getEmpno()))
			{
				ifshow = true;
			}
			else
			{
				ifshow = false;
			}
		}

//*************************************************
		if(ifshow == true)
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
				  <td><%=obj.getSno()%></td>
				  <td><%=obj.getEmpno()%>(<%=obj.getSern()%>)</td>
				  <td><%=obj.getCname()%></td>
				  <td><%=obj.getReason()%></td>
				  <td>&nbsp;<%=obj.getEdate()%></td>				  
				  <td align="center"><%=obj.getUsed_ind()%></td>
				  <td align="center"><%=obj.getNewuser()%></td>
				  <td align="center"><%=obj.getNewdate()%></td>
				  <td width="20%">
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr><td class="txtblue">&nbsp;<%=obj.getComments()%></td></tr></table>
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
	  <td colspan="10" align="center" valign="middle" >No data found!!<td>
	  </tr>
  <%
}
%>
    </table>
</div>
</body>
</html>