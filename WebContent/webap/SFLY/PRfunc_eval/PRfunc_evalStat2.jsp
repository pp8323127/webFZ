<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String base	= request.getParameter("base");
String fyy	= request.getParameter("fyy");
String sdate	= request.getParameter("sdate");
String edate	= request.getParameter("edate");

StringBuffer sb = new StringBuffer();
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>客艙經理/事務長職能評量</title>
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
-->
</style>
</head>
<body>
<table width="95%"  border="0" align="center" cellpadding="2" cellspacing="0">
  <tr>
    <td width="60%">
      <div align="right"><span class="txttitletop"><%=sdate%> ~ <%=edate%> 客艙經理/事務長職能評量 </span></div>
    </td>
	<td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="列印"></a>&nbsp;&nbsp;<input type="button" name="rep" id="rep" value="Download File" onClick="downreport();"></div></td>
  </tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td align="center" class="tablehead3"><strong>#</strong></div></td>
	  	<td align="center" class="tablehead3"><strong>EMPNO</strong></div></td>
		<td align="center" class="tablehead3"><strong>SERN</strong></div></td>
    	<td align="center" class="tablehead3"><strong>NAME</strong></div></td>
    	<td align="center" class="tablehead3"><strong>GROUP</strong></div></td>
    	<td align="center" class="tablehead3"><strong>BASE</strong></div></td>
    	<td align="center" class="tablehead3"><strong>JUN</strong></div></td>
	  	<td align="center" class="tablehead3"><strong>FEB</strong></div></td>
		<td align="center" class="tablehead3"><strong>MAR</strong></div></td>
    	<td align="center" class="tablehead3"><strong>APR</strong></div></td>
    	<td align="center" class="tablehead3"><strong>MAY</strong></div></td>
    	<td align="center" class="tablehead3"><strong>JUN</strong></div></td>
		<td align="center" class="tablehead3"><strong>JUL</strong></div></td>
    	<td align="center" class="tablehead3"><strong>AUG</strong></div></td>
    	<td align="center" class="tablehead3"><strong>SEP</strong></div></td>
    	<td align="center" class="tablehead3"><strong>OCT</strong></div></td>
    	<td align="center" class="tablehead3"><strong>NOV</strong></div></td>
		<td align="center" class="tablehead3"><strong>DEC</strong></div></td>
    	<td align="center" class="tablehead3"><strong>TTL</strong></div></td>
    	<td align="center" class="tablehead3"><strong>SCORE</strong></div></td>
  	</tr> 
<%
sb.append(sdate+" ~ "+edate+" 客艙經理/事務長職能評量統計\r\n");	
sb.append("#,EMPNO,SERN,NAME,GROUP,BASE,JUN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC,TTL,SCORE\r\n");	
%>

<%
PRFuncEval prfe = new PRFuncEval();
//prfe.getPRFuncEvalStat2(fyy,base);
prfe.getPRFuncEvalStat2(sdate,edate,base);
Hashtable objHT = new Hashtable();
ArrayList objAL = new ArrayList();
objHT = prfe.getObjHT();
objAL = prfe.getObjAL();
if(objAL.size()>0)
{
	for(int i=0; i<objAL.size(); i++)
	{
	    PRBriefEvalStatObj obj = (PRBriefEvalStatObj)objHT.get(objAL.get(i));
%>
	<tr class="txtblue">
	  	<td  align="center"><%=i+1%></td>
	  	<td  align="center"><%=obj.getPurempno()%></td>
	  	<td  align="center"><%=obj.getPursern()%></td>
	  	<td  align="center" ><%=obj.getPurname()%></td>
	  	<td  align="center" ><%=obj.getPurgrp()%></td>
		<td  align="center" ><%=obj.getBase()%></td>
		<td  align="center"><%=obj.getMyHT().get("01")%></td>
		<td  align="center"><%=obj.getMyHT().get("02")%></td>
		<td  align="center"><%=obj.getMyHT().get("03")%></td>
		<td  align="center"><%=obj.getMyHT().get("04")%></td>
		<td  align="center"><%=obj.getMyHT().get("05")%></td>
		<td  align="center"><%=obj.getMyHT().get("06")%></td>
		<td  align="center"><%=obj.getMyHT().get("07")%></td>
		<td  align="center"><%=obj.getMyHT().get("08")%></td>
		<td  align="center"><%=obj.getMyHT().get("09")%></td>
		<td  align="center"><%=obj.getMyHT().get("10")%></td>
		<td  align="center"><%=obj.getMyHT().get("11")%></td>
		<td  align="center"><%=obj.getMyHT().get("12")%></td>
	  	<td  align="center"><%=obj.getChk_times()%></td>
<%
	String tempstr = obj.getScore_str();
	if (tempstr != null && !"".equals(tempstr))
	{
		tempstr = tempstr.substring(0,tempstr.length()-1);
	}
%>
		<td  align="center">&nbsp;<%=tempstr%></td>
  	</tr> 
<%
sb.append((i+1)+","+obj.getPurempno()+","+obj.getPursern()+","+obj.getPurname()+","+obj.getPurgrp()+","+obj.getBase()+","+obj.getMyHT().get("01")+","+obj.getMyHT().get("02")+","+obj.getMyHT().get("03")+","+obj.getMyHT().get("04")+","+obj.getMyHT().get("05")+","+obj.getMyHT().get("06")+","+obj.getMyHT().get("07")+","+obj.getMyHT().get("08")+","+obj.getMyHT().get("09")+","+obj.getMyHT().get("10")+","+obj.getMyHT().get("11")+","+obj.getMyHT().get("12")+","+obj.getChk_times()+","+tempstr+"\r\n");	
%>
<%
	}
}
else
{
%>
	<tr class="txtblue">
	  	<td  align="center" colspan="20">NO DATA FOUND!!</td>
	</tr>
<%
}
%>
</table>
</body>
</html>
<script language="javascript" type="text/javascript">
function downreport()
{
	location.replace("report_download.jsp");
}
</script>

<%
session.setAttribute("sb",sb);	
%>