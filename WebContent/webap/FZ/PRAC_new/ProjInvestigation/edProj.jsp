<%@page contentType="text/html; charset=big5" language="java" %>
<%@page import="fz.pracP.*,java.sql.*,ci.db.ConnDB,fz.projectinvestigate.*,eg.*"%>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
if (session.isNew() || sGetUsr == null) 
{		//check user session start first or not login
	response.sendRedirect("../../sendredirect.jsp");
} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
<link href="../style2.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function usetemplate(para1, para2)
{
	var comm = document.getElementById("comments-"+para1).value;
	comm = comm +" "+ para2;
	document.getElementById("comments-"+para1).value = comm;
	return
}	

function expcls(divname)
{
	if(document.getElementById(divname).style.display == "none")
	{
		document.getElementById(divname).style.display = "";
	}
	else
	{
		document.getElementById(divname).style.display = "none";
	}
	return
}	

function chkvaluenum(divname)
{
	var val = document.getElementById(divname).value;	
	if (isNaN(val)== true)
	{
	 	alert("請輸入數字!!");
		eval("document.form1."+divname+".focus()");
		return false;
	}
	else
	{
		return true;
	}
}	


function submitfun()
{
	document.form1.Submit.disabled=1;
}	

</script>

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
<%
String fltdt = request.getParameter("fltdt");//yyyy/mm/dd
String fltno = request.getParameter("fltno");//006
String sect = request.getParameter("sect");//TPELAX
String proj_no = request.getParameter("proj_no");
String fleet = request.getParameter("fleet");
String acno = request.getParameter("acno");
//***********************************************
//out.println(proj_no+"  **  "+fltdt+"  **  "+fltno+"  **  "+ sect.substring(0,3)+"  **  "+sect.substring(3)+"  **  "+sGetUsr+"  **  "+fleet+"  **  "+acno);
PRPJIssue pj = new PRPJIssue();
ArrayList objAL = new ArrayList();
pj.getBankItemno(proj_no,fltdt, fltno, sect.substring(0,3),sect.substring(3),sGetUsr,fleet,acno);
objAL = pj.getBankObjAL();      
PRProjTemplate pjt = new PRProjTemplate();
ArrayList tempobjAL = new ArrayList();
pjt.getTemplate();
tempobjAL = pjt.getObjAL();
//out.print(fltno.length()+"  *** "+pj.getSQL()+"<br>");
%>
<body>
<form name="form1" method="post" action="updProj.jsp" onsubmit="return submitfun();">
<input type="hidden" id="fltdt" name="fltdt" value ="<%=fltdt%>" > 
<input type="hidden" id="fltno" name="fltno" value ="<%=fltno%>"> 
<input type="hidden" id="sect" name="sect" value ="<%=sect%>"> 
<input type="hidden" id="proj_no" name="proj_no" value ="<%=proj_no%>"> 
<input type="hidden" id="fleet" name="fleet" value ="<%=fleet%>"> 
<input type="hidden" id="acno" name="acno" value ="<%=acno%>"> 

<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" >
	<tr>
	  <td><div class = "txtblue" align="center">Fltdt : <%=fltdt%></div></td>
	  <td><div class = "txtblue" align="center">Fltno : <%=fltno%></div></td>
	  <td><div class = "txtblue" align="center">Sect  : <%=sect%></div></td>
	  <td><div class = "txtblue" align="center">Fleet : <%=fleet%></div></td>
	  <td><div class = "txtblue" align="center">Acno  : <%=acno%></div></td>
	</tr>
</table>
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" >
	<tr class="tablehead2">
	  <td width = "5%"><div class = "txtblue" align="center">&nbsp;</div></td>
	  <td width = "15%"><div class = "txtblue" align="center">Issue Description</div></td>
	  <td width = "15%"><div class = "txtblue" align="center">Feedback</div></td>
	  <td width = "65%"><div class = "txtblue" align="center">Comments</div></td>
	</tr>
