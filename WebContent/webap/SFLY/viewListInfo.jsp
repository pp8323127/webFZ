<%@ page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.*,java.util.*" %>
<%

String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}
/*
String syy;
String smm;
String sdd;
String eyy;
String emm;
String edd;
*/
String flsd;
String fled;
int count = 1;
/*
syy = request.getParameter("syy");
smm = request.getParameter("smm");
sdd = request.getParameter("sdd");
eyy = request.getParameter("eyy");
emm = request.getParameter("emm");
edd = request.getParameter("edd");
flsd = sdd + "-" + smm + "-" + syy;
fled = edd + "-" + emm + "-" + eyy;
*/

flsd = request.getParameter("sdate");
fled = request.getParameter("edate");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
ConnDB cn = new ConnDB();

String sql = null;
String bgColor="#0066FF";

List sernnoAL = new ArrayList();
List fltnoAL = new ArrayList();
List fltdAL = new ArrayList();
List instnameAL = new ArrayList();
List purnameAL = new ArrayList();
Driver dbDriver = null;

try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
//sql = "select sernno, fltno, To_char(fltd,'yyyy/mm/dd') as fltd from egtstti where instempno = '" + userid + "' and fltd between  to_date('"+flsd+"','dd-mm-yyyy') and to_date('"+fled+"','dd-mm-yyyy') order by sernno desc";
sql = "select sernno, fltno, To_char(fltd,'yyyy/mm/dd') as fltd, instname,  purname from egtstti where  fltd between  to_date('"+flsd+"','yyyy/mm/dd') and to_date('"+fled+"','yyyy/mm/dd') order by fltd desc";
rs = stmt.executeQuery(sql);

while(rs.next()){
	sernnoAL.add(rs.getString("sernno"));
	fltnoAL.add(rs.getString("fltno"));
	fltdAL.add(rs.getString("fltd"));
	instnameAL.add(rs.getString("instname"));
	purnameAL.add(rs.getString("purname"));

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
<title>ViewListInfo</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style2 {font-family: Arial, Helvetica, sans-serif; color: #FFFFFF; }
.style3 {
	font-size: 14px;
	font-weight: bold;
}
.style4 {
	font-size: 12pt;
	font-weight: bold;
}
.style5 {
	font-family: Arial, Helvetica, sans-serif;
	color: #FFFFFF;
	font-size: 12pt;
	font-weight: bold;
}
.style6 {color: #000000}
.style7 {font-size: 14px}
.style8 {font-size: 14px; color: #0000FF; }
.style9 {
	font-size: 12;
	color: #000000;
}
-->
</style>
</head>

<body>

<table width="50%" border="0" align="center" class="table_no_border">
		<tr>
			<td class="txtblue"><div align="center" class="style7 style3" span>Please click the <u>Flight No</u> LINK to view the list!
	      </div></td>
		</tr>
</table>

<table width="70%" border="0" align="center" class="tablebody">
<tr bgcolor="<%=bgColor%>">
  <td width="25%" class="table_head">
    <div align='center' class="style5">Flight Date</div>
  </td>
  <td width="20%" class="table_head">
    <div align='center' class="style5">Inspector</div>
  </td>
  <td width="20%" class="table_head"><div align='center' class="style5">CM</div></td>
  <td width="35%" class="table_head style2"><div align="center" class="style4">Flight NO.</div></td> 
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
  <td  Align="Center" class="txtblue style7 style6"><%=fltdAL.get(i)%></td>
  <td  Align="Center" class="tablebody style9"><%=instnameAL.get(i)%></td> 
  <td  Align="Center" class="tablebody style9"><%=purnameAL.get(i)%></td>    
  <td  Align="left" class="txtblue"><div align="center" class="style8"><a href="viewListDetail.jsp?sernno=<%=sernnoAL.get(i)%>"><%=fltnoAL.get(i)%></a></div></td>
</tr>
<%}
}else{
	out.print("<tr bgcolor='#F2B9F1'><td colspan=4 class='table_head'><div align='center'>NO DATA !!</div></td>");
}
%>
</table>
</form>
</body>
</html>