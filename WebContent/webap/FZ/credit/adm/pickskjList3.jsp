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
String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String status = request.getParameter("status");
String userbase = "TPE";
if("635".equals(fullUCD))
{
	userbase ="KHH";
}
%>
<html>
<head>
<title>Request handled Pick SKj List</title>
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
	spl.getSkjPickList2("Y",status,fyy+fmm);
}
else
{
	empno = GetEmpno.getEmpno(empno);
	spl.getSkjPickList("ALL",empno);
}
objAL = spl.getObjAL();
%>
</div>
<div width="95%" align="center">
	<font face="Comic Sans MS" color="#003399">已處理選班紀錄</font>
</div>
<div align="center">
    <table width="95%" border="1" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td class="tablehead3 txtblue" align="center" colspan= "1">排序</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">員工號(序號)</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">姓名</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">資格</td>
		<td class="tablehead3 txtblue" align="center" colspan= "1">申請日</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">是否有效</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">處理人員</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">處理時間</td>
	    <td class="tablehead3 txtblue" align="center" colspan= "1">註解</td>
		<td class="tablehead3 txtblue" align="center" colspan= "1">修改</td>
	   </tr>
  <%
int count=0;
if(objAL.size()>0)
{
	String trbgcolor = "";
	for (int i=0; i<objAL.size() ; i++)
	{
		SkjPickObj obj = (SkjPickObj) objAL.get(i);
		if(!"".equals(obj.getEd_user()) && obj.getEd_user() != null && userbase.equals(obj.getBase()))
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
				  <td><%=obj.getEmpno()%>(<%=obj.getSern()%>)</td>
				  <td><%=obj.getCname()%></td>
				  <td><%=obj.getReason()%></td>
				  <td><%=obj.getNew_tmst()%></td>
				  <td align="center"><%=obj.getValid_ind()%></td>
				  <td align="center"><%=obj.getEd_user()%></td>
				  <td align="center"><%=obj.getEd_tmst()%></td>
				  <td width="20%">
					  <table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr><td class="txtblue"><%=obj.getComments()%></td></tr></table>
				  </td>
				  <td align="center"><a href="#" onClick="subwinXY('modpick_ed.jsp?sno=<%=obj.getSno()%>&empno=<%=empno%>&fyy=<%=fyy%>&fmm=<%=fmm%>&status=<%=status%>','fItem','800','250')"><img src="../../images/red.gif" width="15" height="15" border="0" alt="Handle"></a>
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
	  <td colspan="11" align="center" valign="middle" >No data found!!<td>
	  </tr>
  <%
}
%>
    </table>
</div>
</body>
</html>