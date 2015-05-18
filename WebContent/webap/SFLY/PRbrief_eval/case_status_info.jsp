<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,eg.prfe.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("logout.jsp");
}
String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String base = request.getParameter("base");
String bgColor = "#C6C2ED";

PRBriefEval prbe = new PRBriefEval();
prbe.getPRBriefEval_CaseStatus(syy,smm,eyy,emm,base);
ArrayList objAL = new ArrayList();
objAL = prbe.getObjAL();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>ViewCaseStatusInfo</title>
<link href = "../style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-family: Arial, Helvetica, sans-serif; color: #FFFFFF; }
.style11 {color: #424984}
.txtred {
	font-size: 12px;
	line-height: 13.5pt;
	color: red;
	font-family:  "Verdana";
}
.txttitletop {
	font-family:Verdana, Arial, Helvetica, sans-serif;
	font-size: 16px;
	line-height: 22px;
	color: #464883;
	font-weight: bold;
}
.txtblue {
	font-size: 12px;
	line-height: 13.5pt;
	color: #464883;
	font-family:  "Verdana";
}
.tablehead {
	font-family: "Arial", "Helvetica", "sans-serif";
	background-color: #006699;
	font-size: 13px;
	text-align: center;
	font-style: normal;
	font-weight: bold;
	color: #FFFFFF;
}
.style12 {font-family: Arial, Helvetica, sans-serif; color: #FFFFFF; font-weight: bold; }
.style13 {color: #000000}
-->
</style>
<script language="javascript" type="text/javascript">
function openDetail(divname)
{
	if(document.getElementById(divname).style.display == '')
	{
		document.getElementById(divname).style.display='none';
	}
	else
	{
		document.getElementById(divname).style.display='';
	}
	
}
</script>
</head>

<body>
<div align='center' class="txttitletop" >客艙經理任務簡報表現評量狀態</div>
<br>
<table width="95%" border="0" align="center" class="tablebody">
<tr class="tablehead">
  <td width="10%" ><div align="center" class="style12">#</div></td> 
  <td width="15%" ><div align="center" class="style12">Flt Month</div></td> 
  <td width="50%" ><div align="center" class="style12">CaseClose</div></td>
  <td width="25%" ><div align="center" class="style12">Detail</div></td>
</tr>
</table>
<%
if(objAL.size() > 0)
{
	for(int i=0;i<objAL.size();i++)
	{
		PRBriefEvalObj obj = (PRBriefEvalObj) objAL.get(i);   
		if(i%2 ==0)
			bgColor="#C6C2ED";
			//bgColor="";
		else
			bgColor="#F2B9F1";    
%>
<table width="95%" border="0" align="center">
  <tr bgcolor="<%=bgColor%>">
	  <td width="10%" class="txtblue"><div align="center" class="style13"><%=i+1%></div></td>
	  <td width="15%" class="txtblue"><div align="center" class="style13"><%=obj.getBrief_dt()%></div></td>
<%
if("N".equals(obj.getCaseclose()))	
{
%>
	  <td width="50%" class="txtblue"><div align="center" class="style13"><a href="#"  onClick="window.open('doCaseClose.jsp?yyyymm=<%=obj.getBrief_dt()%>&base=<%=base%>&syy=<%=syy%>&smm=<%=smm%>&eyy=<%=eyy%>&emm=<%=emm%>','CaseClose','left=800,top=800,width=10,height=10,scrollbars=yes');">Case close</a></div></td>
<%
}	
else
{
%>
	  <td width="50%" class="txtblue"><div align="center" class="style13"><%=obj.getClose_tmst()%></div></td>
<%
}
%>
	  <td width="25%" class="txtblue"><div align="center" class="style13"><a href="#" onClick="openDetail('div<%=obj.getBrief_dt()%>')"><img src="../images/messagebox_info.png" width="16" height="16" border="0"></div></td>
</tr>
</table>
<div align="ceter" name="div<%=obj.getBrief_dt()%>" id="div<%=obj.getBrief_dt()%>" style="display:none"> 
<table width="95%" border="1" align="center" class="tablebody">
<tr>
	<td align="center" class="txtblue"><strong>簡報日期</strong></td>
	<td align="center" class="txtblue"><strong>報到<br>時間</strong></td>
	<td align="center" class="txtblue"><strong>班次</strong></td>
	<td align="center" class="txtblue"><strong>客艙經理</strong></td>
	<td align="center" class="txtblue"><strong>Total<br>Score</strong></td>
	<td width="320" align="center" class="txtblue"><strong>General Comment</strong></td>
	<td align="center" class="txtblue"><strong>查核人</strong></td>
	<td align="center" class="txtblue"><strong>Confirm</strong></td>
</tr>
<%
	ArrayList beobjAL = obj.getBeObjAL();
	if(beobjAL.size() >0)
	{
		for(int j=0; j<beobjAL.size(); j++)
		{
			PRBriefEvalObj subobj = (PRBriefEvalObj) beobjAL.get(j);  
%>	
				<tr class="txtblue">
				<td  align="center"><%=subobj.getBrief_dt()%></td>
				<td  align="center"><%=subobj.getBrief_time()%></td>
				<td  align="center" ><%=subobj.getFltno()%></td>
				<td  align="center" ><%=subobj.getPurname()%></td>
				<td  align="center"><%=subobj.getTtlscore()%></td>
				<td  width="320" align="left"><%=subobj.getComm()%></td>
				<td  align="center"><%=subobj.getNewname()%></td>
				<td  align="center">&nbsp;<%=subobj.getConfirm_tmst()%></td>
			</tr> 
<%
		}
	}
%>
</table>
</div>
<%	
	}//for(int i=0;i<objAL.size();i++)
}
else
{
%>
<table width="95%" border="0" align="center" class="tablebody">
 <tr bgcolor="<%=bgColor%>">
  <td colspan="3" class="txtblue"><div align="center" class="style13">No Data Found!!</div></td>
 </tr>
</table>
<%	
}
%>
</body>
</html>