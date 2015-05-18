<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,java.util.*,ci.db.*,java.util.ArrayList" %>
<%
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("../logout.jsp");
}

String sernno     = request.getParameter("sernno");
String upduser    = request.getParameter("upduser");
String upddate    = request.getParameter("upddate");

String ccNo       = null;
String tcrew      = null;
String correct    = null;
String incomplete = null;
String crew_comm  = null;
String acomm      = null;
String itemno_rm  = null;

Connection conn   = null;
Statement stmt    = null;
Statement stmt2    = null;
ResultSet rs  = null;

String sql    = null;
String sql2    = null;

ConnDB cn = new ConnDB();
Driver dbDriver = null;

try
{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);
stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

sql = "select itemno from egtstcc where sernno='"+sernno+"' ";
rs  = stmt.executeQuery(sql);

while(rs.next())
{
	ccNo = rs.getString("itemno");
	//out.print("ccNo="+ccNo+"<br>");

	String reqItemno= rs.getString("itemno");
	//String reqItemno  = rs.getParameter("reqItemno");
	//out.print("reqItemno="+reqItemno+"<br>");
	
	tcrew      = request.getParameter(reqItemno+"tcrew");
	correct    = request.getParameter(reqItemno+"correct");
	incomplete = request.getParameter(reqItemno+"incomplete");
	crew_comm  = request.getParameter(reqItemno+"crew_comm");
	acomm      = request.getParameter(reqItemno+"acomm");
	itemno_rm  = request.getParameter(reqItemno+"rm");
	

	//���Ӫ�sql2 = " update egtstcc set tcrew='"+tcrew+"', correct='"+correct+"', incomplete='"+incomplete+"', crew_comm='"+crew_comm+"', acomm='"+acomm+"' where  sernno='"+sernno+"' and itemno='"+ccNo+"'";
	sql2 = " update egtstcc set tcrew=NVL('"+tcrew+"',0), correct=NVL('"+correct+"',0), incomplete=NVL('"+incomplete+"',0), crew_comm=NVL('"+crew_comm+"','N/A'), acomm=NVL('"+acomm+"','N/A'), itemno_rm='"+itemno_rm+"'  where sernno='"+sernno+"' and itemno='"+ccNo+"'";
	//out.print("sql2="+sql2+"<br>");  
	stmt2.executeUpdate(sql2);

}
		%>
				<script language=javascript>
				alert(" Self Inspection List Report insert completed !! ");
				</script>
		<%

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>Update Insert Self Insepction List Report Data</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
function load(w1,w2){
		parent.topFrame.location.href=w1;
		parent.mainFrame.location.href=w2;
}
</script>
<style type="text/css">
</style>
</head>
<body>
<BR>
<BR>
<BR>
<table width="80%"  border="0" align="center" class="table_no_border">
  <tr>
    <td><p align="left" class="style3"><strong>&nbsp;</strong> <span class="txttitletop"><strong>SELF INSPECTION LIST REPORT </strong> Insert Completed!</span></p>
      <p align="left"> <span class="txtblue">&nbsp;&nbsp;&nbsp;Please go to <a href="#" onClick="load('../blank.htm','selfInspectionMenu.jsp')" ><strong><u>SELF INSPECTION MENU</u></strong></a> function to &nbsp; VIEW / PRINT &nbsp; the report!</span></p></td>
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
		try{if(stmt != null) stmt.close();}catch(SQLException e){}
		try{if(stmt2 != null) stmt2.close();}catch(SQLException e){}
		try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>

</body>
</html>