<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}
else
{

String brief_dt	= request.getParameter("brief_dt");
String purserEmpno	= request.getParameter("purserEmpno");
String flag	= request.getParameter("flag");
String purname  = "";
String pursern  = "";
String time_hh  = "";
String time_mi  = "";
String time_hh2  = "";
String time_mi2  = "";
String newname = "";
String newuser = "";

//�Q�d�֤H
eg.EGInfo egi = new eg.EGInfo(purserEmpno);
eg.EgInfoObj purobj = egi.getEGInfoObj(purserEmpno); 
if(purobj !=null)
{
	purserEmpno   = purobj.getEmpn();
	pursern = purobj.getSern();
	purname = purobj.getCname();
}

PRBriefEval prbe = new PRBriefEval();
prbe.setFlag(flag);
prbe.getPRBriefEval(brief_dt,brief_dt,purserEmpno);
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
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�ȿ��g�z����²�����{</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<!--<script type="text/javascript" src="alttxt.js"></script> -->
</script>
</head>
<body>
<table width="90%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td>
      <div align="center"><span class="txttitletop">�ȿ��g�z����²���A¾�ʵ��q </span></div>
    </td>
  </tr>
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="20%" align="center" class="tablehead3"><strong>���Ȥ��</strong></div></td>
		<td width="20%"><div align="center" class="tablehead3"><strong>²���ɶ�</strong></div></td>
    	<td width="20%"><div align="center" class="tablehead3"><strong>���ȯZ��</strong></div></td>
    	<td width="20%" align="center" class="tablehead3"><strong>�ȿ��g�z</strong></div></td>
    	<td width="20%" align="center" class="tablehead3"><strong>�d�֤H</strong></div></td>
  	</tr> 
	<tr class="txtblue">
	  	<td width="20%" align="center"><%=brief_dt%></td>
	  	<td width="20%" align="center" ><%=time_hh%>:<%=time_mi%>~<%=time_hh2%>:<%=time_mi2%></td>
		<td width="20%" align="center" ><%=obj.getFltno()%></td>
		<td width="20%" align="center"><%=purserEmpno%>/<%=pursern%>/<%=purname%></td>
		<td width="20%" align="center"><%=newname%></td>
  	</tr> 
</table>
<table width="90%" border="1" align="center" cellpadding="1" cellspacing="1" class="fortable">
  	<tr class="tablehead3">
   	   <td align="center" valign="middle"  rowspan= "2"><strong>��������</strong></td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>����</strong></td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>�[��Ӷ�</strong></td>
       <!--<td align="center" valign="middle"  rowspan= "2"><strong>�ʤ���</strong></td>-->
   	   <td align="center" valign="middle"  colspan="3"><strong>����</strong></td>
   	   <td align="center" valign="middle"  rowspan= "2"><strong>�Ƶ�</strong></td>
    </tr>
	 <tr class="tablehead3">
       <td align="center" valign="middle"><strong>PASS</strong></td>
       <td align="center" valign="middle"><strong>NIL</strong></td>
       <td align="center" valign="middle"><strong>FAIL</strong></td>
  	</tr>
  	<%
	int item_seq = 1;
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
		item_seq = 1;
		String fake_itemno = scoreobj.getItem_no().replaceAll("F","A").replaceAll("G","B").replaceAll("H","C").replaceAll("I","D").replaceAll("J","E");
%>
		<td align="left" ><span class="style4"><%=fake_itemno%>.<%=scoreobj.getItem_desc()%> (<%=scoreobj.getMain_percentage()%>%)</span></td>
<%
		String scorestr = "";
		if("F".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk1_score();
		}
		if("G".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk2_score();
		}
		if("H".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk3_score();
		}
		if("I".equals(scoreobj.getItem_no()))
		{
			scorestr = obj.getChk4_score();
		}
		if("J".equals(scoreobj.getItem_no()))
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
String var100 ="";
String var50 ="<img src='../images/check.gif' width='17' height='15' border='0' >";
String var0 ="";
if("0".equals(scoreobj.getScore()))
{
	var0="<img src='../images/check.gif' width='17' height='15' border='0' >";
	var50="";
}

if("100".equals(scoreobj.getScore()))
{
	var100="<img src='../images/check.gif' width='17' height='15' border='0' >";
	var50="";
}
%>
		<td align="left" ><span class="style4"><%=item_seq++%>.)<%=scoreobj.getSubitem_desc()%>
<%
		if("J".equals(scoreobj.getItem_no()))
	    {
%>
			(<%=scoreobj.getSub_percentage()%>%)
<%
		}
%>				
		</span></td>
		<!--<td align="center" ><%=scoreobj.getSub_percentage()%>%</td>-->

<%
		if("J".equals(scoreobj.getItem_no()))
	    {
%>
		<td align="center" colspan ="3"><%=scoreobj.getScore()%></td>		
<%
		}
		else
		{
%>
		<td align="center" >&nbsp;<%=var100%></td>
		<td align="center" >&nbsp;<%=var50%></td>
		<td align="center" >&nbsp;<%=var0%></td>
<%
		}
%>
		<td align="left" ><span class="style4"><%=scoreobj.getComm()%></span></td>
   	</tr>
    <%
	}
	%>  
</table>
<table width="90%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td width="25%" align="center" class="tablehead3">General Comment</td>
	  	<td width="75%" align="left"><%=obj.getComm()%></td>
  	</tr> 
</table>
</body>
</html>
<%
}		
%>