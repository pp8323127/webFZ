<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*,tool.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title>
</head>
<body>
<%
String sGetUsr = (String) session.getAttribute("userid") ; //get user id if already login
String yyyymm = request.getParameter("yyyymm");
String sql = null;
Connection conn = null;
Statement stmt = null;
Driver dbDriver = null;
ConnDB cn = new ConnDB();
try
{
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	stmt = conn.createStatement();  

	sql = " update egtprbe set confirm_tmst = sysdate where purempno = '"+sGetUsr+"' and brief_dt between To_Date('"+yyyymm+"/01','yyyy/mm/dd') and last_day(To_Date('"+yyyymm+"/01','yyyy/mm/dd')) ";
	stmt.executeUpdate(sql); 	
%>
		<script language=javascript>			
		window.location.href="../../FZ/PRAC/PRSel.jsp";	
		</script>
<%			
}
catch (Exception e)
{
	  out.println("Error : " + e.toString() + sql);
}
finally
{
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
%>
</body>
</html>
