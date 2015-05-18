<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%
String empno = request.getParameter("empno");
String edate = request.getParameter("edate");
String reason = request.getParameter("reason");
String comments = request.getParameter("comments");
String userid = (String) session.getAttribute("userid") ; //get user id if already login
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
try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();	

	sql = " insert into egtcrdt (sno, empno, reason, comments, edate, used_ind, upduser, upddate, newuser, newdate) values  ((select Nvl(Max(sno),0)+1 from egtcrdt),?,?,?,to_date(?,'yyyy/mm/dd'),'N',?, sysdate,?,sysdate) ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,empno);
	pstmt.setString(2,reason);
	pstmt.setString(3,comments);
	pstmt.setString(4,edate);
	pstmt.setString(5,userid);
	pstmt.setString(6,userid);
	pstmt.executeUpdate(); 	
%>
		<script language=javascript>
		alert("Insert completed!!");	
		window.location.href="creditList.jsp?empno=<%=empno%>";	
		</script>
<%
}
catch (Exception e)
{
	  out.println("Error : " + e.toString() + sql);
	  returnstr = e.toString();
}
finally
{
	try{if(pstmt != null) pstmt.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
}
%>
