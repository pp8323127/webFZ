<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%
String empno = request.getParameter("empno");
String sdate = request.getParameter("sdate");
String edate = request.getParameter("edate");
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

	sql = " insert into egtpick (sno, empno, new_tmst, reason, valid_ind, sdate, edate, comments, ef_user, ef_tmst) values  ((select Nvl(Max(sno),0)+1 from egtpick),?,sysdate,'1','Y',to_date(?,'yyyy/mm/dd'),to_date(?,'yyyy/mm/dd'),?,?, sysdate) ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,empno);
	pstmt.setString(2,sdate);
	pstmt.setString(3,edate);
	pstmt.setString(4,"New :"+userid+" "+comments);
	pstmt.setString(5,userid);
	pstmt.executeUpdate(); 	
%>
		<script language=javascript>
		alert("Insert completed!!");	
		window.location.href="pickskjList2.jsp?empno=<%=empno%>";	
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
