<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,tool.ReplaceAll,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
}

String qa = null;
String comm = null;
String process = null;
String sernno = null;

sernno = request.getParameter("sernno");  //±µ¤W­¶ªºÁôÂÃ input ­È


Connection conn = null;
PreparedStatement pstmt = null;


ResultSet rs = null;
String sql  = null;

ConnDB cn = new ConnDB();
Driver dbDriver = null;

try
{
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	qa = request.getParameter(sernno+"qa");
	comm = request.getParameter(sernno+"comm");
    process = request.getParameter(sernno+"process");
			
	//sql = " update egtstti set qa='"+qa+"', comm='"+comm+"', process='"+process+"' where sernno='"+sernno+"' ";
	//stmt.executeUpdate(sql); 

	sql = "update egtstti set qa=?, comm=?, process=? where sernno=? ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, qa);
	pstmt.setString(2, comm);
	pstmt.setString(3, process);
	pstmt.setString(4, sernno);
    pstmt.executeUpdate();
%>

			<!--	<script language=javascript>
				alert(" Please use VIEW CABIN SAFETY CHECK LIST function \n to VIEW / PRINT the list !!");
				</script>-->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>check list insert</title>
<link href="style.css" rel="stylesheet" type="text/css">
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
    <td><p align="left" class="style3"><strong></strong> <span class="style4"><strong>&nbsp;</strong></span><span class="txttitletop"><strong>Cabin Safety Check List</strong> Update Completed!</span></p>
    <p align="left"> <span class="style4">&nbsp;</span><span class="txtblue">Please use <a href="#" onClick="load('schFltDate.htm','blank.htm')" ><strong><u>View/Print &nbsp;List</u></strong></a> function to <strong>VIEW/PRINT</strong> the list!</span></p></td>
  </tr>
  <tr>
    <td><p>&nbsp;</p>
    <p>&nbsp;</p></td>
  </tr>
  <tr>
    <td height="79" align="center" valign="bottom"><p align="left" class="style4">&nbsp; <span class="style5"><br>
        </span><span class="txttitletop style10">&nbsp;(Optional)</span></p>
        <p align="left"> <span class="style4">&nbsp;&nbsp;</span><span class="txtblue">Contiune to <a href="#" onClick="load('Self_Inspect/schSelfInspDate.htm','Self_Inspect/selfInspRecomm.htm')" ><strong><u>Insert SELF INSPECTION</u></strong></a> !</span></p>
        <p align="left" class="style4">&nbsp; </p></td>
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
		try{if(rs != null) rs.close();}catch(SQLException e){}
		try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

</body>
</html>


