<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String empno	= request.getParameter("empno");
String sdate	= request.getParameter("sdate");
String purname  = "";
String pursern  = "";
String time_hh  = "";
String time_mi  = "";
String time_hh2  = "";
String time_mi2  = "";
String newname = "";
String newuser = "";

//被查核人
empno = eg.GetEmpno.getEmpno(empno);
eg.EGInfo egi = new eg.EGInfo(empno);
eg.EgInfoObj purobj = egi.getEGInfoObj(empno); 
if(purobj !=null)
{
	empno   = purobj.getEmpn();
	pursern = purobj.getSern();
	purname = purobj.getCname();
}
//查核人
eg.HRInfo hr = new eg.HRInfo(userid);
newname = hr.getCname(userid);
newuser = userid;

PRBriefEval prbe = new PRBriefEval();
prbe.setFlag("A");//2011/05/01 更改題庫
prbe.getPRBriefEval(sdate,sdate,empno);
ArrayList objAL = new ArrayList();
ArrayList scoreAL = new ArrayList();
objAL = prbe.getObjAL();
PRBriefEvalObj obj = new PRBriefEvalObj();
if(objAL.size()>0)
{
	obj = (PRBriefEvalObj) objAL.get(0);  
	scoreAL = obj.getSubScoreObjAL();
	/*
	fz.splitString p = new fz.splitString();
    String[] str = p.doSplit(obj.getBrief_time(),":");
    if(str.length >=2)
	{
		time_hh = str[0];
		time_mi = str[1];
	}		
	*/
	String brief_time_str = obj.getBrief_time();
	time_hh = brief_time_str.substring(0,2);
	time_mi = brief_time_str.substring(3,5);
	time_hh2 = brief_time_str.substring(6,8);
	time_mi2 = brief_time_str.substring(9,11);

	newname = obj.getNewname();
	newuser = obj.getNewuser();
}

