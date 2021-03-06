<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

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

//被查核人
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
<title>客艙經理任務簡報表現</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="alttxt.js"></script> 
</script>
</head>
<body>
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
	  	<td width="20%" align="center"><%=brief_dt%></td>
	  	<td width="20%" align="center" ><%=time_hh%>:<%=time_mi%>~<%=time_hh2%>:<%=time_mi2%></td>
		<td width="20%" align="center" ><%=obj.getFltno()%></td>
		<td width="20%" align="center"><%=purserEmpno%>/<%=pursern%>/<%=purname%></td>
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
   	   <td align="center" valign="middle"  rowspan= "2"><strong>備註</strong></td>
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
String var75 ="<img src='../images/check.gif' width='17' height='15' border='0' >";
String var100 ="";
if("50".equals(scoreobj.getScore()))
{
	var50="<img src='../images/check.gif' width='17' height='15' border='0' >";
	var75="";
}

if("100".equals(scoreobj.getScore()))
{
	var100="<img src='../images/check.gif' width='17' height='15' border='0' >";
	var75="";
}

%>
		<td align="left" ><span class="style4"><%=scoreobj.getSubitem_desc()%></span></td>
		<td align="center" ><%=scoreobj.getSub_percentage()%>%</td>
		<td align="center" >&nbsp;<%=var50%></td>
		<td align="center" >&nbsp;<%=var75%></td>
		<td align="center" >&nbsp;<%=var100%></td>
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
