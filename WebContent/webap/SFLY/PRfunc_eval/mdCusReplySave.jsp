<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=big5" language="java" %>
<%    
String sernno	= request.getParameter("sernno");
String seqno	= request.getParameter("seqno");
String[] empno 	= request.getParameterValues("empno");
String[] type 	= request.getParameterValues("type");
String[] comm 	= request.getParameterValues("comm");
if(null==comm || "".equals(comm)){
%>
<script  language="javascript"  type="text/javascript">
alert("no comments."); 
self.close();
</script>
<%	
	
}
ci.db.ConnDB cn = new ci.db.ConnDB();
StringBuffer sqlsb = new StringBuffer();
Connection con = null;
ResultSet rs = null;
PreparedStatement pstmt = null;
Statement  stmt = null;
Driver dbDriver = null;
String sql ="";
String flag = "";
try
{
	cn.setORP3EGUserCP();
	dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
	con = dbDriver.connect(cn.getConnURL(), null);
	
	//connect ORT1 EG            
	//  cn.setORT1EG();
	//  Class.forName(cn.getDriver());
	//  con = DriverManager.getConnection(cn.getConnURL(),cn.getConnID(),cn.getConnPW());   
	
	con.setAutoCommit(false);   
    stmt = con.createStatement();
	sql = " delete FROM egtprfc where sernno = '"+sernno+"' and seqno = '"+seqno+"'";
    stmt.executeUpdate(sql);
    
    
	sqlsb = new StringBuffer();
	sqlsb.append("insert into egtprfc (SERNNO, seqno, itemno, feedback )");
	sqlsb.append("values (?,?,?,?)");
	
	pstmt=null;
	pstmt = con.prepareStatement(sqlsb.toString());
	for(int i=0;i<comm.length;i++){
		if(null!=comm[i]&&!"".equals(comm[i])){
			int idx=0;
			pstmt.setString(++idx, sernno);
			pstmt.setString(++idx, seqno);
			pstmt.setString(++idx, type[i]);  
			pstmt.setString(++idx, comm[i]);
			pstmt.addBatch();			
		}		 		
	}	
	pstmt.executeBatch();
	con.commit(); 
	flag = "Y";
	
}
catch(Exception e) 
{
	out.println(e.toString());
	flag="N";
	try{
		con.rollback();		
	}catch(SQLException se){
		
	}
	
}
finally 
{
try{if(rs != null) rs.close();}catch(SQLException e){}
try{if(stmt != null) stmt.close();}catch(SQLException e){}
try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
try{if(con != null) con.close();}catch(SQLException e){}
}
if(flag.equals("Y")){
%>
 <script  language="javascript"  type="text/javascript">
 alert("更新成功"); 
 //pener.location.reload(true);
 self.close();
 </script>
<%	
}else{
%>
<script  language="javascript"  type="text/javascript">
alert("更新失敗"); 
//history.back(-1);
</script>
<%	
	
}
%>
 