if(scoreAL.size()<=0)
{//尚未編輯, assign empty AL
	scoreAL = prbe.getPRBriefEvalSubScoreEmpty();
}
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙經理任務簡報表現</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script LANGUAGE="JavaScript">
function chkRequest()
{
	var brief_hh = eval("document.form1.brief_hh.value");
	var brief_mi = eval("document.form1.brief_mi.value");
	var brief_hh2 = eval("document.form1.brief_hh2.value");
	var brief_mi2 = eval("document.form1.brief_mi2.value");
	var fltno = eval("document.form1.fltno.value");
	
	 if(brief_hh =="")
	 {
		alert("請輸入簡報時間!!");
		document.form1.brief_hh.focus();
		return false;
	 }
	 else if(brief_mi =="")
	 {
		alert("請輸入簡報時間!!");
		document.form1.brief_mi.focus();
		return false;
	 }
	 else if(brief_hh2 =="")
	 {
		alert("請輸入簡報時間!!");
		document.form1.brief_hh2.focus();
		return false;
	 }
	 else if(brief_mi2 =="")
	 {
		alert("請輸入簡報時間!!");
		document.form1.brief_mi2.focus();
		return false;
	 }
	 else if(fltno =="")
	 {
		alert("請輸入任務班號!!");
		document.form1.fltno.focus();
		return false;
	 }
	 else
	 {
		if(brief_hh.length <=1)
		{
			document.form1.brief_hh.value = '0'+brief_hh;
		}
		if(brief_mi.length <=1)
		{
			document.form1.brief_mi.value = '0'+brief_mi;
		}
		if(brief_hh2.length <=1)
		{
			document.form1.brief_hh2.value = '0'+brief_hh2;
		}
		if(brief_mi2.length <=1)
		{
			document.form1.brief_mi2.value = '0'+brief_mi2;
		}
		document.form1.Submit.disabled=1;
		return true;
	 }
}
</script>
<style type="text/css">
<!--
.style3 {color: #000000}
.style4 {
	font-size: 12px;
	font-weight: bold;
}
.navtext 
{ 
width:200px; 
font-size:8pt; 
border: 1px solid #fff; 
background-color:#FFCCFF;
color:#39c; 
} 
-->
</style>

</head>

<body>
<form name="form1" method="post" action="insPRBE_new.jsp"  Onsubmit = " return chkRequest();">
<input name="flag" type="hidden" value="A">
<input name="empno" type="hidden" value="<%=empno%>">
<input name="sdate" type="hidden" value="<%=sdate%>">
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">客艙經理任務簡報適職性評量 </span></div>
    </td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="20%" align="center" class="tablehead3"><strong>任務日期</strong></div></td>
		<td width="20%"><div align="center" class="tablehead3"><strong>簡報時間</strong></div></td>
    	<td width="20%"><div align="center" class="tablehead3"><strong>任務班號</strong></div></td>
    	<td width="20%" align="center" class="tablehead3"><strong>客艙經理</strong></div></td>
    	<td width="20%" align="center" class="tablehead3"><strong>查核人</strong></div></td>
  	</tr> 
	<tr class="txtblue">
	  	<td width="20%" align="center"><%=sdate%></td>
	  	<td width="20%" align="center" ><input name="brief_hh" id="brief_hh" type="text" value="<%=time_hh%>"  size="2" maxlength="2">:<input name="brief_mi" id="brief_mi" type="text" value="<%=time_mi%>"  size="2" maxlength="2"> ~ <input name="brief_hh2" id="brief_hh2" type="text" value="<%=time_hh2%>"  size="2" maxlength="2">:<input name="brief_mi2" id="brief_mi2" type="text" value="<%=time_mi2%>"  size="2" maxlength="2"></td>
		<td width="20%" align="center" ><input name="fltno" id="fltno" type="text" value="<%=obj.getFltno()%>"  size="5" maxlength="5"></td>
		<td width="20%" align="center"><%=empno%>/<%=pursern%>/<%=purname%></td>
		<td width="20%" align="center"><%=newname%></td>
  	</tr> 
</table>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr class="tablehead3">
   	   <td align="center" valign="middle"  rowspan= "2"><strong>評估項目</strong></td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>分數</strong></td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>觀察細項</strong></td>
       <td align="center" valign="middle"  rowspan= "2"><strong>百分比</strong></td>
   	   <td align="center" valign="middle"  colspan="3"><strong>評分</strong></td>
	   <td align="center" valign="middle"  rowspan="2"><strong>備註</strong></td>
    </tr>
	 <tr class="tablehead3">
       <td align="center" valign="middle"><strong>NDIP</strong></td>
       <td align="center" valign="middle"><strong>AVRG</strong></td>
       <td align="center" valign="middle"><strong>GOOD</strong></td>		  
  	</tr>
  	<%
	for(int j=0;j<scoreAL.size();j++)
	{		
		boolean showMain = false;
		PRBriefSubScoreObj scoreobjp = null;      
		PRBriefSubScoreObj scoreobj =(PRBriefSubScoreObj) scoreAL.get(j); 
		if(j<=0)
		{
			showMain = true;
		}
		else
		{
			scoreobjp =(PRBriefSubScoreObj) scoreAL.get(j-1); 
			if(!scoreobjp.getItem_no().equals(scoreobj.getItem_no()))
			{
				showMain = true;
			}
		}	
%>
  	<tr class="txtblue">
<%
if(showMain==true)
{
%>
		<td align="left" ><span class="style4"><%=scoreobj.getItem_no()%>.<%=scoreobj.getItem_desc()%> (<%=scoreobj.getMain_percentage()%>%)</span></td>
<%
		String scorestr = "";
		if("A".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk1_score();
		}
		if("B".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk2_score();
		}
		if("C".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk3_score();
		}
		if("D".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk4_score();
		}
		if("E".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk5_score();
		}
%>
		
		<td align="center"><span class="txtred"><b><%=scorestr%></b></span></td>
<%
}
else
{
%>
		<td align="left" colspan="2"><span class="style4">&nbsp;</span></td>

<%
}
%>

<%
String var50 ="";
String var75 ="checked";
String var100 ="";
if("50".equals(scoreobj.getScore()))
{
	var50="checked";
	var75="";
}

if("100".equals(scoreobj.getScore()))
{
	var100="checked";
	var75="";
}

%>
		<td align="left" ><span class="style4"><%=scoreobj.getSubitem_desc()%></span></td>
		<td align="center" ><%=scoreobj.getSub_percentage()%>%</td>
		<td align="center" ><input name="<%=scoreobj.getSubitem_no()%>" type="radio" value="50" <%=var50%>></td>
		<td align="center" ><input name="<%=scoreobj.getSubitem_no()%>" type="radio" value="75" <%=var75%>></td>
		<td align="center" ><input name="<%=scoreobj.getSubitem_no()%>" type="radio" value="100" <%=var100%>></td>
		<td align="left" ><textarea name="comm<%=scoreobj.getSubitem_no()%>" id="comm<%=scoreobj.getSubitem_no()%>" cols= "10" rows = "2"><%=scoreobj.getComm()%></textarea></td>
   	</tr>
    <%
	}
	%>  
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="25%" align="center" class="tablehead3">General Comment</td>
	  	<td width="75%" align="center"><textarea name="comm" id="comm" cols= "50" rows = "4"><%=obj.getComm()%></textarea></td>
  	</tr> 
</table>
<%
if(purname == null | "".equals(purname))
{
%>
<p class = "txtred" align="center">請確認被查核人員是否正確!!</p>
<%
}
%>

<%
String ifallowupdate = "disabled";
if(userid.equals(newuser))
{
	ifallowupdate = "";
}
%>
<table width="90%"  border="0" align="center"> 
	<tr><td align= "center"><br><input name="Submit" type="Submit" value=" SUBMIT " <%=ifallowupdate%>></td></tr>
</table>
</form>
</body>
</html>
<%
session.setAttribute("objAL", objAL);
%>
