<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.CrewEval.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String fromEG = request.getParameter("fromEG");
//out.println(userid);
//out.println(fromEG);
//out.println(request.getParameter("empno"));
if(fromEG == null)
{
	fromEG = "NO";
}
if(fromEG.equals("YES"))
{
	userid = request.getParameter("empno");
}
else if (userid == null && (fromEG == null | !fromEG.equals("YES"))) 
{		
	response.sendRedirect("../logout.jsp");
} 


String syy	= request.getParameter("syy");
String bgColor = "";
eg.crewbasic.CrewInfo c = new eg.crewbasic.CrewInfo(userid);
eg.crewbasic.CrewInfoObj o = c.getCrewInfo();
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>任務評分查詢</title>
<style type="text/css">
<!--
.txtblue {
	font-size: 12px;
	line-height: 13.5pt;
	color: #464883;
	font-family:  "Verdana";
}
.fortable{
	border: 1pt solid;
 }
.tablehead3 {
	font-family: "Arial", "Helvetica", "sans-serif";
	background-color: #006699;
	font-size: 10pt;
	text-align: center;
	font-style: normal;
	font-weight: normal;
	color: #FFFFFF;	
}
.style2 {font-size: 16px; line-height: 13.5pt; color: #464883; font-family: "Verdana"; }
.style3 {color: #000000}
-->
</style>
</head>
<body>
<table width="60%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="90%" align="center"><span class="style2"><%=o.getCname()%>&nbsp;<%=syy%> 考績年度任務評分</span>
    </td>
	<td align="right"><a href="javascript:window.print()"><img src="../../images/print.gif" width="17" height="15" border="0" alt="列印"></a></td>
  </tr>
</table>
<table width="60%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td align="center" class="tablehead3"><strong>年/月</strong></div></td>
	  	<td align="center" class="tablehead3"><strong>個人平均分</strong></div></td>
    	<td align="center" class="tablehead3"><strong>全體總平均分</strong></div></td>
<!--		<td align="center" class="tablehead3"><strong>個人名次/總人數</strong></div></td>-->
		<td align="center" class="tablehead3"><strong>排名<br>(依顏色表示)</strong></div></td>
	</tr>
<%
InqueryCrewEval ice = new InqueryCrewEval();
ice.getCrewEvalList(syy,userid);
ArrayList objAL = new ArrayList();
objAL = ice.getObjAL();
double tempSeq  = 0.0;//比例

String seqColor = null;
if(objAL.size() >0)
{
	for(int j=0; j<objAL.size(); j++)
	{
		InqueryCrewEvalObj obj = (InqueryCrewEvalObj) objAL.get(j);
		if(j %2 == 0)
		{
			bgColor="#FFFFFF";		
		}
		else
		{
			bgColor="#ADD8E6";			
		}
		
		tempSeq = 100.0 * Integer.parseInt(obj.getIndividual_seq()) / Integer.parseInt(obj.getBase_total()) ;
		//out.println(Integer.parseInt(obj.getIndividual_seq()) +" "+ Integer.parseInt(obj.getBase_total())+" "+ tempSeq);
		if(tempSeq == 0){
			seqColor = "";
		}else if(tempSeq > 0 && tempSeq <= 5){
			seqColor = "#3cb371";
		}else if (tempSeq >5 && tempSeq <=25){
			seqColor = "#1e90ff";
		}else if (tempSeq >25 && tempSeq <=35){
			seqColor = "#ffd700";
		}else if (tempSeq >35){
			seqColor = "#ff0000";
		}else{
			seqColor = "";
		}
		
%>
		<tr class="txtblue" bgcolor="<%=bgColor%>">
			<td  align="center"><span class="style3"><%=obj.getYyyy()+"/"+obj.getMm()%></span></td>
			<td  align="center"><span class="style3"><%=obj.getIndividual_avg()%></span></td>
			<td  align="center"><span class="style3"><%=obj.getBase_avg()%></span></td>
			<!--<td  align="center"><%=obj.getIndividual_seq()+"/"+obj.getBase_total()%></td>-->
			<td  align="center" bgcolor="<%=seqColor%>"><span class="style3">&nbsp;</span></td>
		</tr>
<%
	}
}
else
{
%>
	<tr class="txtblue">
	  	<td  align="center" colspan="4">NO DATA FOUND!!</td>
	</tr>
<%
}
%>
</table>
<br>
<br>
<br>
<table width="60%" align="center">
	<tr>
    <td width="90%" align="center"><span class="style2">說明:排名等級</span>
    </td>
	</tr>
</table>
<table width="60%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	
	<tr>
		<td align="center" bgcolor="#3cb371">&nbsp;</td>
		<td align="center" bgcolor="#1e90ff">&nbsp;</td>
		<td align="center" bgcolor="#ffd700">&nbsp;</td>
		<td align="center" bgcolor="#ff0000">&nbsp;</td>
<!--		<td align="center" bgcolor="#FFFFFF">&nbsp;</td>-->
	</tr>
	<tr class="txtblue">
		<td width="20%" align="center" class="tablehead3">棒極了!</td>
		<td width="20%" align="center" class="tablehead3">還可以更棒!</td>
		<td width="20%" align="center" class="tablehead3">要再加油了!</td>
		<td width="20%" align="center" class="tablehead3">危險囉!</td>
        <!--		<td width="20%" align="center" class="tablehead3">未排名</td>-->
	</tr>
</table>
</body>
</html>
