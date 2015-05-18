<%@page contentType="text/html; charset=big5" language="java" import="credit.*,eg.crewbasic.*,eg.GetEmpno"%>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String funitcd = (String) session.getAttribute("fullUCD");

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
<title>Request Pick SKj List</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
<script src="../subWindow.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="../calendar2.js"></script>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
<script language="JavaScript">
function f_submit()
{  
	var str = document.form1.sdate.value;	
	var str2 = document.form1.edate.value;	

	if(str == null | str == "")
	{
		alert("請輸入全勤起始日");
		return false;
	}

	if(str2 == null | str2 == "")
	{
		alert("請輸入全勤結束日");
		return false;
	}

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
</script>

</head>
<body bgcolor="#FFFFFF" text="#000000" align= "center">
<div align="center">
<%
SkjPickList spl = new SkjPickList();
spl.getSkjPickList("ALL",empno);
objAL = spl.getObjAL();

CrewInfo c = new CrewInfo(empno);
CrewInfoObj o = c.getCrewInfo();
String cname = o.getCname();
String sern = o.getSern();

%>
</div>
<form name="form1" method="post" action="inspickswap.jsp" onSubmit="return f_submit();">
<div align="center">
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	<td width="30%"></td>
	<td width="35%" align="center"><font face="Comic Sans MS" color="#003399">新增全勤選班資格</font></td>
	<td width="30%" align="right">
<% if("635".equals(funitcd) | "640790".equals(userid))
	{
%>
	<a href="#" onClick="subwin('halfyearfullattendancecheck.jsp?empno=<%=empno%>','fItem','600','700')"><span  class="txtblue">KHH半年全勤區間試算</span></a></td>	
<%
	}	
%>
	</tr>
	</table>
</div>
<div align="center">
    <table width="95%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	    <td align="center" class="tablehead"><strong>員工號(序號)</strong></td>
	    <td align="center" class="tablehead"><strong>姓名</strong></td>
	    <td align="center" class="tablehead"><strong>資格</strong></td>
	    <td align="center" class="tablehead"><strong>全勤起始日</strong></td>
	    <td align="center" class="tablehead"><strong>全勤結束日</strong></td>
	    <td align="center" class="tablehead"><strong>備註</strong></td>
	  </tr>
	  <tr valign="top">
	    <td align="center" class="txtblue"><%=empno%>(<%=sern%>)</td>
	    <td align="center" class="txtblue"><%=cname%></td>
	    <td align="center" class="txtblue">全勤選班</td>
		<td align="center" class="txtblue"><input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue" value="">&nbsp;&nbsp;<img height="16" src="../img/cal.gif" width="16" onclick="cal1.popup();"><br>ex:2008/01/01</td>
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
<div align="center">
	<p><font face="Comic Sans MS" color="#003399">選班申請紀錄</font></p>
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td class="txtxred" align="left">* 自2012/09/01起,全勤有效日取消僅保留二年的限制,永久有效</td>
	</tr>
	<tr>
	    <td class="txtxred" align="left">* 是否有效若為Y,且ED處理記錄為空時,代表組員已提出申請但尚未至ED辦理選班事宜</td>
	</tr>
	<tr>
	    <td class="txtxred" align="left">* 是否有效若為Y,且ED有註記處理記錄時,代表組員已提出申請並完成選班事宜</td>
	</tr>
	</table>
    <table width="95%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	    <td class="tablehead" align="center">排序</td>
	    <td class="tablehead" align="center">姓名<br>員工號<br>(序號)</td>
	    <td class="tablehead" align="center">資格<br>(積點編號)</td>
	    <td class="tablehead" align="center">全勤起始日</td>
	    <td class="tablehead" align="center">全勤結束日</td>
	    <td class="tablehead" align="center">是否<br>有效</td>
	    <td class="tablehead" align="center">申請日</td>
	    <td class="tablehead" align="center">註解</td>
		<td class="tablehead" align="center">ED處理人員<br>ED處理時間</td>
		<td class="tablehead" align="center">EF處理人員<br>EF處理時間</td>
		<td class="tablehead" align="center">修改</td>
	</tr>
  <%
int count=0;
if(objAL.size()>0)
{
	String trbgcolor = "";
	for (int i=0; i<objAL.size() ; i++)
	{
		SkjPickObj obj = (SkjPickObj) objAL.get(i);
		if("".equals(obj.getEd_user()) | obj.getEd_user() == null )
		{
			trbgcolor = "#FFCCFF";
		}
		else
		{
			trbgcolor = "#FFFFFF";
		}
%>
		  <tr bgcolor='<%=trbgcolor%>' class="txtblue" align = "center">
			  <td><%=i+1%></td>
			  <td><%=obj.getCname()%><br><%=obj.getEmpno()%><br>(<%=obj.getSern()%>)</td>
			  <td><%=obj.getReason()%><br><%=obj.getcredit3()%></td>
			  <td>&nbsp;<%=obj.getSdate()%></td>
			  <td>&nbsp;<%=obj.getEdate()%></td>
			  <td><%=obj.getValid_ind()%></td>
			  <td><%=obj.getNew_tmst()%></td>
			  <td width="15%">
				  <table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr><td class="txtblue"><%=obj.getComments()%></td></tr></table>
			  </td>
			  <td><%=obj.getEd_user()%><br><%=obj.getEd_tmst()%></td>
			  <td><%=obj.getEf_user()%><br><%=obj.getEf_tmst()%></td>
			  <td align="center"><a href="#" onClick="subwinXY('modpick_ef.jsp?sno=<%=obj.getSno()%>','fItem','700','250')"><img src="../../images/red.gif" width="15" height="15" border="0" alt="Handle"></a>
			</td>
		  </tr>
  <%
	}//for (int i=0; i<objAL()-1 ; i++)
}
else
{
%>
	  <tr>
	  <td colspan="12" align="center" valign="middle" >No data found!!<td>
	  </tr>
  <%
}
%>
    </table>
</div>
</body>
</html>

<script language="JavaScript">
var cal1 = new calendar2(document.form1.elements['sdate']);
cal1.year_scroll = true;
cal1.time_comp = false;
var cal2 = new calendar2(document.form1.elements['edate']);
cal2.year_scroll = true;
cal2.time_comp = false;
</script> 
