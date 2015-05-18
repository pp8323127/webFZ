<%@page contentType="text/html; charset=big5" language="java" import="credit.*,eg.crewbasic.*,eg.GetEmpno"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || userid == null) 
{		//check user session start first
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 

String empno = request.getParameter("empno");
empno = GetEmpno.getEmpno(empno);
%>
<html>
<head>
<title>Credit List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="../subWindow.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="../calendar2.js"></script>
<script language="JavaScript">
function f_submit()
{  
	document.form1.Submit.disabled=1;	
	 if(confirm("確定新增?"))
	 {
		return true;
	 }
	 else
	 {
		document.getElementById("Submit").disabled=0;
		return false;
	 }
}

function f_delclick(para1,para2)
{  
	 if(confirm("確定要刪除該筆記錄?"))
	 {
		 subwin("delcredit.jsp?sno="+para1+"&empno="+para2);
	 }
	 else
	 {
		return;
	 }
}

</script>

</head>
<body bgcolor="#FFFFFF" text="#000000" align= "center">
<%
CreditList cl = new CreditList();
cl.getCreditList("ALL",empno);
ArrayList objAL = new ArrayList();
objAL = cl.getObjAL();

CrewInfo c = new CrewInfo(empno);
CrewInfoObj o = c.getCrewInfo();
String cname = o.getCname();
String sern = o.getSern();
%>
<div width="95%" align="center">
	<font face="Comic Sans MS" color="#003399">新增積點</font>
</div>
<div align="center">
<form name="form1" method="post" action="inscredit.jsp" onSubmit="return f_submit();">
    <table width="95%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	    <td align="center" class="tablehead"><strong>員工號(序號)</strong></td>
	    <td align="center" class="tablehead"><strong>姓名</strong></td>
	    <td align="center" class="tablehead"><strong>積點原因</strong></td>
	    <td align="center" class="tablehead"><strong>積點有效日</strong></td>
		<td align="center" class="tablehead"><strong>註解</strong></td>
	  </tr>
	  <tr valign="top">
	    <td align="center" class="txtblue"><%=empno%>(<%=sern%>)</td>
	    <td align="center" class="txtblue"><%=cname%></td>
	    <td align="center" class="txtblue">			
		    <select name="reason" class="txtblue">
				<option value="1">銷售高手</option>
				<option value="2">額外換班單</option>
				<option value="3">飛時破百</option>
				<option value="4">其它換班單</option>
				<option value="5">其它選班單</option>
			</select>
		</td>
	    <td align="center" class="txtblue"><input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue" value="">&nbsp;&nbsp;<img height="16" src="../img/cal.gif" width="16" onclick="cal2.popup();"><br>ex:2008/01/01</td>
	    <td align="center" class="txtblue"><textarea name="comments" cols="20" rows="5" class="txtblue"></textarea></td>
	  </tr>
	</table>
	<br>
  <div align="center">
		<input type="hidden" name="empno" id="empno"  value="<%=empno%>">			
		<input type="submit" name="Submit" id="Submit" class="button1 txtblue" value="新增">		
  </div>
</form>
</div>
<hr width="95%">
<div width="95%" align="center">
	<font face="Comic Sans MS" color="#003399">積點使用紀錄</font>
</div>
<div align="center">
    <table width="95%" border="1" cellspacing="0" cellpadding="0">
	  <tr height ="20">
	    <td align="center" class="tablehead"><strong>排序</strong></td>
	    <td align="center" class="tablehead"><strong>姓名<br>員工號<br>(序號)</strong></td>
	    <td align="center" class="tablehead"><strong>積點編號</strong></td>
	    <td align="center" class="tablehead"><strong>積點原因</strong></td>
	    <td align="center" class="tablehead"><strong>積點有效日</strong></td>
	    <td align="center" class="tablehead"><strong>使用目的</strong></td>
	    <td align="center" class="tablehead"><strong>扣除與否</strong></td>
	    <td align="center" class="tablehead"><strong>使用單號</strong></td>
		<td align="center" class="tablehead"><strong>註解</strong></td>
		<td align="center" class="tablehead"><strong>更新人員</strong></td>
		<td align="center" class="tablehead"><strong>更新時間</strong></td>
		<td align="center" class="tablehead"><strong>修改</strong></td>
		<td align="center" class="tablehead"><strong>刪除</strong></td>
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
			  <td align="center"><%=i+1%></td>
			  <td align="center"><%=obj.getCname()%><br><%=obj.getEmpno()%><br>(<%=obj.getSern()%>)</td>
			  <td align="center"><%=obj.getSno()%></td>
			  <td align="center"><%=obj.getReason()%></td>
			  <td align="center">&nbsp;<%=obj.getEdate()%></td>
			  <td align="center">&nbsp;<%=obj.getIntention()%></td>
			  <td align="center"><%=obj.getUsed_ind()%></td>
			  <td align="center">&nbsp;<%=obj.getFormno()%></td>
			  <td width="20%">
				  <table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr><td class="txtblue"><%=obj.getComments()%></td></tr></table>
			  </td>
			  <td>&nbsp;<%=obj.getUpduser()%></td>
			  <td>&nbsp;<%=obj.getUpddate()%></td>
			  <td align="center"><a href="#" onClick="subwin('modcredit.jsp?sno=<%=obj.getSno()%>','fItem','600','700')"><img src="../../images/red.gif" width="15" height="15" border="0" alt="Modify"></a>
			  </td>
<%
if("N".equals(obj.getUsed_ind()))	
{
%>
			  <td align="center"><a href="#" onClick="f_delclick('<%=obj.getSno()%>','<%=empno%>')"><img src="../../images/cancel_16x16.png" width="15" height="15" border="0" alt="Delete"></a>
			  </td>
<%
}	
else
{
%>
			  <td align="center">&nbsp;</td>
<%
}
%>
          </tr>
  <%
	}//for (int i=0; i<objAL()-1 ; i++)
}
else
{
%>
	  <tr>
	  <td colspan="13" align="center" class="txtxred" bgcolor="#CCCCFF">N/A<td>
	  </tr>
  <%
}
%>
  </table>
</div>
</body>
</html>

<script language="JavaScript">
var cal2 = new calendar2(document.form1.elements['edate']);
cal2.year_scroll = true;
cal2.time_comp = false;
</script> 
