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
		alert("�п�J���԰_�l��");
		return false;
	}

	if(str2 == null | str2 == "")
	{
		alert("�п�J���Ե�����");
		return false;
	}

	document.form1.Submit.disabled=1;	
	 if(confirm("�T�w�s�W?"))
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
	<td width="35%" align="center"><font face="Comic Sans MS" color="#003399">�s�W���Կ�Z���</font></td>
	<td width="30%" align="right">
<% if("635".equals(funitcd) | "640790".equals(userid))
	{
%>
	<a href="#" onClick="subwin('halfyearfullattendancecheck.jsp?empno=<%=empno%>','fItem','600','700')"><span  class="txtblue">KHH�b�~���԰϶��պ�</span></a></td>	
<%
	}	
%>
	</tr>
	</table>
</div>
<div align="center">
    <table width="95%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	    <td align="center" class="tablehead"><strong>���u��(�Ǹ�)</strong></td>
	    <td align="center" class="tablehead"><strong>�m�W</strong></td>
	    <td align="center" class="tablehead"><strong>���</strong></td>
	    <td align="center" class="tablehead"><strong>���԰_�l��</strong></td>
	    <td align="center" class="tablehead"><strong>���Ե�����</strong></td>
	    <td align="center" class="tablehead"><strong>�Ƶ�</strong></td>
	  </tr>
	  <tr valign="top">
	    <td align="center" class="txtblue"><%=empno%>(<%=sern%>)</td>
	    <td align="center" class="txtblue"><%=cname%></td>
	    <td align="center" class="txtblue">���Կ�Z</td>
		<td align="center" class="txtblue"><input name="sdate" id="sdate" type="text" size="10" maxlength="10" class="txtblue" value="">&nbsp;&nbsp;<img height="16" src="../img/cal.gif" width="16" onclick="cal1.popup();"><br>ex:2008/01/01</td>
	    <td align="center" class="txtblue"><input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue" value="">&nbsp;&nbsp;<img height="16" src="../img/cal.gif" width="16" onclick="cal2.popup();"><br>ex:2008/01/01</td>
	    <td align="center" class="txtblue"><textarea name="comments" cols="20" rows="5" class="txtblue"></textarea></td>
	  </tr>
	</table>
	<br>
  <div align="center">
		<input type="hidden" name="empno" id="empno"  value="<%=empno%>">			
		<input type="submit" name="Submit" id="Submit" class="button1 txtblue" value="�s�W">			
  </div>
</form>
</div>
<hr width="95%">
<div align="center">
	<p><font face="Comic Sans MS" color="#003399">��Z�ӽЬ���</font></p>
	<table width="95%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td class="txtxred" align="left">* ��2012/09/01�_,���Ԧ��Ĥ�����ȫO�d�G�~������,�ä[����</td>
	</tr>
	<tr>
	    <td class="txtxred" align="left">* �O�_���ĭY��Y,�BED�B�z�O�����Ů�,�N��խ��w���X�ӽЦ��|����ED��z��Z�Ʃy</td>
	</tr>
	<tr>
	    <td class="txtxred" align="left">* �O�_���ĭY��Y,�BED�����O�B�z�O����,�N��խ��w���X�ӽШç�����Z�Ʃy</td>
	</tr>
	</table>
    <table width="95%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	    <td class="tablehead" align="center">�Ƨ�</td>
	    <td class="tablehead" align="center">�m�W<br>���u��<br>(�Ǹ�)</td>
	    <td class="tablehead" align="center">���<br>(�n�I�s��)</td>
	    <td class="tablehead" align="center">���԰_�l��</td>
	    <td class="tablehead" align="center">���Ե�����</td>
	    <td class="tablehead" align="center">�O�_<br>����</td>
	    <td class="tablehead" align="center">�ӽФ�</td>
	    <td class="tablehead" align="center">����</td>
		<td class="tablehead" align="center">ED�B�z�H��<br>ED�B�z�ɶ�</td>
		<td class="tablehead" align="center">EF�B�z�H��<br>EF�B�z�ɶ�</td>
		<td class="tablehead" align="center">�ק�</td>
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
