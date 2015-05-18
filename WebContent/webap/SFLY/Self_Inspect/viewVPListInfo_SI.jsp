<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

int count = 1;

String flsd  =   request.getParameter("sdate");
String fled  =   request.getParameter("edate");

String syy  =   flsd.substring(0,4);
String smm  =   flsd.substring(5,7);
String sdd  =   flsd.substring(8,10);

String eyy  =   fled.substring(0,4);
String emm  =   fled.substring(5,7);
String edd  =   fled.substring(8,10);

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

String sql = null;
String bgColor="#0066FF";

List sernnoAL = new ArrayList();
List tripAL = new ArrayList();
List fltnoAL = new ArrayList();
List fltdAL = new ArrayList();
List instnameAL = new ArrayList();
Driver dbDriver = null;
isNewCheckForSFLY check = new isNewCheckForSFLY();

boolean isNew = false;
try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
//只看自己的sql = "select sernno, trip,  fltno, purname, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where instempno = '" + userid + "' and  sernno in (select sernno from egtstcc ) and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by sernno desc";
sql = "select sernno, trip,  fltno, instname, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where sernno in (select sernno from egtstcc ) and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by fltd desc";
//out.print("sql="+sql+"<br>");
rs = stmt.executeQuery(sql);

while(rs.next()){
	sernnoAL.add(rs.getString("sernno"));
	tripAL.add(rs.getString("trip"));
	fltnoAL.add(rs.getString("fltno"));
	fltdAL.add(rs.getString("fltd"));
	instnameAL.add(rs.getString("instname"));

}

}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>View List Info for VIEW/PRINT SELF INSPECTION LIST REPORT</title>
<style type="text/css">
<!--
.style2 {font-family: Arial, Helvetica, sans-serif; color: #FFFFFF; }
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
.style4 {color: #000000}
.style5 {font-size: 14}
.style7 {font-family: Arial, Helvetica, sans-serif; color: #FFFFFF; font-size: 14; }
-->
</style>
</head>

<body>
<div align='center' class="txttitletop" >VIEW / PRINT SELF INSPECTION LIST REPORT </div>
<br>
<table width="70%" border="0" align="center" class="table_no_border">
<tr class="tablehead">
  <td width="14%" class="table_head">
    <div align='center' class="style2 style5">Flight Date</div>
  </td>
  <td width="28%" ><div align="center" class="style7">Sector</div></td> 
  <td width="28%" ><div align="center" class="style7">Flight NO.</div></td>
  <td width="15%" ><div align="center" class="style7">InstName</div></td>
  <td width="15%" ><div align="center" class="style7">View / Print  Report </div></td>
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
<tr bgcolor="<%=bgColor%>" class="txtblue">
  <td width="14%"  Align="Center"><span class="style4"><%=fltdAL.get(i)%></span></td>
  <td width="28%"  Align="left"><div align="center" class="style4"><%=tripAL.get(i)%></div></td>
  <td width="28%"  Align="left"><div align="center" class="style4"><%=fltnoAL.get(i)%></div></td>
  <td width="15%"  Align="left"><div align="center" class="style4"><%=instnameAL.get(i)%></div></td>
  <td width="15%"  Align="center" valign="middle">
  

  <%
  isNew = check.checkTime("", fltdAL.get(i).toString());//yyyy/mm/dd 
  if(isNew){ %>
   <a href="vpSILReport_2.jsp?sernno=<%=sernnoAL.get(i)%>" target="_self" class="style4"><img src="../images/search.gif" width="15" height="15" border="0" alt="VIEW / PRINT Report"></a>
  <%}else{ %>
   <a href="vpSILReport.jsp?sernno=<%=sernnoAL.get(i)%>" target="_self" class="style4"><img src="../images/search.gif" width="15" height="15" border="0" alt="VIEW / PRINT Report"></a>
  <%} %>
 
  </td>
</tr>
</table>
<table width="70%" border="0" align="center" class="table_no_border">
<%}
}else{
	out.print("<tr bgcolor='#F2B9F1'><td colspan=5 class='table_head'><div align='center'>NO DATA !!</div></td>");	
}
%>
</table>
<br>
<br>
<table width="70%" border="0" align="center" class="tablebody">
  <tr>
    <td><p align="center" class="txtred"><strong> <span class="txtred">Please click <img src="../images/search.gif" width="15" height="15" border="0"> to view / print SELF INSPECTION LIST REPORT.</span></strong></p>
  </tr>
</table>
</body>
</html>
