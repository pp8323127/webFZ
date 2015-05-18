<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
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
Statement stmt2 = null;

ResultSet rs = null;
ResultSet rs2 = null;

String sql = null;
String sql2 = null;
String bgColor="#0066FF";

List sernnoAL = new ArrayList();
List tripAL = new ArrayList();
List fltnoAL = new ArrayList();
List fltdAL = new ArrayList();
List purnameAL = new ArrayList();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
if("643937".equals(userid)){
	//可以看別人的 
	sql = "select sernno, trip,  fltno, purname, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where  sernno in (select sernno from egtstcc) and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by fltd desc";
	
}else{
sql = "select sernno, trip,  fltno, purname, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where instempno = '" + userid + "' and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by fltd";
}//out.print("sql="+sql+"<br>");
//sql = "select sernno, trip,  fltno, purname, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where instempno = '" + userid + "' and sernno in (select sernno from egtstcc) and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by sernno desc";
//可以看別人的 
//sql = "select sernno, trip,  fltno, purname, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where  sernno in (select sernno from egtstcc) and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by fltd desc";
rs = stmt.executeQuery(sql);

while(rs.next()){
	sernnoAL.add(rs.getString("sernno"));
	tripAL.add(rs.getString("trip"));
	fltnoAL.add(rs.getString("fltno"));
	fltdAL.add(rs.getString("fltd"));
	purnameAL.add(rs.getString("purname"));

}
isNewCheckForSFLY check = new isNewCheckForSFLY();
boolean isNew = false;

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
<div align='center' class="txttitletop" >SELF INSPECTION LIST EDIT</div>
<br>
<table width="80%" border="0" align="center" class="tablebody">
<tr class="tablehead">
  <td width="13%" class="table_head">
    <div align='center' class="style2"><strong>Flight Date</strong></div>
  </td>
  <td width="26%" ><div align="center" class="style12">Sector</div></td> 
  <td width="25%" ><div align="center" class="style12">Flight NO.</div></td>
  <td width="12%" ><div align="center" class="style12">CM/PR Name</div></td>
  <td width="12%" ><div align="center" class="style12">Insert Report </div></td>
  <td width="12%" ><div align="center" class="style12">Modify Report</div></td>
</tr>
<%
if(sernnoAL.size() != 0)
{
	for(int i=0;i<sernnoAL.size();i++)
	{
		if(i%2 ==0)
			bgColor="#C6C2ED";
		else
			bgColor="#F2B9F1";
		
	
%>
<tr bgcolor="<%=bgColor%>">
  <td width="13%" Align="Center" bgcolor="<%=bgColor%>" class="txtblue"><%=fltdAL.get(i)%></td>
  <td width="26%" Align="left" class="txtblue"><div align="center" class="style13"><%=tripAL.get(i)%></div></td>
  <td width="25%" Align="left" class="txtblue"><div align="center" class="style13"><%=fltnoAL.get(i)%></div></td>
  <td width="12%" Align="left" class="txtblue"><div align="center" class="style13"><%=purnameAL.get(i)%></div></td>
  	<%
	sql2="select count(DISTINCT sernno) as countCC from egtstcc where sernno='"+sernnoAL.get(i)+"'";
	rs2= stmt2.executeQuery(sql2);
	if(rs2 != null)
  	{
  		while(rs2.next())
		{
			countCC = rs2.getInt("countCC");
		}
	}
	if(countCC >0)
	{
		isNew = check.checkTime("", fltdAL.get(i).toString());//yyyy/mm/dd  default 2014/11/01
		if(isNew){
  	%>
	  	<td width="12%" Align="center" valign="middle"></td>
	  	<td width="12%" Align="center" valign="middle"><a href="mdSILReport_2.jsp?sect=<%=tripAL.get(i) %>&sernno=<%=sernnoAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&fltd=<%=fltdAL.get(i)%>" target="_self"><img src="../images/list.gif" width="22" height="22" border="0" alt="Modify Report"></a></td>
  	<%
  		}else{
  	%>
	  	<td width="12%" Align="center" valign="middle"></td>
	  	<td width="12%" Align="center" valign="middle"><a href="mdSILReport.jsp?sernno=<%=sernnoAL.get(i)%>" target="_self"><img src="../images/list.gif" width="22" height="22" border="0" alt="Modify Report"></a></td>
  	<%	
  		}
	}
	else
	{
		if(isNew){
	%>
  	<td width="12%" Align="center" valign="middle"><a href="edSIL.jsp?sect=<%=tripAL.get(i) %>&sernno=<%=sernnoAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&fltd=<%=fltdAL.get(i)%>" target="_self"><img src="../images/edit.gif" width="18" height="18" border="0" alt="Insert Report"></a></td>
  	<td width="12%" Align="center" valign="middle"></td>
	<%
		}else{
		%>
  	<td width="12%" Align="center" valign="middle"><a href="edSIL.jsp?sernno=<%=sernnoAL.get(i)%>&fltno=<%=fltnoAL.get(i)%>&fltd=<%=fltdAL.get(i)%>" target="_self"><img src="../images/edit.gif" width="18" height="18" border="0" alt="Insert Report"></a></td>
  	<td width="12%" Align="center" valign="middle"></td>
	<%
		}
	}	
	%>
  </tr>
</table>
<table width="80%"  border="0" align="center">
<%}
}else{
	out.print("<tr bgcolor='#F2B9F1'><td colspan=6 class='table_head'><div align='center'>NO DATA !!</div></td>");
	out.print("<tr bgcolor='#C6C2ED'><td colspan=6 class='table_head'><div align ='center' class='style4'><img src='../images/Ball2.gif' width='15' height='15' border='0'>Before Edit SELF INSPECTION LIST, </div><div align='center' class='style4'>Please Edit CABIN SAFETY CHECK LIST REPORT First !!</div></td>");
}
%>
</table>
<br>
<br>
<table width="80%"  border="0" align="center">
  <tr>
    <td><p align="left" class="txtred"><strong><span class="style11">Step 1.</span> <span class="txtred">Please click <img src="../images/edit.gif" width="20" height="20" border="0"> to insert, <br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or click <img src="../images/list.gif" width="20" height="20" border="0"> to modify the SELF INSPECTION LIST REPORT.</span></strong></p>
      <p align="left" class="txtred"><strong><span class="style11">Step 2.</span> <strong>Please select the issue you need.<br>
      &nbsp;&nbsp;(You can add or modify the issue from Self Inspection Menu left side.)</strong></strong></p>
	  <p align="left" class="txtred"><strong><span class="style11">Step 3.</span> <strong>Please fill in the data of inspection.</strong></strong></p>
      <p align="left" class="txtred"><strong><span class="style11">Notice:</span> <span class="txtred">Before edit <u>SELF INSPECTION LIST REPORT </u>, 
        <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Please edit <u>CABIN SAFETY CHECK LIST REPORT</u> first !!.</span></strong></p></td>
  </tr>
</table>

<%
}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(rs2 != null) rs2.close();}catch(SQLException e){}	
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

</body>
</html>