<%
int seq =0;
for(int i=1; i<objAL.size(); i++)
{
	PRProjIssueObj objp = (PRProjIssueObj) objAL.get(i-1);
	PRProjIssueObj obj = (PRProjIssueObj) objAL.get(i);
	if(!obj.getProj_no().equals(objp.getProj_no()))
	{
		seq = 0;
%>
	<tr class="btm">
	  <td><div class = "txtblue" align="center">Event</div></td>
	  <td colspan="3"><div class = "txtblue" align="left">
<%
	if("D".equals(obj.getKin()))
	{
		EGInfo egi = new EGInfo(obj.getChkempno());
		EgInfoObj empobj = egi.getEGInfoObj(obj.getChkempno()); 
%>
	  <font color="red">Check Crew : <%=obj.getChkempno()%>(<%=empobj.getSern()%>) <%=empobj.getCname()%></font><br>
<%
	}
%>
	  <%=obj.getProj_event()%></div></td>
	</tr>
<%
	}
%>
	<tr>
	  <td><div class = "txtblue" align="center"><%=(++seq)%></div></td>
	  <td><div class = "txtblue" align="left">&nbsp;<%=obj.getItemdesc()%></div></td>
<%
	if("B".equals(obj.getKin()))	
	{
%>
		<td><div class = "txtblue" align="center">
		<select name = "fackback-<%=obj.getProj_no()%>-<%=obj.getItemno()%>">
		<option value="<%=obj.getFeedback()%>"><%=obj.getFeedback()%></option>

 <%
	
GregorianCalendar cal1 = new GregorianCalendar();
GregorianCalendar cal3 = new GregorianCalendar();//fltdt

// 2009/08/24 實施 
cal1.set(Calendar.YEAR,2009);
cal1.set(Calendar.MONTH,8-1);
cal1.set(Calendar.DATE,24);

// Fltdt
cal3.set(Calendar.YEAR,Integer.parseInt(fltdt.substring(0,4)));
cal3.set(Calendar.MONTH,(Integer.parseInt(fltdt.substring(5,7)))-1);
cal3.set(Calendar.DATE,Integer.parseInt(fltdt.substring(8)));
         
if(cal1.after(cal3))
{
%>
		<option value="非常滿意">非常滿意</option>
		<option value="滿意">滿意</option>
		<option value="可">可</option>
		<option value="尚可">尚可</option>
<%
}
else
{
%>
		<option value="非常滿意">非常滿意</option>
		<option value="滿意">滿意</option>
		<option value="普通">普通</option>
		<option value="不滿意">不滿意</option>
		<option value="非常不滿意">非常不滿意</option>
<%
}
%>		
		</select>
		</div>
		</td>
<%
	} 
	else if("D".equals(obj.getKin()))	
	{
%>
		<td><div class = "txtblue" align="center">
		<select name = "fackback-<%=obj.getProj_no()%>-<%=obj.getItemno()%>">
		<option value="<%=obj.getFeedback()%>"><%=obj.getFeedback()%></option>
		<option value="滿意">滿意</option>
		<option value="待改進">待改進</option>
		<option value="稍嫌不足">稍嫌不足</option>
		</select>
		</div></td>
<%
	}
	else //else if("B".equals(obj.getKin()))	
	{
%>
		<td><div class = "txtblue" align="center">
		<input type="text" size = "10" maxlength = "10" name="fackback-<%=obj.getProj_no()%>-<%=obj.getItemno()%>" id="fackback-<%=obj.getProj_no()%>-<%=obj.getItemno()%>" value="<%=obj.getFeedback()%>" onblur="chkvaluenum('fackback-<%=obj.getProj_no()%>-<%=obj.getItemno()%>')"></div></td>
<%
	}

	if("B".equals(obj.getKin()))	
	{
%>
	  <td>
	  <div class = "txtblue" align="left">
	  <textarea name="comments-<%=obj.getProj_no()%>-<%=obj.getItemno()%>" id="comments-<%=obj.getProj_no()%>-<%=obj.getItemno()%>" cols="60" rows="3"><%=obj.getComments()%></textarea></div>
	  <a href="javascript:expcls('template<%=obj.getProj_no()%>-<%=obj.getItemno()%>');"><img src="../../images/d2.gif" width="16" height="16" border="0" alt="Expand/Close" title="Expand/Close"></a>
	  <div align = "left" id="template<%=obj.getProj_no()%>-<%=obj.getItemno()%>" style="display:none;"> 
		<table border="0" align="left" cellpadding="0" cellspacing="0">
<%
	for(int m=0; m<tempobjAL.size(); m++)
	{
		PRProjTemplateObj objf = (PRProjTemplateObj) tempobjAL.get(m);
		if(objf.getItem_no().equals(obj.getItemno()))
		{
%>
		  <tr>
			<td class="txtblue">
			<input type="button" onclick = "usetemplate('<%=obj.getProj_no()%>-<%=obj.getItemno()%>','<%=objf.getComment_desc()%>')" value = "<%=objf.getComment_desc()%>">
			</td>
		  </tr>
<%
		}
	}//for(int m=0; m<tempobjAL.size(); m++)
%>			
		</table>
	  </div>
	  </td>
<%
	}
	else
	{
%>
	  <td>
	  <div class = "txtblue" align="left">
	  <textarea name="comments-<%=obj.getProj_no()%>-<%=obj.getItemno()%>" id="comments-<%=obj.getProj_no()%>-<%=obj.getItemno()%>" cols="60" rows="3"><%=obj.getComments()%></textarea>
	  </div>
	  </td>
<%
	}
%>
	</tr>
<%	
}//for(int i=1; i<objAL.size(); i++)	
%>
</table>
<%
if(objAL.size()>1)
{
%>
<br>
<div align = "center">
<input type="submit" value="&nbsp;&nbsp;&nbsp;&nbsp;Save&nbsp;&nbsp;&nbsp;&nbsp;" name="Submit" id="Submit" >
</div>
<%
}	
%>
</form>
</body>
</html>

<%
   session.setAttribute("projobjAL", objAL);
%>