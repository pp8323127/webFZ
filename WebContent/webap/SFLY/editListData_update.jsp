<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}
String siNo = null;
String flag =null;
String remark = null;
String itemnoRm =null;

String qa = null;
String comm = null;
String process = null;

String sernno = null;

sernno = request.getParameter("sernno");  //±µ¤W­¶ªºÁôÂÃ input ­È

Connection conn = null;
Statement stmt = null;
Statement stmt2 = null;
PreparedStatement pstmt = null;

ResultSet rs2 = null;
String sql  = null;
String sql2  = null;
String sql3  = null;

ConnDB cn = new ConnDB();
Driver dbDriver = null;



try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt2  = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

qa = request.getParameter(sernno+"qa");
comm = request.getParameter(sernno+"comm");
process = request.getParameter(sernno+"process");

//sql = " update egtstti set qa='"+qa+"', comm='"+comm+"', process='"+process+"' where sernno='"+sernno+"' ";
//out.print("sql="+sql+"<br>");
//stmt.executeUpdate(sql); 

sql = " update egtstti set qa=?, comm=?, process=? where sernno=? ";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, qa);
pstmt.setString(2, comm);
pstmt.setString(3, process);
pstmt.setString(4, sernno);
pstmt.executeUpdate();
pstmt.close();
	
sql2 = "select itemno from egtstsi where sflag= 'Y' ";
rs2  = stmt2.executeQuery(sql2);
while(rs2.next())
{
	siNo = rs2.getString("itemno");
	flag = request.getParameter(siNo);
	remark = request.getParameter(siNo.replace(".", "_")+"remark");
	itemnoRm = request.getParameter(siNo+"rm");
	
	//remark = ReplaceAll.replace(remark, "'", "''"); 

	//sql3 = "update egtstdt set flag='"+flag+"', remark='"+remark+"', itemno_rm='"+itemnoRm+"' "+ 
	//"where sernno='"+sernno+"' and itemno='"+siNo+"' ";
	//out.print("sql3="+sql3+"<br>");
	//stmt3.executeUpdate(sql3);  

	sql3 = "update egtstdt set flag=?, remark=?, itemno_rm=? "+ 
	"where sernno=? and itemno=? ";
	pstmt = conn.prepareStatement(sql3);
	pstmt.setString(1, flag);
	pstmt.setString(2, remark);
	pstmt.setString(3, itemnoRm);
	pstmt.setString(4, sernno);
	pstmt.setString(5, siNo);
    pstmt.executeUpdate();
}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>check list insert</title>
<link href ="style.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
<style type="text/css">
<!--
.style3 {color: #3366FF}
.style4 {color: #3165FF}
.style5 {
	color: #CC0066;
	font-weight: bold;
}
.style9 {color: #FF00FF}
.style10 {color: #FF0000}
-->
</style>
</head>
<br>
<br>
<table width="80%"  border="0" align="center" class="table_no_border">
  <tr>
    <td><p align="left" class="style3"><strong></strong> <span class="txttitletop"><strong>&nbsp;Cabin Safety Check List</strong> Modify Update Success !!</span></p>
      <p align="left"> <span class="style4">&nbsp;</span><span class="txtblue">Please use <a href="#" onClick="load('schFltDate.htm','blank.htm')" ><strong><u>View / Print  List</u></strong></a> function to <strong>VIEW/PRINT</strong> the list!</span></p></td>
  </tr>
  <tr>
    <td><p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td height="79" align="center" valign="bottom"><p align="left" class="style4">&nbsp; <span class="style5"><br></span>
	<span class="txttitletop style10">&nbsp;(Optional)</span></p>
	<p align="left"> 
	<span class="style4">&nbsp;</span>
	<table width="100%"  border="0" align="center" class="table_no_border">
	 <tr>
	  <td width="18%" align="left"><span class="txtblue">Contiune to </td>
	  <td width="82%" align="left"><a href="#" onClick="load('Self_Inspect/schSelfInspDate.htm','Self_Inspect/selfInspRecomm.htm')" ><strong><u>Insert SELF INSPECTION  !</u></strong></a></td>
	 </tr>
	  <tr>
	  <td align="left"><span class="txtblue">&nbsp;</td>
	  <td align="left"><a href="#" onClick="load('PRfunc_eval/PRfunc_evalEditQuery.htm','blank.htm')" ><strong><u>CM/PR Evaluation  !</u></strong></a></td>
	 </tr>
	</table>
	 </p>
  </tr>
</table>

<%
}
catch(Exception e)
{
	out.print(e.toString());
}
finally
{
		try{if(rs2 != null) rs2.close();}catch(SQLException e){}		
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}		
		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}	
		try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

</body>
</html>