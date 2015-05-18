<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@ page import="java.sql.*,ci.db.*,java.util.*"%>
<%
//update Remark Attribute Value Description 
String userid = (String) session.getAttribute("userid") ; //get user id if already login

if (userid == null) {		
	response.sendRedirect("logout.jsp");
} 

String itemNo 	= request.getParameter("itemNo");
String itemDsc  =  request.getParameter("itemDsc");

Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql = null;
ConnDB cn = new ConnDB();
Driver dbDriver = null;


try{
cn.setORP3EGUserCP();
dbDriver = (Driver) Class.forName(cn.getDriver()).newInstance();
conn = dbDriver.connect(cn.getConnURL(), null);

stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);

	//update
	sql = "update egtstrm set itemdsc='"+itemDsc+"' "+
		  "where itemno='"+itemNo+"'" ;
			
	stmt.executeUpdate(sql);
	%>
		<script language=javascript>
			alert("Update completed!!\n更新成功!!");
			//close_self("updSILIssue.jsp");
			window.opener.location.reload();
			this.window.close();
			</script>
	<%

}catch(Exception e){
	out.print(e.toString());
}finally{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}

%>