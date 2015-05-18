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
PreparedStatement pstmt = null;
Driver dbDriver = null;
String sql      = null;
try{
	cn.setDB2UserCP();	
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	conn = dbDriver.connect(cn.getConnURL(), null);	
	stmt = conn.createStatement();	
  	sql = "INSERT INTO cal.dftapis "+
   	         "(pk, carrier, fltno, fdate, empno, lname, mname, fname, nation, issue, " +
   	         "birth, passport, gender, dest, depart, gdorder, remark, occu, dh, meal, " +
   	         "certno, certctry, flag1, flag2, flag3, passcountry, doctype, birthcity, birthcountry, resicountry, " +
   	         "resiaddr1, resiaddr2, resiaddr3, resiaddr4, resiaddr5, tvlstatus, passexp, certdoctype, certexp) " + 
           "VALUES (?,?,?,?,?,?,?,?,?,?,"+
                   "?,?,?,?,?,?,?,?,?,?,"+
                   "?,?,?,?,?,?,?,?,?,?,"+
                   "?,?,?,?,?,?,?,?,?)";
		/*				  
           "VALUES ('X','X','X','X','X','X','X','X','X','X', "+
                   "'X','X','X','X','X','X','X','X','X','X',"+
                   "'X','X','X','X','X','X','X','X','X','X',"+
                   "'X','X','X','X','X','X','X','X','X')";					  
		*/						
    pstmt = conn.prepareStatement(sql);
 	for (int j=1; j <= 39; j++){
   	   	pstmt.setString(j, "X");    	    	
   	}      		
	resultCount=pstmt.executeUpdate();	
	if(resultCount !=0){
	   out.println("successfully.");
    }//if		
}catch(Exception e){
	if(resultCount == 0){
	   out.println("failed.");
	}//if
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}//try
%>