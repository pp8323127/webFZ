<%@page import="fz.psfly.QueryListObj"%>
<%@page import="fz.psfly.QueryListbyType"%>
<%@page import="fz.psfly.PSFlySelfIns"%>
<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}


int count = 1;
int countCC = 0;
String flsd  =   request.getParameter("sdate");
String fled  =   request.getParameter("edate");

String syy  =   flsd.substring(0,4);
String smm  =   flsd.substring(5,7);
String sdd  =   flsd.substring(8,10);

String eyy  =   fled.substring(0,4);
String emm  =   fled.substring(5,7);
String edd  =   fled.substring(8,10);

Connection conn = null;
ConnDB cn = new ConnDB();
Statement stmt = null;
ResultSet rs = null;
String sql = null;

Driver dbDriver = null;
String bgColor="#0066FF";
QueryListbyType query = new QueryListbyType();
query.QueryList("C", flsd, fled, userid);
//C:evaluation 
ArrayList objAL = query.getObjAL();
try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>ViewListInfo</title>
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
<div align='center' class="txttitletop" >CM Evaluation Report Edit</div>
<br>
<table width="80%" border="0" align="center" class="tablebody">
<tr class="tablehead">
  <td width="13%" class="table_head">
    <div align='center' class="style2"><strong>Flight Date</strong></div>
  </td>
  <td width="26%" ><div align="center" class="style12">Sector</div></td> 
  <td width="25%" ><div align="center" class="style12">Flight NO.</div></td>
  <td width="12%" ><div align="center" class="style12">CM_Name</div></td>
  <td width="12%" ><div align="center" class="style12">Insert Report </div></td>
  <td width="12%" ><div align="center" class="style12">Modify Report</div></td>
</tr>
<%
if(objAL.size() != 0)
{
	for(int i=0;i<objAL.size();i++)
	{
		if(i%2 ==0)
			bgColor="#C6C2ED";
		else
			bgColor="#F2B9F1";
		QueryListObj obj = (QueryListObj)objAL.get(i);
	
%>
<tr bgcolor="<%=bgColor%>">
  <td width="13%" Align="Center" bgcolor="<%=bgColor%>" class="txtblue"><%=obj.getFltd()%></td>
  <td width="26%" Align="left" class="txtblue"><div align="center" class="style13"><%=obj.getTrip()%></div></td>
  <td width="25%" Align="left" class="txtblue"><div align="center" class="style13"><%=obj.getFltno()%></div></td>
  <td width="12%" Align="left" class="txtblue"><div align="center" class="style13"><%=obj.getPurname()%></div></td>
  	<%
	sql="select count(sernno) as countCC from egtprfe where sernno='"+obj.getSernno()+"'";
	rs= stmt.executeQuery(sql);
	if(rs != null)
  	{
  		while(rs.next())
		{
			countCC = rs.getInt("countCC");
		}
	}
	
	
	if(countCC >0)
	{//already has data
		if(obj.isNew()){
			%>
		  	<td width="12%" Align="center" valign="middle"></td>
		  	<td width="12%" Align="center" valign="middle"><a href="modPRFE_2.jsp?sernno=<%=obj.getSernno()%>&syy=<%=syy%>&smm=<%=smm%>&sdd=<%=sdd%>&eyy=<%=eyy%>&emm=<%=emm%>&edd=<%=edd%>" target="_self"><img src="../images/list.gif" width="18" height="18" border="0" alt="Modify Report"></a></td>
		  	<%
		}else{
			%>
		  	<td width="12%" Align="center" valign="middle"></td>
		  	<td width="12%" Align="center" valign="middle"><a href="modPRFE.jsp?sernno=<%=obj.getSernno()%>&syy=<%=syy%>&smm=<%=smm%>&sdd=<%=sdd%>&eyy=<%=eyy%>&emm=<%=emm%>&edd=<%=edd%>" target="_self"><img src="../images/list.gif" width="18" height="18" border="0" alt="Modify Report"></a></td>
		  	<%	
		}
  	
	}
	else
	{//first edit
		if(obj.isNew()){
			%>
		  	<td width="12%" Align="center" valign="middle"><a href="edPRFE_2.jsp?sernno=<%=obj.getSernno()%>&fltno=<%=obj.getFltno()%>&fltd=<%=obj.getFltd()%>&trip=<%=obj.getTrip()%>&acno=<%=obj.getAcno()%>&fleet=<%=obj.getFleet()%>&purName=<%=obj.getPurname() %>&instEmpno=<%=obj.getInstempno() %>&syy=<%=syy%>&smm=<%=smm%>&sdd=<%=sdd%>&eyy=<%=eyy%>&emm=<%=emm%>&edd=<%=edd%>" target="_self"><img src="../images/edit.gif" width="18" height="18" border="0" alt="Insert Report"></a></td>
		  	<td width="12%" Align="center" valign="middle"></td>
			<%
		}else{
			%>
		  	<td width="12%" Align="center" valign="middle"><a href="edPRFE.jsp?sernno=<%=obj.getSernno()%>&fltno=<%=obj.getFltno()%>&fltd=<%=obj.getFltd()%>&syy=<%=syy%>&smm=<%=smm%>&sdd=<%=sdd%>&eyy=<%=eyy%>&emm=<%=emm%>&edd=<%=edd%>" target="_self"><img src="../images/edit.gif" width="18" height="18" border="0" alt="Insert Report"></a></td>
		  	<td width="12%" Align="center" valign="middle"></td>
			<%
		}
	}	
	%>
  </tr>
</table>
<table width="80%"  border="0" align="center">
<%
}
}
else
{
	out.print("<tr bgcolor='#F2B9F1'><td colspan=6 class='table_head'><div align='center'>NO DATA !!</div></td>");
	out.print("<tr bgcolor='#C6C2ED'><td colspan=6 class='table_head'><div align ='center' class='style4'><img src='../images/Ball2.gif' width='15' height='15' border='0'>Before Edit CM Evaluation, </div><div align='center' class='style4'>Please Edit CABIN SAFETY CHECK LIST REPORT First !!</div></td>");
}

%>
</table>
<br>

</body>
</html>
<%
}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}				
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>