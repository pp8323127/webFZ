<%@ page contentType="text/html; charset=big5" language="java" import="apis.*,java.sql.*,ci.db.*,java.util.*,java.io.*, java.text.*,java.math.*" %>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title></title></head><body></body></html>
<%
int resultCount = 0;
Connection conn = null;
Statement stmt  = null;
ResultSet rs    = null;
DB2Conn cn = new DB2Conn();
Driver dbDriver = null;
String sql      = null;
try{

	cn.setEGUserCP();	
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);	
	stmt = conn.createStatement();	
    sql = "SELECT pass_no from egtpass WHERE empno='631201'";
	rs = stmt.executeQuery(sql); 	
	if(rs != null){
	   while (rs.next()){
		  out.println("~~~"+rs.getString("pass_no"));			 
	   }//while
	}//if

	
	/* DB2 test
	cn.setDB2UserCP();	
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);	
	stmt = conn.createStatement();	
  	sql = "SELECT fname FROM cal.dftapis WHERE fdate='091224' and fltno='0752' and occu='CA';";
    rs = stmt.executeQuery(sql); 	
	if(rs != null){
	   while (rs.next()){
		  out.println("~~~"+rs.getString("fname"));			 
	   }//while
	}//if
	*/		
}catch(Exception e){
	if(resultCount == 0){
	   out.println("failed.");
	}//if
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}//try
%>