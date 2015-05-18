<%@ page contentType="text/html; charset=big5" language="java"  %>
<%@page import="ci.db.*,java.sql.*"%>
<%
String empno = request.getParameter("empno");
String sno = request.getParameter("sno");
String comments = request.getParameter("comments")+" ";
String valid_ind = request.getParameter("valid_ind");
String sdate = request.getParameter("sdate");
String edate = request.getParameter("edate");
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
PreparedStatement pstmt2 = null;
Statement stmt = null;
ResultSet rs = null;

try
{
	ConnectionHelper ch = new ConnectionHelper();
	conn = ch.getConnection();	
	conn.setAutoCommit(false);
//sql="update egtcrdt set reason = '"+reason+"', comments='"+comments+"', edate=to_date('"+edate+"','yyyy/mm/dd'), used_ind='"+used_ind+"', intention = '"+intention+"'  where sno = '"+sno+"'";
//out.print(sql + "<br>");
	sql = " update egtpick set valid_ind = ?, comments=?, ef_user=?, ef_tmst = sysdate, sdate= to_date(?,'yyyy/mm/dd'), edate = to_date(?,'yyyy/mm/dd') where sno = ? ";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,valid_ind);
	pstmt.setString(2,comments);
	pstmt.setString(3,userid);
	pstmt.setString(4,sdate);
	pstmt.setString(5,edate);
	pstmt.setString(6,sno);
	pstmt.executeUpdate(); 	
	pstmt.clearParameters();

	String str = "";
	sql = "select credit3 from egtpick where sno = "+sno;
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	if(rs.next())
	{
		str = rs.getString("credit3");
		
		sql = "";
		sql = " update egtcrdt set used_ind = ?, comments = comments ||?, upduser=?, upddate = sysdate where sno in ("+str+") ";
		pstmt2 = conn.prepareStatement(sql);
		pstmt2.setString(1,valid_ind);
		pstmt2.setString(2,comments);
		pstmt2.setString(3,userid);
		pstmt2.executeUpdate(); 	
	}
	conn.commit();
%>
		<script language=javascript>
		alert("Modify completed!!");	
		window.opener.location.href="pickskjList2.jsp?empno=<%=empno%>";	
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
		window.opener.location.href="pickskjList2.jsp?empno=<%=empno%>";	
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
	try{if(pstmt2 != null) pstmt2.close();}catch(SQLException e){}
	try{if(conn != null) conn.close();}catch(SQLException e){}
}
}
%>
