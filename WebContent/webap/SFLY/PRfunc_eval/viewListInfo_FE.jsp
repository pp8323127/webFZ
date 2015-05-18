<%@page import="fz.psfly.isNewCheckForSFLY"%>
<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) 
{		
	response.sendRedirect("../logout.jsp");
}

String flsd  =   request.getParameter("sdate");
String fled  =   request.getParameter("edate");

String syy  =   flsd.substring(0,4);
String smm  =   flsd.substring(5,7);
String sdd  =   flsd.substring(8,10);

String eyy  =   fled.substring(0,4);
String emm  =   fled.substring(5,7);
String edd  =   fled.substring(8,10);
int count = 1;
int countCC = 0;

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
List purgrpAL = new ArrayList();
List instnameAL = new ArrayList();
List fe_scoreAL = new ArrayList();

isNewCheckForSFLY check = new isNewCheckForSFLY();
boolean isNew = false;

Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);

//可以看別人的 
if(userid.equals("643937"))
{
sql = "select sernno, trip,  fltno, purname, cb.GROUPS grp, To_char(fltd,'yyyy/mm/dd') as fltd, instname, fe_score from egtstti ti, egtcbas cb where  sernno in (select sernno from egtstcc) and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') AND ti.pursern = cb.sern order by fltd desc";
}
//sql = "select sernno, trip,  fltno, purname, To_char(fltd,'yyyy/mm/dd') as fltd, fe_score from egtstti where fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by fltd";

sql = " select sernno, trip,  fltno, purname, cb.GROUPS grp, To_char(fltd,'yyyy/mm/dd') as fltd, instname, fe_score from egtstti ti, egtcbas cb where fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') AND ti.pursern = cb.sern order by fltd";


//instempno = '" + userid + "' and 
//out.print("sql="+sql+"<br>");
//sql = "select sernno, trip,  fltno, purname, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where instempno = '" + userid + "' and sernno in (select sernno from egtstcc) and fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by sernno desc";


rs = stmt.executeQuery(sql);

while(rs.next())
{
	sernnoAL.add(rs.getString("sernno"));
	tripAL.add(rs.getString("trip"));
	fltnoAL.add(rs.getString("fltno"));
	fltdAL.add(rs.getString("fltd"));
	purnameAL.add(rs.getString("purname"));
	purgrpAL.add(rs.getString("grp"));
	instnameAL.add(rs.getString("instname"));
	fe_scoreAL.add(rs.getString("fe_score"));
}


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
<div align='center' class="txttitletop" >CM/PR Evaluation Report Edit</div>
<br>
<table width="80%" border="0" align="center" class="tablebody">
<tr class="tablehead">
  <td width="13%" class="table_head">
    <div align='center' class="style2"><strong>Flight Date</strong></div>
  </td>
  <td width="17%" ><div align="center" class="style12">Sector</div></td> 
  <td width="10%" ><div align="center" class="style12">Flight NO.</div></td>
  <td width="16%" ><div align="center" class="style12">CM/PR Name(Group)</div></td>
  <td width="12%" ><div align="center" class="style12">Inspector</div></td>
  <td width="8%" ><div align="center" class="style12">Score</div></td>
  <td width="12%" ><div align="center" class="style12">View Report </div></td>
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
  <td width="17%" Align="left" class="txtblue"><div align="center" class="style13"><%=tripAL.get(i)%></div></td>
  <td width="10%" Align="left" class="txtblue"><div align="center" class="style13"><%=fltnoAL.get(i)%></div></td>
  <td width="16%" Align="left" class="txtblue"><div align="center" class="style13"><%=purnameAL.get(i)%>(<%=purgrpAL.get(i)%>)</div></td>
  <td width="12%" Align="left" class="txtblue"><div align="center" class="style13"><%=instnameAL.get(i)%></div></td>
  <td width="8%" Align="left" class="txtblue"><div align="center" class="style13"><%=fe_scoreAL.get(i)%></div></td>
  	<%
	sql2="select count(sernno) as countCC from egtprfe where sernno='"+sernnoAL.get(i)+"' ";
	rs2= stmt2.executeQuery(sql2);
	if(rs2 != null)
  	{
  		while(rs2.next())
		{
			countCC = rs2.getInt("countCC");
		}
	}
	if(countCC >0)
	{//already has data
	isNew = check.checkTime("", fltdAL.get(i).toString());//yyyy/mm/dd  default 2014/11/01
		if(isNew){
	%>
  	<td width="12%" Align="center" valign="middle"><a href="viewPRFE_2.jsp?sernno=<%=sernnoAL.get(i)%>" target="_self"><img src="../images/search.gif" width="15" height="15" border="0" alt="View Report"></a></td>
  	<%
		}else{
  	%>
  	<td width="12%" Align="center" valign="middle"><a href="viewPRFE.jsp?sernno=<%=sernnoAL.get(i)%>" target="_self"><img src="../images/search.gif" width="15" height="15" border="0" alt="View Report"></a></td>
  	<%
  		}
	}
	else
	{
	%>
	<td width="12%" class="txtred" align="center">&nbsp;尚未編輯</td>
	<%	
	}
	%>
  </tr>
<%}
}//if(sernnoAL.size() != 0)
else
{
	out.print("<tr bgcolor='#F2B9F1'><td colspan=6 class='table_head'><div align='center'>NO DATA !!</div></td>");
	out.print("<tr bgcolor='#C6C2ED'><td colspan=6 class='table_head'><div align ='center' class='style4'><img src='../images/Ball2.gif' width='15' height='15' border='0'>Before Edit CM/PR Evaluation, </div><div align='center' class='style4'>Please Edit CABIN SAFETY CHECK LIST REPORT First !!</div></td></tr>");
}
%>
</table>
<br>
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