<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%
String sGetUsr = (String) session.getAttribute("cs55.usr") ; //get user id if already login
response.setHeader("Cache-Control","no-cache");
response.setDateHeader ("Expires", 0);

if (session.isNew() || sGetUsr == null) 
{		//check user session start first
  %> <jsp:forward page="../sendredirect.jsp" /> <%
}

String[] empno = request.getParameterValues("empno");
String[] ops = request.getParameterValues("ops");

String year = request.getParameter("year");
String month = request.getParameter("month");
String inempno = request.getParameter("inempno");

String sql = null;
boolean t = true;

Driver dbDriver = null;
Connection conn = null;
Statement stmt = null;
ResultSet myResultSet = null;

ConnDB cn = new ConnDB();

try{
	cn.setDFUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);
	
	sql = "update dfdb.dftcrec set ops=? where yy=? and mm=? and fleet_cd='OPS' and staff_num=?";
	
	PreparedStatement pstmt = conn.prepareStatement(sql); 
	for(int i=0; i<empno.length; i++){
		pstmt.setInt(1, Integer.parseInt(ops[i])); 
		pstmt.setInt(2, Integer.parseInt(year)); 
		pstmt.setInt(3, Integer.parseInt(month)); 
		pstmt.setInt(4, Integer.parseInt(empno[i])); 
		pstmt.addBatch(); 
	}
	pstmt.executeBatch(); 
}
catch (Exception e)
{
	  out.println(e.toString() + sql);
	  t = false;
}
finally
{
	try{if(myResultSet != null) myResultSet.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
if(t && "N".equals(inempno)) {
	response.sendRedirect("crewops_edit.jsp?year="+year+"&month="+month+"&empno=&f=s");
}
else{
	response.sendRedirect("crewops_edit.jsp?year="+year+"&month="+month+"&empno="+inempno+"&f=s");
}
%>
