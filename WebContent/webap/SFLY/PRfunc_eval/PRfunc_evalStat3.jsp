<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.util.*,eg.prfe.*" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String sdate	= request.getParameter("sdate");
String edate	= request.getParameter("edate");
String sect		= request.getParameter("sect");
String event_type	= request.getParameter("event_type");
StringBuffer sb = new StringBuffer();

isNewCheckForSFLY check = new isNewCheckForSFLY();
boolean isNewS = check.checkTime("", sdate);//yyyy/mm/dd			
boolean isNewE = check.checkTime("", edate);//yyyy/mm/dd			
if(!isNewS && !isNewE){
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>�ȿ��g�z¾����q(�ȫȤϬM)</title>
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
      <div align="right"><span class="txttitletop">�ȿ��g�z¾����q(�ȫȤϬM�ƶ����R) </span></div>
    </td>
	<td><div align="right"><a href="javascript:window.print()"><img src="../images/print.gif" width="17" height="15" border="0" alt="�C�L"></a>&nbsp;&nbsp;<input type="button" name="rep" id="rep" value="Download File" onClick="downreport();"></div></td>
  </tr>
</table>
<table width="95%"  border="1" align="center" cellpadding="1" cellspacing="1" class="fortable"> 
	<tr class="txtblue">
	  	<td align="center" class="tablehead3"><strong>#</strong></div></td>
	  	<td align="center" class="tablehead3"><strong>���Ȥ��</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�Z��</strong></div></td>
    	<td align="center" class="tablehead3"><strong>��q</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�y��<br>���X</strong></div></td>
		<td align="center" class="tablehead3"><strong>�ȫȩm�W</strong></div></td>
		<td align="center" class="tablehead3"><strong>�d�O</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�ϬM�ƶ�</strong></div></td>
    	<td align="center" class="tablehead3"><strong>�ƶ�����</strong></div></td>
  	</tr> 
<%
sb.append("���Ȥ��,�Z��,��q,�y�츹�X,�ȫȩm�W,�d�O,�ƶ�����/�ϬM�ƶ�\r\n");	
%>

<%
PRFuncEval prfe = new PRFuncEval();
prfe.getPRFuncEvalStat3_2(sdate,edate,sect,event_type);
ArrayList objAL = new ArrayList();
objAL = prfe.getObjAL();

if(objAL.size()>0)
{
	for(int i=0; i<objAL.size(); i++)
	{
		PRFuncEvalObj2 obj = (PRFuncEvalObj2) objAL.get(i);  
%>
	<tr class="txtblue">
	  	<td  align="center">&nbsp;<%=i+1%></td>
	  	<td  align="center">&nbsp;<%=obj.getFltd()%></td>
	  	<td  align="center">&nbsp;<%=obj.getFltno()%></td>
		<td  align="center">&nbsp;<%=obj.getSect()%></td>
		<td  align="center">&nbsp;<%=obj.getSeatno()%></td>
		<td  align="left">&nbsp;<%=obj.getCust_name()%></td>
		<td  align="left">&nbsp;<%=obj.getCust_type()%></td>
		<td  align="left">&nbsp;<%=obj.getEvent_type()%>"/"<%=obj.getEvent()%></td>
  	</tr> 
<%
sb.append(obj.getFltd()+","+obj.getFltno()+","+obj.getSect()+","+obj.getSeatno()+","+obj.getCust_name().replaceAll(",","")+","+obj.getCust_type()+","+(obj.getEvent().replaceAll(",","�A")).replaceAll("\r\n"," ")+"/"+obj.getEvent_type()+"\r\n");		
%>
<%
	}
}
else
{
%>
	<tr class="txtblue">
	  	<td  align="center" colspan="9">NO DATA FOUND!!</td>
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

}else if(isNewS && isNewE){
%>
	<script type="text/javascript">
		location.replace("PRfunc_evalStat3_2.jsp");
	</script>
<%	
}else{
%>
	<span class="txtblue">Wrong Date Period.</span>
<%
}
session.setAttribute("sb",sb);	
%>