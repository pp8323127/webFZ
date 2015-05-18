<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*,eg.prfe.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../FZ/sendredirect.jsp");
}

String syy = request.getParameter("syy");
String smm = request.getParameter("smm");
String sdd = request.getParameter("sdd");
String eyy = request.getParameter("eyy");
String emm = request.getParameter("emm");
String edd = request.getParameter("edd");
String bgColor = "#C6C2ED";

PRFlySafty prfs = new PRFlySafty();
prfs.getPRChkCase(syy+"/"+smm+"/"+sdd,eyy+"/"+emm+"/"+edd, userid);
ArrayList objAL = new ArrayList();
objAL = prfs.getObjAL();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>ViewPRCheckRecord</title>
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
<div align='center' class="txttitletop" >Cabin Check Record</div>
<br>
<table width="85%" border="0" align="center" class="tablebody">
<tr class="tablehead">
  <td ><div align="center" class="style12">#</div></td> 
  <td ><div align="center" class="style12">Flt date</div></td> 
  <td ><div align="center" class="style12">Sector</div></td> 
  <td ><div align="center" class="style12">Flt No.</div></td>
  <td ><div align="center" class="style12">PurName</div></td>
  <td ><div align="center" class="style12">Inspector</div></td>
  <td ><div align="center" class="style12">&nbsp;</div></td>
</tr>
<%
if(objAL.size() > 0)
{
	for(int i=0;i<objAL.size();i++)
	{
		PRFlySaftyObj obj = (PRFlySaftyObj) objAL.get(i);   
		if(i%2 ==0)
			bgColor="#C6C2ED";
		else
			bgColor="#F2B9F1";    
%>
  <tr bgcolor="<%=bgColor%>">
	  <td class="txtblue"><div align="center" class="style13"><%=i+1%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getFltd()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getTrip()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getFltno()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getPurname()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><%=obj.getInstname()%></div></td>
	  <td class="txtblue"><div align="center" class="style13"><a href="prChkReport.jsp?sernno=<%=obj.getSernno()%>"><img src="images/search.gif" width="15" height="15" border="0" alt="VIEW Report"></a></div></td>
  </tr>
<%	}
}
else
{
%>
 <tr bgcolor="<%=bgColor%>">
  <td colspan="7" class="txtblue"><div align="center" class="style13">No Data Found!!</div></td>
 </tr>
<%	
}
%>
</table>
</body>
</html>