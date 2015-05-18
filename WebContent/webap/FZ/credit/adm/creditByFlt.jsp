<%@ page contentType="text/html; charset=big5" language="java" import="credit.*,java.util.*" %>
<%
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

String userid = (String) session.getAttribute("userid") ; //get user id if already login
String fltd = (String) request.getParameter("fltd") ; 
String fltno = (String) request.getParameter("fltno") ; 
String sect = (String) request.getParameter("sect") ; 

if (userid == null) 
{		
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 
else
{
//***************************************************
CreditList cl = new CreditList();
ArrayList objAL = new ArrayList();
objAL = cl.getNewCreditCrewList(fltd,fltno,sect);
String tempbgcolor = "";
%>
<html>
<head>
<title>New Credit by Flt</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="menu.css" rel="stylesheet" type="text/css">
<script language="Javascript" type="text/javascript" src="../../js/subWindow.js"></script>
<script language="javascript" type="text/javascript" src="calendar2.js"></script>

<script language="javascript">
function chgbg(para)
{	
	//if(document.form1.elements[para].checked)
	if(document.forms['form1'].chkItem[para].checked)
	{
		eval("document.getElementById('crew_"+para+"').style.backgroundColor = '#FFFF66'");
	}
	else
	{
		eval("document.getElementById('crew_"+para+"').style.backgroundColor = '#FFFFFF'");
	}
}


function f_submit()
{	
	document.form1.Submit.disabled=1;
	var count = 0;
	for (i=0; i<eval(document.form1.length); i++) 
	{
		if (eval(document.form1.elements[i].checked)) count++;
	}

	if(count ==0 ) 
	{
		alert("�ФĿ�s�W�H��!!");
		return false;
	}
	else
	{
		if(document.form1.allchkbox.checked)
		{
			count = count -1;
		}

		if(	confirm("�@�Ŀ� "+count+" ����ơA\n�T�{�e�X�H"))
		{
			return true;

		}
		else
		{
			return false;
		}

	}
}


function CheckAll(formName,checkAllName)
{
	var allchk = eval("document."+formName+".allchkbox.checked");

	for (var i=0;i<  eval("document.forms['"+formName+"'].chkItem.length") ;i++)
	{
	    var e = eval("document.forms['"+formName+"'].chkItem[i]");
		e.checked = allchk;
		if(allchk)
		{
			eval("document.getElementById('crew_"+i+"').style.backgroundColor = '#FFFF66'");
		}
		else
		{
			eval("document.getElementById('crew_"+i+"').style.backgroundColor = '#FFFFFF'");
		}
	 }
}

</script>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div width="85%" align="center">
	<font face="Comic Sans MS" color="#003399">�s�W�n�I</font>
</div>
<center>
<form name="form1" method="post" action="inscreditByflt.jsp" onSubmit="return f_submit();">
<input name="fltd" id="fltd" type="hidden" value="<%=fltd%>"> 	
<input name="fltno" id="fltno" type="hidden" value="<%=fltno%>">
<input name="sector" id="sect" type="hidden" value="<%=sect%>">
    <table width="85%" border="1" cellspacing="0" cellpadding="0">
	  <tr>
	    <td align="center" class="tablehead"><strong>�n�I����</strong></td>
	    <td align="center" class="tablehead"><strong>�n�I���Ĥ�</strong></td>
		<td align="center" class="tablehead"><strong>����</strong></td>
	  </tr>
	  <tr valign="top">
	    <td align="center" class="txtblue">			
		    <select name="reason" class="txtblue">
				<option value="1">�P�Ⱚ��</option>
				<option value="2">�B�~���Z��</option>
				<option value="3">���ɯ}��</option>
				<option value="4">�䥦���Z��</option>
				<option value="5">�䥦��Z��</option>
			</select>
		</td>
	    <td align="center" class="txtblue"><input name="edate" id="edate" type="text" size="10" maxlength="10" class="txtblue" value="">&nbsp;&nbsp;<img height="16" src="../img/cal.gif" width="16" onclick="cal2.popup();"><br>ex:2008/01/01</td>
	    <td align="center" class="txtblue"><textarea name="comments" cols="60" rows="3" class="txtblue"><%=fltd%> CI-<%=fltno%> <%=sect%></textarea></td>
	  </tr>
	</table>
	<table width="85%" border="1" cellspacing="0" cellpadding="0">
	<tr> 
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>#</b></font></td>
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Cname</b></font></td> 
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Empno</b></font></td> 
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Sern</b></font></td>
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b>Duty</b></font></td> 
	  <td class="tablehead"><font face="Arial, Helvetica, sans-serif" size="2"><b><div align="center">Check ALL<input name="allchkbox" type="checkbox" onClick="CheckAll('form1','allchkbox')" ></div></b></font></td>
	</tr>
<%
if(objAL.size()>0)
{
	int count = 0;
	for(int i=0; i<objAL.size(); i++)
	{		
		CreditObj obj = (CreditObj) objAL.get(i);
		if(!"".equals(obj.getEmpno()) && obj.getEmpno() != null && !"000000".equals(obj.getEmpno()))
		{
%>
		<tr class="txtblue" name="crew_<%=count%>" id="crew_<%=count%>" bgcolor = "#FFFFFF"> 
		<td align="center">&nbsp;<%=(count+1)%></td>
		<td align="center">&nbsp;<%=obj.getCname()%></td>
		<td align="center">&nbsp;<%=obj.getEmpno()%></td>
		<td align="center">&nbsp;<%=obj.getSern()%></td>
		<td align="center">&nbsp;<%=obj.getGroups()%></td>
		<td align="center"><input name="chkItem" type="checkbox" id="chkItem" value="<%=obj.getEmpno()%>" onclick="chgbg('<%=count%>')"></td>
	</tr>
<%		
		count++;
		}
	}//for(int i=0; i<objAL.size(); i++)
}//if(objAL.size()>0)
%>
	</table>
	<br>
  <div align="center">
		<input type="submit" name="Submit" id="Submit" class="button1 txtblue" value="�s�W">		
  </div>
</form>
</div>
</center>
</body>
</html>



<script language="JavaScript">
var cal2 = new calendar2(document.form1.elements['edate']);
cal2.year_scroll = true;
cal2.time_comp = false;
</script> 

<%
}	
%>

