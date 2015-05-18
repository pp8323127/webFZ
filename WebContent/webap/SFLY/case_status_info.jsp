<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,eg.prfe.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("logout.jsp");
}

String flsd  =   request.getParameter("sdate");
String fled  =   request.getParameter("edate");
String syy  =   "";
String smm  =   "";
String sdd  =   "";
String eyy  =   "";
String emm  =   "";
String edd  =   "";

if(flsd != null && !"".equals(flsd))
{
	 syy  =   flsd.substring(0,4);
	 smm  =   flsd.substring(5,7);
	 sdd  =   flsd.substring(8,10);
	 eyy  =   fled.substring(0,4);
	 emm  =   fled.substring(5,7);
	 edd  =   fled.substring(8,10);
}
else
{
	 syy  =   request.getParameter("syy");
	 smm  =   request.getParameter("smm");
	 sdd  =   request.getParameter("sdd");
	 eyy  =   request.getParameter("eyy");
	 emm  =   request.getParameter("emm");
	 edd  =   request.getParameter("edd");
}

String bgColor = "#C6C2ED";

PRFlySafty prfs = new PRFlySafty();
prfs.getCaseStatus(syy+"/"+smm+"/"+sdd,eyy+"/"+emm+"/"+edd);
ArrayList objAL = new ArrayList();
objAL = prfs.getObjAL();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>ViewCaseStatusInfo</title>
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
</head>

<body>
<div align='center' class="txttitletop" >Case status</div>
<br>
<table width="95%" border="0" align="center" class="tablebody">
<tr class="tablehead">
  <td ><div align="center" class="style12">#</div></td> 
  <td ><div align="center" class="style12">Flt date</div></td> 
  <td ><div align="center" class="style12">Sector</div></td> 
  <td ><div align="center" class="style12">Flt No.</div></td>
  <td ><div align="center" class="style12">CM_Name</div></td>
  <td ><div align="center" class="style12">Inspector</div></td>
  <td ><div align="center" class="style12">Cabin<br>Safty<br>Check</div></td>
  <td ><div align="center" class="style12">Self<br>Insp</div></td>
  <td ><div align="center" class="style12">Func<br>Eval</div></td>
  <td ><div align="center" class="style12">CaseClose</div></td>
  <td ><div align="center" class="style12">Confirm</div></td>
</tr>
<%
if(objAL.size() > 0)
{
	for(int i=0;i<objAL.size();i++)
	{
		PRFlySaftyObj obj = (PRFlySaftyObj) objAL.get(i);   
		if(i%2 ==0)
			bgColor="#C6C2ED";
			//bgColor="";
		else
			bgColor="#F2B9F1";    
%>
  <tr bgcolor="<%=bgColor%>">
	  <td class="txtblue"><%=i+1%></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getFltd()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getTrip()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getFltno()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getPurname()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getInstname()%></div></td>
<%
if("Y".equals(obj.getFly_safty()))
{
%>
	<td class="txtblue"><div align="center" class="style13"><img src="images/check.jpg" width="16" height="16" border="0"></div></td>
<%
}
else
{
%>
	  <td class="txtblue"><div align="center" class="style13"><img src="images/unchecked.jpg" width="16" height="16" border="0"></div></td>
<%
}	
%>
<%
if("Y".equals(obj.getSelf_insp()))
{
%>
	<td class="txtblue"><div align="center" class="style13"><img src="images/check.jpg" width="16" height="16" border="0"></div></td>
<%
}
else
{
%>
	  <td class="txtblue"><div align="center" class="style13"><img src="images/unchecked.jpg" width="16" height="16" border="0"></div></td>
<%
}	
%>
<%
if("Y".equals(obj.getFunc_eval()))
{
%>
	<td class="txtblue"><div align="center" class="style13"><img src="images/check.jpg" width="16" height="16" border="0"></div></td>
<%
}
else
{
%>
	  <td class="txtblue"><div align="center" class="style13"><img src="images/unchecked.jpg" width="16" height="16" border="0"></div></td>
<%
}	
%>

<%
if(!"".equals(obj.getClose_tmst()) && obj.getClose_tmst() != null)
{
%>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getClose_tmst()%></div></td>
<%
}
else
{
%>
	  <td class="txtblue"><div align="center" class="style13"><a href="#"  onClick="window.open('doCaseClose.jsp?sernno=<%=obj.getSernno()%>&purempno=<%=obj.getPurempno()%>&syy=<%=syy%>&smm=<%=smm%>&sdd=<%=sdd%>&eyy=<%=eyy%>&emm=<%=emm%>&edd=<%=edd%>','CaseClose','left=800,top=800,width=10,height=10,scrollbars=yes');">Case close</a></div></td>
<%
}	
%>

<%
if(!"".equals(obj.getConfirm_tmst()) && obj.getConfirm_tmst() != null)
{
%>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getConfirm_tmst()%></div></td>
<%
}
else
{
%>
	  <td class="txtblue"><div align="center" class="style13">�|���T�{</a></div></td>
<%
}	
%>
  </tr>
<%	}
}
else
{
%>
 <tr bgcolor="<%=bgColor%>">
  <td colspan="11" class="txtblue"><div align="center" class="style13">No Data Found!!</div></td>
 </tr>
<%	
}
%>
</table>
</body>
</html>