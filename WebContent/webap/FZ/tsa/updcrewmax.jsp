<%@page contentType="text/html; charset=big5" language="java" import="java.sql.*,ci.db.ConnDB"%>
<html>
<head>
<title>Crew ReqFlt AL Max Update</title>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<link href="../menu.css" rel="stylesheet" type="text/css">
</head>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
	response.sendRedirect("sendredirect.jsp");
} 

String[] empno = request.getParameterValues("empno");
String[] cmax = request.getParameterValues("cmax");
String empno1 = request.getParameter("empno1");
String fleet = request.getParameter("fleet");
String job = request.getParameter("job");
boolean t = false;

for(int i=0; i<empno.length; i++){
	out.println(empno[i]+","+cmax[i]);
}

Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;

try{
	ConnDB cn = new ConnDB();
	cn.setORP3FZAP();
	Class.forName(cn.getDriver());
	conn = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());

	String strqry="update fztckpl set reqfltalmax=? where empno=?"; 
	PreparedStatement pstmt = conn.prepareStatement(strqry); 
	for(int i=0; i<empno.length; i++){
		pstmt.setString(1, cmax[i]); 
		pstmt.setString(2, empno[i]); 
		pstmt.addBatch(); 
	}
	pstmt.executeBatch(); 
}
catch (Exception e)
{
	  out.println(e.toString());
	  t = true;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(!t) response.sendRedirect("crewmax.jsp?empno1="+empno1+"&fleet="+fleet+"&job="+job+"&t=1");
%>
<body>
</body>
</html>