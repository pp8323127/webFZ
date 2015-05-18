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
String sernno = request.getParameter("sernno");
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

	sql = " update egtstti set confirm_tmst = sysdate where sernno ='"+sernno+"'";
	stmt.executeUpdate(sql); 	
%>
		<script language=javascript>			
		window.location.href="../FZ/PRAC/PRSel.jsp";	
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
