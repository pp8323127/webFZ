<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%
String empno = request.getParameter("empno");
String sno = request.getParameter("sno");
String comments = request.getParameter("comments")+" ";
String userid = (String) session.getAttribute("userid") ; //get user id if already login
String fyy = request.getParameter("fyy");
String fmm = request.getParameter("fmm");
String status = request.getParameter("status");

if (userid == null) 
{		
	response.sendRedirect("../../tsa/sendredirect.jsp");
} 
else
{

String sql = null;
String returnstr = "Y";
Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;

try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();	
	conn.setAutoCommit(false);
	sql = " update egtpick set comments=?, ed_user=?, ed_tmst = sysdate where sno = ? ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,comments);
	pstmt.setString(2,userid);
	pstmt.setString(3,sno);
	pstmt.executeUpdate(); 	
	conn.commit();
%>
		<script language=javascript>
		alert("Modify completed!!");	
		window.opener.location.href="pickskjList3.jsp?empno=<%=empno%>";	
		void(window.open('','_parent',''));
		self.close();
		</script>
<%
}
catch (Exception e)
{
	  //out.println("Error : " + e.toString() + sql);
	  returnstr = e.toString();
	  try {conn.rollback();} catch (SQLException e1) {}
%>
		<script language=javascript>
		alert("Update failed!!");	
		window.opener.location.href="pickskjList3.jsp?empno=<%=empno%>&fyy=<%=fyy%>&fmm=<%=fmm%>&status=<%=status%>";	
		void(window.open('','_parent',''));
		self.close();
		</script>
<%
}
finally
{
	try{if(rs != null) rs.close();}catch(SQLException e){}
	try{if(stmt != null) stmt.close();}catch(SQLException e){}
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
}
%>
